import 'package:isar/isar.dart';

import '../models/plan_semanal.dart';
import '../services/isar_service.dart';

class PlanSemanalRepository {
  final IsarService _isarService;

  PlanSemanalRepository(this._isarService);

  /// Obtener plan por fecha
  Future<PlanSemanal?> getByWeek(DateTime fecha) async {
    // Encontrar el inicio de la semana
    final inicio = _getStartOfWeek(fecha);

    return await _isarService.db.planSemanals
        .filter()
        .fechaInicioEqualTo(inicio)
        .findFirst();
  }

  /// Crear o actualizar plan semanal
  Future<int> save(PlanSemanal plan) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.planSemanals.put(plan);
    });
  }

  /// Eliminar plan
  Future<bool> delete(int id) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.planSemanals.delete(id);
    });
  }

  /// Stream de planes
  Stream<List<PlanSemanal>> watchAll() {
    return _isarService.db.planSemanals.where().watch(fireImmediately: true);
  }

  /// Obtener inicio de semana (Lunes)
  DateTime _getStartOfWeek(DateTime date) {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    return DateTime(monday.year, monday.month, monday.day);
  }

  /// Crear plan semanal vacío para una fecha
  Future<PlanSemanal> createEmptyPlan(DateTime fecha) async {
    final inicio = _getStartOfWeek(fecha);
    final fin = inicio.add(const Duration(days: 6));

    final plan = PlanSemanal()
      ..fechaInicio = inicio
      ..fechaFin = fin;

    // Crear días vacíos
    for (int i = 0; i < 7; i++) {
      plan.dias.add(DiaPlanificado()
        ..fecha = inicio.add(Duration(days: i))
        ..completado = false);
    }

    final id = await save(plan);
    return (await _isarService.db.planSemanals.get(id))!;
  }
}
