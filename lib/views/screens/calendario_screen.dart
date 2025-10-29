import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../controllers/calendario_controller.dart';
import '../../controllers/rutina_controller.dart';
import '../../config/theme.dart';
import 'package:intl/intl.dart';

class CalendarioScreen extends ConsumerWidget {
  const CalendarioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarioState = ref.watch(calendarioControllerProvider);
    final rutinas = ref.watch(rutinasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
      ),
      body: Column(
        children: [
          // Calendario
          Card(
            margin: const EdgeInsets.all(16),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: calendarioState.fechaSeleccionada,
              selectedDayPredicate: (day) =>
                  isSameDay(calendarioState.fechaSeleccionada, day),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              locale: 'es_ES',
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon: Icon(Icons.chevron_left),
                rightChevronIcon: Icon(Icons.chevron_right),
                headerPadding: EdgeInsets.symmetric(vertical: 16),
              ),
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: AppTheme.accentColor,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: TextStyle(color: Colors.grey.shade600),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                ref
                    .read(calendarioControllerProvider.notifier)
                    .seleccionarFecha(selectedDay);
              },
              onPageChanged: (focusedDay) {
                ref
                    .read(calendarioControllerProvider.notifier)
                    .cambiarMes(focusedDay);
              },
              eventLoader: (day) {
                // Retornar eventos para este día sin lanzar excepciones si no hay coincidencias
                final plan = calendarioState.planActual;
                if (plan == null) return [];
                for (final d in plan.dias) {
                  if (isSameDay(d.fecha, day)) {
                    return d.rutinaIds.map((id) => id.toString()).toList();
                  }
                }
                return [];
              },
            ),
          ),

          // Día seleccionado
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE, d MMMM', 'es_ES')
                        .format(calendarioState.fechaSeleccionada),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildRutinasDelDia(context, ref, calendarioState, rutinas),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _agregarRutina(context, ref, calendarioState),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRutinasDelDia(
    BuildContext context,
    WidgetRef ref,
    calendarioState,
    AsyncValue rutinas,
  ) {
    if (calendarioState.planActual == null) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(Icons.event_available, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            Text(
              'No hay plan para esta semana',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    try {
      final dia = calendarioState.planActual.dias.firstWhere(
        (d) => isSameDay(d.fecha, calendarioState.fechaSeleccionada),
      );

      if (dia.rutinaIds.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.event_note, size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 12),
              Text(
                'Sin rutinas planificadas',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        );
      }

      return rutinas.when(
        data: (rutinasList) => Column(
          children: dia.rutinaIds.map<Widget>((rutinaId) {
            try {
              final rutina = rutinasList.firstWhere((r) => r.id == rutinaId);
              return Dismissible(
                key: Key('rutina_${rutinaId}_${dia.fecha.toIso8601String()}'),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.redAccent,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  return await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Eliminar de este día'),
                          content: Text(
                              '¿Quitar "${rutina.nombre}" solo del ${DateFormat('EEEE d MMM', 'es_ES').format(dia.fecha)}?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text('Eliminar'),
                            ),
                          ],
                        ),
                      ) ??
                      false;
                },
                onDismissed: (_) async {
                  await ref
                      .read(calendarioControllerProvider.notifier)
                      .eliminarRutinaDelDia(
                        calendarioState.fechaSeleccionada,
                        rutinaId,
                      );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Eliminado "${rutina.nombre}" de este día')),
                    );
                  }
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                      child: const Icon(Icons.fitness_center,
                          color: AppTheme.primaryColor),
                    ),
                    title: Text(
                      rutina.nombre,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('${rutina.ejercicios.length} ejercicios'),
                    trailing: Checkbox(
                      value: dia.completado,
                      onChanged: (value) {
                        ref
                            .read(calendarioControllerProvider.notifier)
                            .marcarDiaCompletado(
                              calendarioState.fechaSeleccionada,
                              value ?? false,
                            );
                      },
                    ),
                  ),
                ),
              );
            } catch (e) {
              return const SizedBox.shrink();
            }
          }).toList(),
        ),
        loading: () => const CircularProgressIndicator(),
        error: (e, _) => Text('Error: $e'),
      );
    } catch (e) {
      return const SizedBox.shrink();
    }
  }

  void _agregarRutina(BuildContext context, WidgetRef ref, calendarioState) {
    final rutinas = ref.read(rutinasProvider);

    rutinas.whenData((rutinasList) {
      if (rutinasList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Primero crea una rutina')),
        );
        return;
      }

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => FractionallySizedBox(
          heightFactor: 0.6,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selecciona una rutina',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: rutinasList.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final rutina = rutinasList[index];
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.fitness_center),
                          ),
                          title: Text(rutina.nombre),
                          subtitle:
                              Text('${rutina.ejercicios.length} ejercicios'),
                          onTap: () {
                            Navigator.pop(context);
                            _mostrarSelectorDias(
                              context,
                              ref,
                              calendarioState,
                              rutina.id,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _mostrarSelectorDias(
    BuildContext context,
    WidgetRef ref,
    calendarioState,
    int rutinaId,
  ) {
    // Usar el inicio de semana del plan actual si existe; si no, calcular desde la fecha seleccionada
    final selected = calendarioState.fechaSeleccionada as DateTime;
    final plan = calendarioState.planActual;
    final weekStart = plan?.fechaInicio ??
        selected.subtract(Duration(days: selected.weekday - 1));
    final monday = DateTime(weekStart.year, weekStart.month, weekStart.day);
    final currentIndex = selected.difference(monday).inDays.clamp(0, 6);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        const diasAbrev = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
        // Preseleccionar días donde ya está asignada la rutina en esta semana
        final seleccionados = <int>{};
        if (plan != null && isSameDay(plan.fechaInicio, monday)) {
          for (int i = 0; i < plan.dias.length && i < 7; i++) {
            final dia = plan.dias[i];
            if (dia.rutinaIds.contains(rutinaId)) {
              seleccionados.add(i);
            }
          }
        }
        // Garantizar al menos el día actual marcado por defecto
        if (seleccionados.isEmpty) {
          seleccionados.add(currentIndex);
        }

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Asignar días de la semana',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(7, (i) {
                      final sel = seleccionados.contains(i);
                      return FilterChip(
                        label: Text(
                            '${diasAbrev[i]} (${DateFormat('d/M').format(monday.add(Duration(days: i)))} )'),
                        selected: sel,
                        onSelected: (v) {
                          setState(() {
                            if (v) {
                              seleccionados.add(i);
                            } else {
                              seleccionados.remove(i);
                            }
                          });
                        },
                        selectedColor: AppTheme.primaryColor,
                        checkmarkColor: Colors.white,
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            seleccionados
                              ..clear()
                              ..addAll([0, 1, 2, 3, 4]);
                          });
                        },
                        child: const Text('Laborables'),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            seleccionados
                              ..clear()
                              ..addAll([0, 1, 2, 3, 4, 5, 6]);
                          });
                        },
                        child: const Text('Todos'),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            seleccionados
                              ..clear()
                              ..add(currentIndex);
                          });
                        },
                        child: const Text('Solo este'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text('Guardar'),
                        onPressed: () async {
                          if (seleccionados.isEmpty) return;
                          await ref
                              .read(calendarioControllerProvider.notifier)
                              .sincronizarRutinaEnSemana(
                                monday,
                                rutinaId,
                                seleccionados,
                              );
                          if (context.mounted) Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
