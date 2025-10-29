import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/registro_agua.dart';
import '../repositories/agua_repository.dart';
import 'ejercicio_controller.dart'; // Para isarServiceProvider

// Provider del repositorio
final aguaRepositoryProvider = Provider<AguaRepository>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return AguaRepository(isarService);
});

// Provider del total de agua hoy
final aguaTotalHoyProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(aguaRepositoryProvider);
  return await repository.getTotalHoy();
});

// Provider de registros de hoy
final aguaRegistrosHoyProvider = StreamProvider<List<RegistroAgua>>((ref) {
  final repository = ref.watch(aguaRepositoryProvider);
  return repository.watchRegistrosHoy();
});

// Provider de consumo semanal
final aguaConsumoSemanalProvider = FutureProvider<Map<int, int>>((ref) async {
  final repository = ref.watch(aguaRepositoryProvider);
  return await repository.getConsumoSemanal();
});

// Provider del objetivo diario personalizado
final aguaObjetivoDiarioProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(aguaRepositoryProvider);
  return await repository.getObjetivoDiario();
});

// Provider de progreso (porcentaje del objetivo)
final aguaProgresoProvider = FutureProvider<double>((ref) async {
  final total = await ref.watch(aguaTotalHoyProvider.future);
  final objetivo = await ref.watch(aguaObjetivoDiarioProvider.future);
  return (total / objetivo).clamp(0.0, 1.0);
});

// Controller para gestión de agua
class AguaController extends StateNotifier<AsyncValue<void>> {
  final AguaRepository _repository;
  final Ref _ref;

  AguaController(this._repository, this._ref)
      : super(const AsyncValue.data(null));

  Future<void> registrarAgua(int cantidadMl, {String? nota}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.registrar(cantidadMl, nota: nota);
      // Invalidar providers para refrescar
      _ref.invalidate(aguaTotalHoyProvider);
      _ref.invalidate(aguaRegistrosHoyProvider);
      _ref.invalidate(aguaConsumoSemanalProvider);
      _ref.invalidate(aguaProgresoProvider);
    });
  }

  Future<void> eliminarRegistro(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.eliminar(id);
      _ref.invalidate(aguaTotalHoyProvider);
      _ref.invalidate(aguaRegistrosHoyProvider);
      _ref.invalidate(aguaConsumoSemanalProvider);
      _ref.invalidate(aguaProgresoProvider);
    });
  }

  Future<void> actualizarObjetivo(int objetivoMl) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.setObjetivoDiario(objetivoMl);
      // Invalidar todos los providers que dependen del objetivo
      _ref.invalidate(aguaObjetivoDiarioProvider);
      _ref.invalidate(aguaProgresoProvider);
    });
  }

  Future<void> resetearObjetivo() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.resetObjetivoDiario();
      _ref.invalidate(aguaObjetivoDiarioProvider);
      _ref.invalidate(aguaProgresoProvider);
    });
  }
}

// Provider del controller
final aguaControllerProvider =
    StateNotifierProvider<AguaController, AsyncValue<void>>((ref) {
  final repository = ref.watch(aguaRepositoryProvider);
  return AguaController(repository, ref);
});
