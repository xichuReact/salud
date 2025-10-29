import 'package:isar/isar.dart';
import '../models/alimento.dart';
import '../services/isar_service.dart';

class AlimentoRepository {
  final IsarService _isarService;

  AlimentoRepository(this._isarService);

  // ========== REGISTRO DE ALIMENTOS ==========

  /// Guardar o actualizar un registro de alimento
  Future<int> guardarRegistro(RegistroAlimento registro) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.registroAlimentos.put(registro);
    });
  }

  /// Eliminar un registro de alimento
  Future<bool> eliminarRegistro(int id) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.registroAlimentos.delete(id);
    });
  }

  /// Obtener registros de un día específico
  Future<List<RegistroAlimento>> getRegistrosPorFecha(DateTime fecha) async {
    final inicio = DateTime(fecha.year, fecha.month, fecha.day);
    final fin = inicio.add(const Duration(days: 1));

    return await _isarService.db.registroAlimentos
        .filter()
        .fechaBetween(inicio, fin)
        .sortByFecha()
        .findAll();
  }

  /// Obtener registros de hoy
  Future<List<RegistroAlimento>> getRegistrosHoy() async {
    final hoy = DateTime.now();
    return await getRegistrosPorFecha(hoy);
  }

  /// Obtener registros por tipo de comida en una fecha
  Future<List<RegistroAlimento>> getRegistrosPorTipoComida(
    DateTime fecha,
    String tipoComida,
  ) async {
    final inicio = DateTime(fecha.year, fecha.month, fecha.day);
    final fin = inicio.add(const Duration(days: 1));

    return await _isarService.db.registroAlimentos
        .filter()
        .fechaBetween(inicio, fin)
        .tipoComidaEqualTo(tipoComida)
        .sortByFecha()
        .findAll();
  }

  /// Obtener registros de los últimos N días
  Future<List<RegistroAlimento>> getRegistrosUltimosDias(int dias) async {
    final ahora = DateTime.now();
    final inicio = DateTime(ahora.year, ahora.month, ahora.day)
        .subtract(Duration(days: dias));

    return await _isarService.db.registroAlimentos
        .filter()
        .fechaGreaterThan(inicio)
        .sortByFecha()
        .findAll();
  }

  /// Stream de registros en tiempo real
  Stream<List<RegistroAlimento>> watchRegistrosHoy() {
    final hoy = DateTime.now();
    final inicio = DateTime(hoy.year, hoy.month, hoy.day);
    final fin = inicio.add(const Duration(days: 1));

    return _isarService.db.registroAlimentos
        .filter()
        .fechaBetween(inicio, fin)
        .sortByFecha()
        .watch(fireImmediately: true);
  }

  // ========== ESTADÍSTICAS ==========

  /// Calcular total de calorías de un día
  Future<double> getTotalCaloriasDia(DateTime fecha) async {
    final registros = await getRegistrosPorFecha(fecha);
    return registros.fold<double>(0.0, (sum, r) => sum + r.calorias);
  }

  /// Calcular total de calorías por tipo de comida
  Future<Map<String, double>> getCaloriasPorTipoComida(DateTime fecha) async {
    final registros = await getRegistrosPorFecha(fecha);
    final Map<String, double> resultado = {
      'desayuno': 0.0,
      'comida': 0.0,
      'cena': 0.0,
      'snack': 0.0,
    };

    for (var registro in registros) {
      resultado[registro.tipoComida] =
          (resultado[registro.tipoComida] ?? 0.0) + registro.calorias;
    }

    return resultado;
  }

  /// Calcular macros totales del día
  Future<Map<String, double>> getMacrosDia(DateTime fecha) async {
    final registros = await getRegistrosPorFecha(fecha);
    double proteinas = 0.0;
    double carbohidratos = 0.0;
    double grasas = 0.0;

    for (var registro in registros) {
      proteinas += registro.proteinas;
      carbohidratos += registro.carbohidratos;
      grasas += registro.grasas;
    }

    return {
      'proteinas': proteinas,
      'carbohidratos': carbohidratos,
      'grasas': grasas,
    };
  }

  /// Promedio de calorías por día en un rango
  Future<double> getPromedioCaloriasPorDia(int dias) async {
    final registros = await getRegistrosUltimosDias(dias);
    if (registros.isEmpty) return 0.0;

    final totalCalorias =
        registros.fold<double>(0.0, (sum, r) => sum + r.calorias);
    return totalCalorias / dias;
  }

  // ========== BIBLIOTECA DE ALIMENTOS BASE ==========

  /// Guardar alimento base
  Future<int> guardarAlimentoBase(AlimentoBase alimento) async {
    return await _isarService.db.writeTxn(() async {
      return await _isarService.db.alimentoBases.put(alimento);
    });
  }

  /// Obtener todos los alimentos base activos
  Future<List<AlimentoBase>> getAlimentosBase() async {
    return await _isarService.db.alimentoBases
        .filter()
        .activoEqualTo(true)
        .sortByNombre()
        .findAll();
  }

  /// Buscar alimentos base por nombre
  Future<List<AlimentoBase>> buscarAlimentosBase(String query) async {
    return await _isarService.db.alimentoBases
        .filter()
        .activoEqualTo(true)
        .nombreContains(query, caseSensitive: false)
        .sortByNombre()
        .findAll();
  }

  /// Stream de alimentos base
  Stream<List<AlimentoBase>> watchAlimentosBase() {
    return _isarService.db.alimentoBases
        .filter()
        .activoEqualTo(true)
        .sortByNombre()
        .watch(fireImmediately: true);
  }
}
