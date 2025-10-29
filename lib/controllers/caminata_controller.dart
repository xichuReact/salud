import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/caminata.dart';
import '../repositories/caminata_repository.dart';
import 'ejercicio_controller.dart';

// Provider del repositorio
final caminataRepositoryProvider = Provider<CaminataRepository>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return CaminataRepository(isarService);
});

// Provider de todas las caminatas
final caminatasProvider = StreamProvider<List<Caminata>>((ref) {
  final repository = ref.watch(caminataRepositoryProvider);
  return repository.watchAll();
});

// Provider de estadísticas
final estadisticasCaminatasProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  final repository = ref.watch(caminataRepositoryProvider);
  return await repository.getEstadisticas();
});

// Controller para gestión de caminatas
class CaminataController extends StateNotifier<AsyncValue<void>> {
  final CaminataRepository _repository;

  CaminataController(this._repository) : super(const AsyncValue.data(null));

  Future<void> guardarCaminata(Caminata caminata) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.save(caminata);
    });
  }

  Future<void> eliminarCaminata(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.delete(id);
    });
  }

  Future<List<Caminata>> obtenerCaminatasPorFecha(
      DateTime start, DateTime end) async {
    return await _repository.getByDateRange(start, end);
  }
}

// Provider del controller
final caminataControllerProvider =
    StateNotifierProvider<CaminataController, AsyncValue<void>>((ref) {
  final repository = ref.watch(caminataRepositoryProvider);
  return CaminataController(repository);
});
