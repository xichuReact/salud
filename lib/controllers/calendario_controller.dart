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
      (d) =>
          d.fecha.day == fecha.day &&
          d.fecha.month == fecha.month &&
          d.fecha.year == fecha.year,
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

  Future<PlanSemanal> _ensurePlanFor(DateTime fecha) async {
    var plan = await _repository.getByWeek(fecha);
    plan ??= await _repository.createEmptyPlan(fecha);
    return plan;
  }

  /// Agregar una rutina a múltiples días de la semana del plan de la fechaReferencia.
  /// [diasIndices] deben ser 0..6 con Lunes=0 ... Domingo=6
  Future<void> agregarRutinaAMultiplesDias(
    DateTime fechaReferencia,
    int rutinaId,
    Set<int> diasIndices,
  ) async {
    if (diasIndices.isEmpty) return;

    final plan = await _ensurePlanFor(fechaReferencia);

    // Asegurar que el plan tiene 7 días
    if (plan.dias.length != 7) {
      // Normalizar: recrear arreglo a partir del inicio de semana del plan
      final inicio = plan.fechaInicio;
      plan.dias = List.generate(7, (i) {
        final fecha = DateTime(inicio.year, inicio.month, inicio.day)
            .add(Duration(days: i));
        return plan.dias.firstWhere(
          (d) =>
              d.fecha.year == fecha.year &&
              d.fecha.month == fecha.month &&
              d.fecha.day == fecha.day,
          orElse: () => DiaPlanificado()..fecha = fecha,
        );
      });
    }

    bool changed = false;
    for (final idx in diasIndices) {
      if (idx < 0 || idx > 6) continue;
      final dia = plan.dias[idx];
      final actuales = List<int>.from(dia.rutinaIds);
      if (!actuales.contains(rutinaId)) {
        actuales.add(rutinaId);
        dia.rutinaIds = actuales;
        changed = true;
      }
    }

    if (changed) {
      await _repository.save(plan);
      // refrescar si la fecha seleccionada pertenece al plan actualizado
      await _cargarPlanActual();
    }
  }

  /// Sincroniza la presencia de una rutina en la semana completa.
  /// Agrega la rutina a los días seleccionados y la elimina de los no seleccionados.
  /// [diasSeleccionados] deben ser índices 0..6 con Lunes=0 ... Domingo=6
  Future<void> sincronizarRutinaEnSemana(
    DateTime fechaReferencia,
    int rutinaId,
    Set<int> diasSeleccionados,
  ) async {
    final plan = await _ensurePlanFor(fechaReferencia);

    // Asegurar 7 días consistentes
    if (plan.dias.length != 7) {
      final inicio = plan.fechaInicio;
      plan.dias = List.generate(7, (i) {
        final fecha = DateTime(inicio.year, inicio.month, inicio.day)
            .add(Duration(days: i));
        return plan.dias.firstWhere(
          (d) =>
              d.fecha.year == fecha.year &&
              d.fecha.month == fecha.month &&
              d.fecha.day == fecha.day,
          orElse: () => DiaPlanificado()..fecha = fecha,
        );
      });
    }

    bool changed = false;
    for (int i = 0; i < 7; i++) {
      final dia = plan.dias[i];
      final actuales = List<int>.from(dia.rutinaIds);
      final contiene = actuales.contains(rutinaId);
      final debeTener = diasSeleccionados.contains(i);

      if (debeTener && !contiene) {
        actuales.add(rutinaId);
        dia.rutinaIds = actuales;
        changed = true;
      } else if (!debeTener && contiene) {
        actuales.remove(rutinaId);
        dia.rutinaIds = actuales;
        changed = true;
      }
    }

    if (changed) {
      await _repository.save(plan);
      await _cargarPlanActual();
    }
  }

  /// Elimina una rutina asignada en el día exacto [fecha]
  Future<void> eliminarRutinaDelDia(DateTime fecha, int rutinaId) async {
    if (state.planActual == null) return;

    final plan = state.planActual!;
    final diaIndex = plan.dias.indexWhere(
      (d) =>
          d.fecha.day == fecha.day &&
          d.fecha.month == fecha.month &&
          d.fecha.year == fecha.year,
    );

    if (diaIndex == -1) return;

    final actuales = List<int>.from(plan.dias[diaIndex].rutinaIds);
    if (actuales.contains(rutinaId)) {
      actuales.remove(rutinaId);
      plan.dias[diaIndex].rutinaIds = actuales;
      await _repository.save(plan);
      await _cargarPlanActual();
    }
  }

  Future<void> marcarDiaCompletado(DateTime fecha, bool completado) async {
    if (state.planActual == null) return;

    final plan = state.planActual!;
    final diaIndex = plan.dias.indexWhere(
      (d) =>
          d.fecha.day == fecha.day &&
          d.fecha.month == fecha.month &&
          d.fecha.year == fecha.year,
    );

    if (diaIndex != -1) {
      plan.dias[diaIndex].completado = completado;
      await _repository.save(plan);
      await _cargarPlanActual();
    }
  }
}

// Provider del controller
final calendarioControllerProvider =
    StateNotifierProvider<CalendarioController, CalendarioState>((ref) {
  final repository = ref.watch(planSemanalRepositoryProvider);
  return CalendarioController(repository);
});
