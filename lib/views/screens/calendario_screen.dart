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
                ref.read(calendarioControllerProvider.notifier).cambiarMes(focusedDay);
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
              return Card(
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
        builder: (context) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selecciona una rutina',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              ...rutinasList.map((rutina) {
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.fitness_center),
                  ),
                  title: Text(rutina.nombre),
                  subtitle: Text('${rutina.ejercicios.length} ejercicios'),
                  onTap: () {
                    ref
                        .read(calendarioControllerProvider.notifier)
                        .agregarRutinaAlDia(
                          calendarioState.fechaSeleccionada,
                          rutina.id,
                        );
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
