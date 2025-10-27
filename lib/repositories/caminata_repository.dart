import 'package:isar/isar.dart';

import '../models/caminata.dart';
import '../services/isar_service.dart';

class CaminataRepository {
  final IsarService _isarService;

  CaminataRepository(this._isarService);

  /// Obtener todas las caminatas
  Future<List<Caminata>> getAll() async {
    return await _isarService.db.caminatas
        .where()
        .sortByFechaDesc()
        .findAll();
  }

  /// Obtener caminatas por rango de fechas
  Future<List<Caminata>> getByDateRange(DateTime start, DateTime end) async {
    return await _isarService.db.caminatas
        .filter()
        .fechaBetween(start, end)
        .sortByFechaDesc()
        .findAll();
  }

  /// Obtener caminata por ID
  Future<Caminata?> getById(int id) async {
    return await _isarService.db.caminatas.get(id);
  }

  /// Crear o actualizar caminata
  Future<int> save(Caminata caminata) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.caminatas.put(caminata);
    });
  }

  /// Eliminar caminata
  Future<bool> delete(int id) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.caminatas.delete(id);
    });
  }

  /// Stream de caminatas
  Stream<List<Caminata>> watchAll() {
    return _isarService.db.caminatas
        .where()
        .sortByFechaDesc()
        .watch(fireImmediately: true);
  }

  /// Obtener estadísticas de caminatas
  Future<Map<String, dynamic>> getEstadisticas() async {
    final caminatas = await getAll();
    
    if (caminatas.isEmpty) {
      return {
        'total': 0,
        'duracionTotal': 0,
        'distanciaTotal': 0.0,
        'promedioDuracion': 0,
      };
    }

    int duracionTotal = 0;
    double distanciaTotal = 0.0;
    int countDistancia = 0;

    for (var caminata in caminatas) {
      duracionTotal += caminata.duracionSegundos;
      if (caminata.distanciaMetros != null) {
        distanciaTotal += caminata.distanciaMetros!;
        countDistancia++;
      }
    }

    return {
      'total': caminatas.length,
      'duracionTotal': duracionTotal,
      'distanciaTotal': distanciaTotal,
      'promedioDuracion': duracionTotal ~/ caminatas.length,
      'promedioDistancia': countDistancia > 0 ? distanciaTotal / countDistancia : 0.0,
    };
  }
}
