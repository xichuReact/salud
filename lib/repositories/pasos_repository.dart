import 'package:isar/isar.dart';

import '../models/pasos_registro.dart';
import '../services/isar_service.dart';

class PasosRepository {
  final IsarService _isarService;

  PasosRepository(this._isarService);

  Future<List<PasosRegistro>> getAll() async {
    return await _isarService.db.pasosRegistros
        .where()
        .sortByFechaDesc()
        .findAll();
  }

  Future<PasosRegistro?> getByDate(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));

    return await _isarService.db.pasosRegistros
        .filter()
        .fechaGreaterThan(start, include: true)
        .fechaLessThan(end)
        .findFirst();
  }

  Future<List<PasosRegistro>> getByDateRange(
      DateTime start, DateTime end) async {
    return await _isarService.db.pasosRegistros
        .filter()
        .fechaBetween(start, end)
        .sortByFechaDesc()
        .findAll();
  }

  Future<int> save(PasosRegistro registro) async {
    registro.fecha =
        DateTime(registro.fecha.year, registro.fecha.month, registro.fecha.day);
    return await _isarService.db.writeTxn(() async {
      final existing = await getByDate(registro.fecha);
      if (existing != null) {
        registro.id = existing.id;
      }
      return await _isarService.db.pasosRegistros.put(registro);
    });
  }

  Future<bool> delete(int id) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.pasosRegistros.delete(id);
    });
  }

  Stream<List<PasosRegistro>> watchAll() {
    return _isarService.db.pasosRegistros
        .where()
        .sortByFechaDesc()
        .watch(fireImmediately: true);
  }
}
