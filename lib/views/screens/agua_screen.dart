import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../../config/theme.dart';
import '../../controllers/agua_controller.dart';
import '../../models/registro_agua.dart';

class AguaScreen extends ConsumerWidget {
  const AguaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrosAsync = ref.watch(aguaRegistrosHoyProvider);
    final totalAsync = ref.watch(aguaTotalHoyProvider);
    final progresoAsync = ref.watch(aguaProgresoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hidratación'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _mostrarConfiguracion(context, ref),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Progreso circular grande
            _buildProgresoCircular(context, ref, totalAsync, progresoAsync),
            const SizedBox(height: 32),

            // Botones rápidos
            _buildBotonesRapidos(context, ref),
            const SizedBox(height: 32),

            // Historial de hoy
            _buildHistorial(context, ref, registrosAsync),
          ],
        ),
      ),
    );
  }

  Widget _buildProgresoCircular(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<int> totalAsync,
    AsyncValue<double> progresoAsync,
  ) {
    final objetivoAsync = ref.watch(aguaObjetivoDiarioProvider);

    return totalAsync.when(
      data: (total) {
        final objetivo = objetivoAsync.maybeWhen(
          data: (obj) => obj,
          orElse: () => 2000,
        );
        final progreso = progresoAsync.maybeWhen(
          data: (p) => p,
          orElse: () => 0.0,
        );

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryColor.withValues(alpha: 0.1),
                AppTheme.secondaryColor.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Text(
                'Hidratación de hoy',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey.shade700,
                    ),
              ),
              const SizedBox(height: 24),
              // Círculo de progreso
              SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Fondo del círculo
                    CustomPaint(
                      size: const Size(200, 200),
                      painter: _CircularProgressPainter(
                        progress: 1.0,
                        color: Colors.grey.shade200,
                        strokeWidth: 16,
                      ),
                    ),
                    // Progreso
                    CustomPaint(
                      size: const Size(200, 200),
                      painter: _CircularProgressPainter(
                        progress: progreso,
                        color: _getColorForProgress(progreso),
                        strokeWidth: 16,
                      ),
                    ),
                    // Icono y texto central
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.water_drop,
                          size: 40,
                          color: _getColorForProgress(progreso),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$total ml',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                        ),
                        Text(
                          'de $objetivo ml',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Porcentaje
              Text(
                '${(progreso * 100).toInt()}% completado',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _getColorForProgress(progreso),
                    ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, _) => Center(
        child: Text('Error: $e'),
      ),
    );
  }

  Widget _buildBotonesRapidos(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Agregar agua',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildBotonCantidad(
                context,
                ref,
                250,
                Icons.local_cafe_outlined,
                'Taza',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBotonCantidad(
                context,
                ref,
                500,
                Icons.emoji_food_beverage_outlined,
                'Botella',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBotonCantidad(
                context,
                ref,
                1000,
                Icons.water_drop_outlined,
                '1 Litro',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _mostrarDialogoCantidadPersonalizada(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('Cantidad personalizada'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBotonCantidad(
    BuildContext context,
    WidgetRef ref,
    int ml,
    IconData icon,
    String label,
  ) {
    return ElevatedButton(
      onPressed: () => _registrarAgua(context, ref, ml),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            '$ml ml',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorial(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<RegistroAgua>> registrosAsync,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Historial de hoy',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        registrosAsync.when(
          data: (registros) {
            if (registros.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.water_drop_outlined,
                        size: 48,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aún no has registrado agua hoy',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: registros.length,
              itemBuilder: (context, index) {
                final registro = registros[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.water_drop,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    title: Text(
                      '${registro.cantidadMl} ml',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      _formatHora(registro.fecha),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _confirmarEliminar(context, ref, registro),
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (e, _) => Center(
            child: Text('Error: $e'),
          ),
        ),
      ],
    );
  }

  Color _getColorForProgress(double progreso) {
    if (progreso >= 1.0) {
      return Colors.green;
    } else if (progreso >= 0.5) {
      return AppTheme.primaryColor;
    } else {
      return Colors.orange;
    }
  }

  String _formatHora(DateTime fecha) {
    return '${fecha.hour.toString().padLeft(2, '0')}:${fecha.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _registrarAgua(BuildContext context, WidgetRef ref, int ml) async {
    try {
      await ref.read(aguaControllerProvider.notifier).registrarAgua(ml);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✓ Registrado: $ml ml'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _mostrarDialogoCantidadPersonalizada(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cantidad personalizada'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Cantidad (ml)',
            suffixText: 'ml',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              final ml = int.tryParse(controller.text);
              if (ml != null && ml > 0) {
                Navigator.pop(context);
                _registrarAgua(context, ref, ml);
              }
            },
            child: const Text('Registrar'),
          ),
        ],
      ),
    );
  }

  void _confirmarEliminar(
    BuildContext context,
    WidgetRef ref,
    RegistroAgua registro,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar registro'),
        content: Text('¿Eliminar ${registro.cantidadMl} ml?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await ref
                  .read(aguaControllerProvider.notifier)
                  .eliminarRegistro(registro.id);
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registro eliminado')),
                );
              }
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _mostrarConfiguracion(BuildContext context, WidgetRef ref) {
    final objetivoAsync = ref.read(aguaObjetivoDiarioProvider);
    
    objetivoAsync.when(
      data: (objetivoActual) {
        showDialog(
          context: context,
          builder: (context) => _ConfiguracionObjetivoDialog(
            objetivoActual: objetivoActual,
          ),
        );
      },
      loading: () {},
      error: (_, __) {},
    );
  }
}

// Dialog de configuración de objetivo
class _ConfiguracionObjetivoDialog extends ConsumerStatefulWidget {
  final int objetivoActual;

  const _ConfiguracionObjetivoDialog({
    required this.objetivoActual,
  });

  @override
  ConsumerState<_ConfiguracionObjetivoDialog> createState() =>
      _ConfiguracionObjetivoDialogState();
}

class _ConfiguracionObjetivoDialogState
    extends ConsumerState<_ConfiguracionObjetivoDialog> {
  late double _objetivoMl;

  @override
  void initState() {
    super.initState();
    _objetivoMl = widget.objetivoActual.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final objetivoLitros = (_objetivoMl / 1000).toStringAsFixed(1);

    return AlertDialog(
      title: const Text('Objetivo de Hidratación'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Valor actual grande
            Center(
              child: Column(
                children: [
                  Text(
                    '$objetivoLitros L',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '${_objetivoMl.toInt()} ml',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Slider
            Slider(
              value: _objetivoMl,
              min: 500,
              max: 5000,
              divisions: 90, // Cada 50ml
              label: '${_objetivoMl.toInt()} ml',
              onChanged: (value) {
                setState(() {
                  _objetivoMl = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Botones predefinidos
            Text(
              'Objetivos comunes:',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildObjetivoChip('1.5 L', 1500),
                _buildObjetivoChip('2 L', 2000),
                _buildObjetivoChip('2.5 L', 2500),
                _buildObjetivoChip('3 L', 3000),
                _buildObjetivoChip('3.5 L', 3500),
                _buildObjetivoChip('4 L', 4000),
              ],
            ),
            const SizedBox(height: 16),

            // Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: Colors.blue.shade700,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Recomendación general: 2-3 litros al día',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () async {
            final controller = ref.read(aguaControllerProvider.notifier);
            await controller.actualizarObjetivo(_objetivoMl.toInt());
            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Objetivo actualizado a ${objetivoLitros}L'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }

  Widget _buildObjetivoChip(String label, int ml) {
    final isSelected = (_objetivoMl - ml).abs() < 50;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _objetivoMl = ml.toDouble();
        });
      },
    );
  }
}

// Custom painter para el progreso circular
class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _CircularProgressPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
