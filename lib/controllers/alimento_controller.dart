import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/alimento.dart';
import '../repositories/alimento_repository.dart';
import '../controllers/ejercicio_controller.dart';

// Provider del repositorio
final alimentoRepositoryProvider = Provider<AlimentoRepository>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return AlimentoRepository(isarService);
});

// ========== PROVIDERS DE REGISTROS ==========

/// Stream de registros de alimentos de hoy
final registrosAlimentosHoyProvider =
    StreamProvider<List<RegistroAlimento>>((ref) {
  final repository = ref.watch(alimentoRepositoryProvider);
  return repository.watchRegistrosHoy();
});

/// Provider de registros por fecha específica
final registrosAlimentosPorFechaProvider =
    FutureProvider.family<List<RegistroAlimento>, DateTime>((ref, fecha) async {
  final repository = ref.watch(alimentoRepositoryProvider);
  return await repository.getRegistrosPorFecha(fecha);
});

/// Provider de registros por tipo de comida (hoy)
final registrosPorTipoComidaProvider =
    FutureProvider.family<List<RegistroAlimento>, String>(
        (ref, tipoComida) async {
  final repository = ref.watch(alimentoRepositoryProvider);
  final hoy = DateTime.now();
  return await repository.getRegistrosPorTipoComida(hoy, tipoComida);
});

// ========== PROVIDERS DE ESTADÍSTICAS ==========

/// Total de calorías de hoy
final caloriasHoyProvider = FutureProvider<double>((ref) async {
  final repository = ref.watch(alimentoRepositoryProvider);
  final hoy = DateTime.now();
  return await repository.getTotalCaloriasDia(hoy);
});

/// Calorías por tipo de comida (hoy)
final caloriasPorTipoProvider =
    FutureProvider<Map<String, double>>((ref) async {
  final repository = ref.watch(alimentoRepositoryProvider);
  final hoy = DateTime.now();
  return await repository.getCaloriasPorTipoComida(hoy);
});

/// Macros del día (hoy)
final macrosHoyProvider = FutureProvider<Map<String, double>>((ref) async {
  final repository = ref.watch(alimentoRepositoryProvider);
  final hoy = DateTime.now();
  return await repository.getMacrosDia(hoy);
});

/// Promedio de calorías últimos 7 días
final promedioCaloriasProvider = FutureProvider<double>((ref) async {
  final repository = ref.watch(alimentoRepositoryProvider);
  return await repository.getPromedioCaloriasPorDia(7);
});

/// Calorías de los últimos 7 días agrupadas por día (0-6: Lun-Dom)
final caloriasSemanalesProvider = FutureProvider<Map<int, double>>((ref) async {
  final repository = ref.watch(alimentoRepositoryProvider);
  final now = DateTime.now();
  final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
  final endOfWeek = startOfWeek.add(const Duration(days: 6));

  final registros = await repository.getRegistrosUltimosDias(7);

  // Inicializar conteo por día de la semana
  final Map<int, double> caloriasPorDia = {for (var i = 0; i < 7; i++) i: 0.0};

  for (final r in registros) {
    if (r.fecha.isBefore(DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day)) ||
        r.fecha.isAfter(DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59))) {
      continue;
    }
    final weekdayIndex = (r.fecha.weekday % 7); // 0=Dom, ajustamos a 0=Lun
    final idx = weekdayIndex == 0 ? 6 : weekdayIndex - 1; // 0..6 con 0=Lun
    caloriasPorDia[idx] = (caloriasPorDia[idx] ?? 0) + r.calorias;
  }

  return caloriasPorDia;
});

/// Últimos registros de alimentos (últimos 7 días)
final ultimosAlimentosProvider = FutureProvider<List<RegistroAlimento>>((ref) async {
  final repository = ref.watch(alimentoRepositoryProvider);
  return await repository.getRegistrosUltimosDias(7);
});

// ========== PROVIDERS DE ALIMENTOS BASE ==========

/// Stream de alimentos base
final alimentosBaseProvider = StreamProvider<List<AlimentoBase>>((ref) {
  final repository = ref.watch(alimentoRepositoryProvider);
  return repository.watchAlimentosBase();
});

// ========== CONTROLLER ==========

/// Controller para gestión de alimentos
class AlimentoController extends StateNotifier<AsyncValue<void>> {
  final AlimentoRepository _repository;

  AlimentoController(this._repository) : super(const AsyncValue.data(null));

  /// Guardar registro de alimento
  Future<void> guardarRegistro(RegistroAlimento registro) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.guardarRegistro(registro);
    });
  }

  /// Eliminar registro de alimento
  Future<void> eliminarRegistro(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.eliminarRegistro(id);
    });
  }

  /// Guardar alimento base en biblioteca
  Future<void> guardarAlimentoBase(AlimentoBase alimento) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.guardarAlimentoBase(alimento);
    });
  }

  /// Crear registro rápido desde alimento base
  Future<void> crearRegistroDesdeBase(
    AlimentoBase alimentoBase,
    String tipoComida,
    double cantidad,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // Calcular valores proporcionales
      final factor = cantidad / alimentoBase.cantidadReferencia;

      final registro = RegistroAlimento()
        ..nombre = alimentoBase.nombre
        ..descripcion = alimentoBase.descripcion
        ..calorias = alimentoBase.calorias * factor
        ..proteinas = alimentoBase.proteinas * factor
        ..carbohidratos = alimentoBase.carbohidratos * factor
        ..grasas = alimentoBase.grasas * factor
        ..cantidad = cantidad
        ..unidadMedida = alimentoBase.unidadReferencia
        ..tipoComida = tipoComida
        ..fecha = DateTime.now();

      await _repository.guardarRegistro(registro);
    });
  }
}

// Provider del controller
final alimentoControllerProvider =
    StateNotifierProvider<AlimentoController, AsyncValue<void>>((ref) {
  final repository = ref.watch(alimentoRepositoryProvider);
  return AlimentoController(repository);
});
