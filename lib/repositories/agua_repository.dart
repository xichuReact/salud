import 'package:isar/isar.dart';
import '../models/registro_agua.dart';
import '../services/isar_service.dart';

class AguaRepository {
  final IsarService _isarService;

  AguaRepository(this._isarService);

  /// Registrar ingesta de agua
  Future<int> registrar(int cantidadMl, {String? nota}) async {
    final registro = RegistroAgua()
      ..fecha = DateTime.now()
      ..cantidadMl = cantidadMl
      ..nota = nota;

    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.registroAguas.put(registro);
    });
  }

  /// Obtener total de agua consumida hoy
  Future<int> getTotalHoy() async {
    final ahora = DateTime.now();
    final inicioDia = DateTime(ahora.year, ahora.month, ahora.day);
    final finDia = inicioDia.add(const Duration(days: 1));

    final registros = await _isarService.db.registroAguas
        .filter()
        .fechaBetween(inicioDia, finDia)
        .findAll();

    return registros.fold<int>(0, (sum, r) => sum + r.cantidadMl);
  }

  /// Obtener registros de hoy ordenados por fecha
  Future<List<RegistroAgua>> getRegistrosHoy() async {
    final ahora = DateTime.now();
    final inicioDia = DateTime(ahora.year, ahora.month, ahora.day);
    final finDia = inicioDia.add(const Duration(days: 1));

    return await _isarService.db.registroAguas
        .filter()
        .fechaBetween(inicioDia, finDia)
        .sortByFechaDesc()
        .findAll();
  }

  /// Obtener total de agua consumida para una fecha específica
  Future<int> getTotalPorFecha(DateTime fecha) async {
    final inicioDia = DateTime(fecha.year, fecha.month, fecha.day);
    final finDia = inicioDia.add(const Duration(days: 1));

    final registros = await _isarService.db.registroAguas
        .filter()
        .fechaBetween(inicioDia, finDia)
        .findAll();

    return registros.fold<int>(0, (sum, r) => sum + r.cantidadMl);
  }

  /// Obtener consumo semanal (últimos 7 días)
  Future<Map<int, int>> getConsumoSemanal() async {
    final ahora = DateTime.now();
    final hace7Dias = ahora.subtract(const Duration(days: 7));

    final registros = await _isarService.db.registroAguas
        .filter()
        .fechaGreaterThan(hace7Dias)
        .sortByFecha()
        .findAll();

    // Agrupar por día de la semana
    final consumoPorDia = <int, int>{};
    for (final registro in registros) {
      final diaSemana = registro.fecha.weekday; // 1=lunes, 7=domingo
      final indice = diaSemana % 7; // 0=domingo, 1=lunes... 6=sábado
      final currentValue = consumoPorDia[indice] ?? 0;
      consumoPorDia[indice] = currentValue + registro.cantidadMl;
    }

    return consumoPorDia;
  }

  /// Eliminar registro
  Future<bool> eliminar(int id) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.registroAguas.delete(id);
    });
  }

  /// Stream de registros de hoy
  Stream<List<RegistroAgua>> watchRegistrosHoy() {
    final ahora = DateTime.now();
    final inicioDia = DateTime(ahora.year, ahora.month, ahora.day);
    final finDia = inicioDia.add(const Duration(days: 1));

    return _isarService.db.registroAguas
        .filter()
        .fechaBetween(inicioDia, finDia)
        .sortByFechaDesc()
        .watch(fireImmediately: true);
  }
}
