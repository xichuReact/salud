import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/plan_semanal.dart';
import '../repositories/plan_semanal_repository.dart';
import 'ejercicio_controller.dart';

// Provider del repositorio
final planSemanalRepositoryProvider = Provider<PlanSemanalRepository>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return PlanSemanalRepository(isarService);
});

// Estado del calendario
class CalendarioState {
  final DateTime fechaSeleccionada;
  final DateTime mesActual;
  final PlanSemanal? planActual;

  const CalendarioState({
    required this.fechaSeleccionada,
    required this.mesActual,
    this.planActual,
  });

  CalendarioState copyWith({
    DateTime? fechaSeleccionada,
    DateTime? mesActual,
    PlanSemanal? planActual,
  }) {
    return CalendarioState(
      fechaSeleccionada: fechaSeleccionada ?? this.fechaSeleccionada,
      mesActual: mesActual ?? this.mesActual,
      planActual: planActual ?? this.planActual,
    );
  }
}

// Controller del calendario
class CalendarioController extends StateNotifier<CalendarioState> {
  final PlanSemanalRepository _repository;

  CalendarioController(this._repository)
      : super(CalendarioState(
          fechaSeleccionada: DateTime.now(),
          mesActual: DateTime.now(),
        )) {
    _cargarPlanActual();
  }

  Future<void> _cargarPlanActual() async {
    final plan = await _repository.getByWeek(state.fechaSeleccionada);
    state = state.copyWith(planActual: plan);
  }

  void seleccionarFecha(DateTime fecha) {
    state = state.copyWith(fechaSeleccionada: fecha);
    _cargarPlanActual();
  }

  void cambiarMes(DateTime mes) {
    state = state.copyWith(mesActual: mes);
  }

  Future<void> crearPlanVacio() async {
    final plan = await _repository.createEmptyPlan(state.fechaSeleccionada);
    state = state.copyWith(planActual: plan);
  }

  Future<void> agregarRutinaAlDia(DateTime fecha, int rutinaId) async {
    if (state.planActual == null) {
      await crearPlanVacio();
    }

    final plan = state.planActual!;
    final diaIndex = plan.dias.indexWhere(
      (d) => d.fecha.day == fecha.day && d.fecha.month == fecha.month && d.fecha.year == fecha.year,
    );

    if (diaIndex != -1) {
      // Convertir a lista expandible para evitar "Cannot add to a fixed-length list"
      final actuales = List<int>.from(plan.dias[diaIndex].rutinaIds);
      if (!actuales.contains(rutinaId)) {
        actuales.add(rutinaId);
      }
      plan.dias[diaIndex].rutinaIds = actuales;
      await _repository.save(plan);
      await _cargarPlanActual();
    }
  }

  Future<void> marcarDiaCompletado(DateTime fecha, bool completado) async {
    if (state.planActual == null) return;

    final plan = state.planActual!;
    final diaIndex = plan.dias.indexWhere(
      (d) => d.fecha.day == fecha.day && d.fecha.month == fecha.month && d.fecha.year == fecha.year,
    );

    if (diaIndex != -1) {
      plan.dias[diaIndex].completado = completado;
      await _repository.save(plan);
      await _cargarPlanActual();
    }
  }
}

// Provider del controller
final calendarioControllerProvider = StateNotifierProvider<CalendarioController, CalendarioState>((ref) {
  final repository = ref.watch(planSemanalRepositoryProvider);
  return CalendarioController(repository);
});
