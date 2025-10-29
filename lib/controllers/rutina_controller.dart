import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rutina.dart';
import '../repositories/rutina_repository.dart';
import 'ejercicio_controller.dart';

// Provider del repositorio
final rutinaRepositoryProvider = Provider<RutinaRepository>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return RutinaRepository(isarService);
});

// Provider de todas las rutinas
final rutinasProvider = StreamProvider<List<Rutina>>((ref) {
  final repository = ref.watch(rutinaRepositoryProvider);
  return repository.watchAll();
});

// Provider de rutinas por día
final rutinasPorDiaProvider =
    FutureProvider.family<List<Rutina>, int>((ref, dia) async {
  final repository = ref.watch(rutinaRepositoryProvider);
  return await repository.getByDia(dia);
});

// Controller para gestión de rutinas
class RutinaController extends StateNotifier<AsyncValue<void>> {
  final RutinaRepository _repository;

  RutinaController(this._repository) : super(const AsyncValue.data(null));

  Future<void> crearRutina(Rutina rutina) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.save(rutina);
    });
  }

  Future<void> actualizarRutina(Rutina rutina) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.save(rutina);
    });
  }

  Future<void> eliminarRutina(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.delete(id);
    });
  }
}

// Provider del controller
final rutinaControllerProvider =
    StateNotifierProvider<RutinaController, AsyncValue<void>>((ref) {
  final repository = ref.watch(rutinaRepositoryProvider);
  return RutinaController(repository);
});
