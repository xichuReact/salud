import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/cronometro_controller.dart';
import '../../controllers/caminata_controller.dart';
import '../../models/caminata.dart';
import '../../config/theme.dart';

class CronometroScreen extends ConsumerWidget {
  const CronometroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cronometro = ref.watch(cronometroControllerProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 360;

    double circleDiameter = screenWidth - 64;
    if (circleDiameter < 220) {
      circleDiameter = 220;
    } else if (circleDiameter > 320) {
      circleDiameter = 320;
    }
    final gapAfterTimer = isCompact ? 32.0 : 60.0;
    final tieneSesionActiva = cronometro.corriendo || cronometro.pausado;

    final botones = <Widget>[];
    if (tieneSesionActiva) {
      botones.add(
        _buildControlButton(
          context,
          icon: Icons.refresh,
          label: 'Reiniciar',
          color: AppTheme.warningColor,
          onPressed: () {
            ref.read(cronometroControllerProvider.notifier).reiniciar();
          },
        ),
      );
    }

    botones.add(
      _buildControlButton(
        context,
        icon: cronometro.corriendo
            ? Icons.pause
            : cronometro.pausado
                ? Icons.play_arrow
                : Icons.play_arrow,
        label: cronometro.corriendo
            ? 'Pausar'
            : cronometro.pausado
                ? 'Reanudar'
                : 'Iniciar',
        color: AppTheme.accentColor,
        onPressed: () {
          final controller = ref.read(cronometroControllerProvider.notifier);
          if (cronometro.corriendo) {
            controller.pausar();
          } else if (cronometro.pausado) {
            controller.reanudar();
          } else {
            controller.iniciar();
          }
        },
        isPrimary: true,
      ),
    );

    if (tieneSesionActiva) {
      botones.add(
        _buildControlButton(
          context,
          icon: Icons.stop,
          label: 'Guardar',
          color: AppTheme.primaryColor,
          onPressed: () => _guardarCaminata(context, ref),
        ),
      );
    }

    Widget controles;
    if (isCompact) {
      controles = Wrap(
        alignment: WrapAlignment.center,
        spacing: 16,
        runSpacing: 16,
        children: botones,
      );
    } else {
      final rowChildren = <Widget>[];
      for (var i = 0; i < botones.length; i++) {
        if (i > 0) {
          rowChildren.add(const SizedBox(width: 20));
        }
        rowChildren.add(botones[i]);
      }
      controles = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowChildren,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronómetro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => _mostrarHistorial(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: circleDiameter,
                    height: circleDiameter,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor.withOpacity(0.1),
                          AppTheme.secondaryColor.withOpacity(0.1),
                        ],
                      ),
                      border: Border.all(
                        color: cronometro.corriendo
                            ? AppTheme.accentColor
                            : AppTheme.primaryColor,
                        width: 8,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cronometro.tiempoFormateado,
                            style: const TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cronometro.corriendo
                                ? 'En marcha'
                                : cronometro.pausado
                                    ? 'Pausado'
                                    : 'Listo',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: gapAfterTimer),
                  controles,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return Column(
      children: [
        Container(
          width: isPrimary ? 80 : 64,
          height: isPrimary ? 80 : 64,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              customBorder: const CircleBorder(),
              child: Icon(
                icon,
                color: Colors.white,
                size: isPrimary ? 40 : 32,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  void _guardarCaminata(BuildContext context, WidgetRef ref) {
    final controller = ref.read(cronometroControllerProvider.notifier);
    final duracion = controller.obtenerTiempoFinal();

    showDialog(
      context: context,
      builder: (context) => _DialogoGuardarCaminata(duracionSegundos: duracion),
    );
  }

  void _mostrarHistorial(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _HistorialCaminatas(),
    );
  }
}

class _DialogoGuardarCaminata extends ConsumerStatefulWidget {
  final int duracionSegundos;

  const _DialogoGuardarCaminata({required this.duracionSegundos});

  @override
  ConsumerState<_DialogoGuardarCaminata> createState() =>
      _DialogoGuardarCaminataState();
}

class _DialogoGuardarCaminataState extends ConsumerState<_DialogoGuardarCaminata> {
  final _ubicacionController = TextEditingController();
  final _notasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final minutos = widget.duracionSegundos ~/ 60;

    return AlertDialog(
      title: const Text('Guardar Caminata'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Duración'),
              trailing: Text(
                '$minutos minutos',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: _ubicacionController,
              decoration: const InputDecoration(
                labelText: 'Ubicación (opcional)',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notasController,
              decoration: const InputDecoration(
                labelText: 'Notas (opcional)',
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final caminata = Caminata()
              ..fecha = DateTime.now()
              ..duracionSegundos = widget.duracionSegundos
              ..ubicacion = _ubicacionController.text.isNotEmpty
                  ? _ubicacionController.text
                  : null
              ..notas = _notasController.text.isNotEmpty ? _notasController.text : null;

            ref.read(caminataControllerProvider.notifier).guardarCaminata(caminata);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Caminata guardada')),
            );
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _ubicacionController.dispose();
    _notasController.dispose();
    super.dispose();
  }
}

class _HistorialCaminatas extends ConsumerWidget {
  const _HistorialCaminatas();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final caminatas = ref.watch(caminatasProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Historial de Caminatas',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: caminatas.when(
              data: (caminatasList) => caminatasList.isEmpty
                  ? const Center(child: Text('No hay caminatas registradas'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: caminatasList.length,
                      itemBuilder: (context, index) {
                        final caminata = caminatasList[index];
                        final minutos = caminata.duracionSegundos ~/ 60;
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppTheme.accentColor.withOpacity(0.1),
                              child: const Icon(Icons.directions_walk,
                                  color: AppTheme.accentColor),
                            ),
                            title: Text(
                              caminata.ubicacion ?? 'Caminata',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text('$minutos minutos'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${caminata.fecha.day}/${caminata.fecha.month}',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                  onPressed: () => _confirmarEliminarCaminata(context, ref, caminata),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmarEliminarCaminata(BuildContext context, WidgetRef ref, caminata) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar caminata'),
        content: Text('¿Seguro que deseas eliminar esta caminata de ${caminata.duracionSegundos ~/ 60} minutos?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ref.read(caminataControllerProvider.notifier).eliminarCaminata(caminata.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Caminata eliminada')),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
