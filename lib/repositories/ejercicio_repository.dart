import 'package:isar/isar.dart';
import '../models/ejercicio.dart';
import '../services/isar_service.dart';

class EjercicioRepository {
  final IsarService _isarService;

  EjercicioRepository(this._isarService);

  /// Obtener todos los ejercicios activos
  Future<List<Ejercicio>> getAll() async {
    return await _isarService.db.ejercicios
        .filter()
        .activoEqualTo(true)
        .sortByNombre()
        .findAll();
  }

  /// Obtener ejercicios por tipo
  Future<List<Ejercicio>> getByTipo(String tipo) async {
    return await _isarService.db.ejercicios
        .filter()
        .activoEqualTo(true)
        .tipoEqualTo(tipo)
        .sortByNombre()
        .findAll();
  }

  /// Obtener ejercicio por ID
  Future<Ejercicio?> getById(int id) async {
    return await _isarService.db.ejercicios.get(id);
  }

  /// Crear o actualizar ejercicio
  Future<int> save(Ejercicio ejercicio) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.ejercicios.put(ejercicio);
    });
  }

  /// Eliminar ejercicio (soft delete)
  Future<void> delete(int id) async {
    await _isarService.db.writeTxn(() async {
      final ejercicio = await _isarService.db.ejercicios.get(id);
      if (ejercicio != null) {
        ejercicio.activo = false;
        await _isarService.db.ejercicios.put(ejercicio);
      }
    });
  }

  /// Stream de ejercicios en tiempo real
  Stream<List<Ejercicio>> watchAll() {
    return _isarService.db.ejercicios
        .filter()
        .activoEqualTo(true)
        .sortByNombre()
        .watch(fireImmediately: true);
  }

  // Preparado para Firebase
  // Future<void> syncWithFirebase() async {}
}
