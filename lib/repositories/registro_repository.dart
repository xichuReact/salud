import 'package:isar/isar.dart';
import '../models/registro_ejercicio.dart';
import '../services/isar_service.dart';

class RegistroRepository {
  final IsarService _isarService;

  RegistroRepository(this._isarService);

  /// Obtener todos los registros
  Future<List<RegistroEjercicio>> getAll() async {
    return await _isarService.db.registroEjercicios
        .where()
        .sortByFechaDesc()
        .findAll();
  }

  /// Obtener registros por ejercicio
  Future<List<RegistroEjercicio>> getByEjercicio(int ejercicioId) async {
    return await _isarService.db.registroEjercicios
        .filter()
        .ejercicioIdEqualTo(ejercicioId)
        .sortByFechaDesc()
        .findAll();
  }

  /// Obtener registros por rango de fechas
  Future<List<RegistroEjercicio>> getByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    return await _isarService.db.registroEjercicios
        .filter()
        .fechaBetween(start, end)
        .sortByFechaDesc()
        .findAll();
  }

  /// Obtener registros de hoy
  Future<List<RegistroEjercicio>> getToday() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));
    return getByDateRange(start, end);
  }

  /// Crear o actualizar registro
  Future<int> save(RegistroEjercicio registro) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.registroEjercicios.put(registro);
    });
  }

  /// Eliminar registro
  Future<bool> delete(int id) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.registroEjercicios.delete(id);
    });
  }

  /// Stream de registros de hoy
  Stream<List<RegistroEjercicio>> watchToday() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));
    
    return _isarService.db.registroEjercicios
        .filter()
        .fechaBetween(start, end)
        .watch(fireImmediately: true);
  }

  /// Obtener estadísticas de un ejercicio
  Future<Map<String, dynamic>> getEstadisticas(int ejercicioId) async {
    final registros = await getByEjercicio(ejercicioId);
    
    if (registros.isEmpty) {
      return {'total': 0, 'promedio': 0.0, 'maximo': 0.0};
    }

    double totalPeso = 0;
    double maxPeso = 0;
    int count = 0;

    for (var registro in registros) {
      for (var serie in registro.series) {
        if (serie.peso != null) {
          totalPeso += serie.peso!;
          if (serie.peso! > maxPeso) maxPeso = serie.peso!;
          count++;
        }
      }
    }

    return {
      'total': registros.length,
      'promedio': count > 0 ? totalPeso / count : 0.0,
      'maximo': maxPeso,
    };
  }
}
