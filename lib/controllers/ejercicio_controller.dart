import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ejercicio.dart';
import '../repositories/ejercicio_repository.dart';
import '../services/isar_service.dart';

// Provider del servicio Isar
final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});

// Provider del repositorio
final ejercicioRepositoryProvider = Provider<EjercicioRepository>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return EjercicioRepository(isarService);
});

// Provider de la lista de ejercicios
final ejerciciosProvider = StreamProvider<List<Ejercicio>>((ref) {
  final repository = ref.watch(ejercicioRepositoryProvider);
  return repository.watchAll();
});

// Provider para ejercicios por tipo
final ejerciciosPorTipoProvider =
    FutureProvider.family<List<Ejercicio>, String>((ref, tipo) async {
  final repository = ref.watch(ejercicioRepositoryProvider);
  return await repository.getByTipo(tipo);
});

// Controller para gestión de ejercicios
class EjercicioController extends StateNotifier<AsyncValue<void>> {
  final EjercicioRepository _repository;

  EjercicioController(this._repository) : super(const AsyncValue.data(null));

  Future<void> crearEjercicio(Ejercicio ejercicio) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.save(ejercicio);
    });
  }

  Future<void> actualizarEjercicio(Ejercicio ejercicio) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.save(ejercicio);
    });
  }

  Future<void> eliminarEjercicio(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.delete(id);
    });
  }
}

// Provider del controller
final ejercicioControllerProvider =
    StateNotifierProvider<EjercicioController, AsyncValue<void>>((ref) {
  final repository = ref.watch(ejercicioRepositoryProvider);
  return EjercicioController(repository);
});
