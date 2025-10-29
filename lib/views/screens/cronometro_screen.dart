import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/cronometro_controller.dart';
import '../../controllers/caminata_controller.dart';
import '../../models/caminata.dart';
import '../../config/theme.dart';

class CronometroScreen extends ConsumerStatefulWidget {
  const CronometroScreen({super.key});

  @override
  ConsumerState<CronometroScreen> createState() => _CronometroScreenState();
}

class _CronometroScreenState extends ConsumerState<CronometroScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = ref.read(cronometroControllerProvider.notifier);
    if (state == AppLifecycleState.resumed) {
      controller.sincronizar();
      controller.reanudarSiCorriendo();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.hidden) {
      controller.manejarPausaSistema();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
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

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _GuardarCaminataSheet(duracionSegundos: duracion),
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

class _GuardarCaminataSheet extends ConsumerStatefulWidget {
  const _GuardarCaminataSheet({required this.duracionSegundos});

  final int duracionSegundos;

  @override
  ConsumerState<_GuardarCaminataSheet> createState() =>
      _GuardarCaminataSheetState();
}

class _GuardarCaminataSheetState extends ConsumerState<_GuardarCaminataSheet> {
  final _ubicacionController = TextEditingController();
  final _notasController = TextEditingController();

  String _formatearDuracion(int totalSegundos) {
    final duration = Duration(seconds: totalSegundos);
    final horas = duration.inHours;
    final minutos = duration.inMinutes.remainder(60);
    final segundos = duration.inSeconds.remainder(60);

    if (horas > 0) {
      if (minutos == 0) return '${horas}h';
      return '${horas}h ${minutos}m';
    }
    if (minutos > 0) {
      if (segundos == 0) return '${minutos}m';
      return '${minutos}m ${segundos}s';
    }
    return '${segundos}s';
  }

  @override
  Widget build(BuildContext context) {
    final duracionFormateada = _formatearDuracion(widget.duracionSegundos);

    final media = MediaQuery.of(context);

    return SafeArea(
      top: false,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 0.75,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.directions_walk,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Guardar caminata',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Añade detalles para entender mejor tu progreso',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:
                                AppTheme.secondaryColor.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppTheme.secondaryColor
                                      .withValues(alpha: 0.18),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.timer,
                                  color: AppTheme.secondaryColor,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Duración',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    duracionFormateada,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _ubicacionController,
                          decoration: InputDecoration(
                            labelText: 'Ubicación (opcional)',
                            prefixIcon: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: AppTheme.primaryColor,
                                size: 20,
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: AppTheme.primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _notasController,
                          decoration: InputDecoration(
                            labelText: 'Notas (opcional)',
                            alignLabelWithHint: true,
                            prefixIcon: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.accentColor
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.note_alt,
                                color: AppTheme.accentColor,
                                size: 20,
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: AppTheme.accentColor,
                                width: 2,
                              ),
                            ),
                          ),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton(
                      onPressed: () async {
                        final caminata = Caminata()
                          ..fecha = DateTime.now()
                          ..duracionSegundos = widget.duracionSegundos
                          ..ubicacion = _ubicacionController.text.isNotEmpty
                              ? _ubicacionController.text
                              : null
                          ..notas = _notasController.text.isNotEmpty
                              ? _notasController.text
                              : null;

                        final navigator = Navigator.of(context);
                        final messenger = ScaffoldMessenger.of(context);

                        await ref
                            .read(caminataControllerProvider.notifier)
                            .guardarCaminata(caminata);

                        if (!mounted) return;

                        if (navigator.canPop()) {
                          navigator.pop();
                        }

                        messenger.showSnackBar(
                          SnackBar(
                            content: const Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.white),
                                SizedBox(width: 12),
                                Text('Caminata guardada'),
                              ],
                            ),
                            backgroundColor: AppTheme.primaryColor,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Guardar caminata',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                              backgroundColor:
                                  AppTheme.accentColor.withOpacity(0.1),
                              child: const Icon(Icons.directions_walk,
                                  color: AppTheme.accentColor),
                            ),
                            title: Text(
                              caminata.ubicacion ?? 'Caminata',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
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
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red, size: 20),
                                  onPressed: () => _confirmarEliminarCaminata(
                                      context, ref, caminata),
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

  void _confirmarEliminarCaminata(
      BuildContext context, WidgetRef ref, caminata) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar caminata'),
        content: Text(
            '¿Seguro que deseas eliminar esta caminata de ${caminata.duracionSegundos ~/ 60} minutos?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(caminataControllerProvider.notifier)
                  .eliminarCaminata(caminata.id);
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
