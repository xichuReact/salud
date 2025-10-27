import 'package:isar/isar.dart';

import '../models/rutina.dart';
import '../services/isar_service.dart';

class RutinaRepository {
  final IsarService _isarService;

  RutinaRepository(this._isarService);

  /// Obtener todas las rutinas activas
  Future<List<Rutina>> getAll() async {
    return await _isarService.db.rutinas
        .filter()
        .activaEqualTo(true)
        .sortByNombre()
        .findAll();
  }

  /// Obtener rutinas por día de la semana
  Future<List<Rutina>> getByDia(int dia) async {
    final rutinas = await getAll();
    return rutinas.where((r) => r.diasSemana.contains(dia)).toList();
  }

  /// Obtener rutina por ID
  Future<Rutina?> getById(int id) async {
    return await _isarService.db.rutinas.get(id);
  }

  /// Crear o actualizar rutina
  Future<int> save(Rutina rutina) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.rutinas.put(rutina);
    });
  }

  /// Eliminar rutina (soft delete)
  Future<void> delete(int id) async {
    await _isarService.db.writeTxn(() async {
      final rutina = await _isarService.db.rutinas.get(id);
      if (rutina != null) {
        rutina.activa = false;
        await _isarService.db.rutinas.put(rutina);
      }
    });
  }

  /// Stream de rutinas
  Stream<List<Rutina>> watchAll() {
    return _isarService.db.rutinas
        .filter()
        .activaEqualTo(true)
        .watch(fireImmediately: true);
  }
}
