import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/registro_ejercicio.dart';
import '../repositories/registro_repository.dart';
import 'ejercicio_controller.dart';

// Provider del repositorio
final registroRepositoryProvider = Provider<RegistroRepository>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return RegistroRepository(isarService);
});

// Provider de registros de hoy
final registrosHoyProvider = StreamProvider<List<RegistroEjercicio>>((ref) {
  final repository = ref.watch(registroRepositoryProvider);
  return repository.watchToday();
});

// Provider de registros de la semana (últimos 7 días agrupados por día)
final registrosSemanalesProvider = FutureProvider<Map<int, int>>((ref) async {
  final repository = ref.watch(registroRepositoryProvider);
  final now = DateTime.now();
  final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
  final endOfWeek = startOfWeek.add(const Duration(days: 6));
  
  final registros = await repository.getByDateRange(
    DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
    DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59),
  );
  
  // Agrupar por día de la semana (0=Lunes, 6=Domingo)
  final Map<int, int> conteo = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0};
  for (var registro in registros) {
    final dayIndex = (registro.fecha.weekday - 1) % 7;
    conteo[dayIndex] = (conteo[dayIndex] ?? 0) + 1;
  }
  
  return conteo;
});

// Provider de registros por ejercicio
final registrosPorEjercicioProvider = FutureProvider.family<List<RegistroEjercicio>, int>((ref, ejercicioId) async {
  final repository = ref.watch(registroRepositoryProvider);
  return await repository.getByEjercicio(ejercicioId);
});

// Provider de estadísticas por ejercicio
final estadisticasEjercicioProvider = FutureProvider.family<Map<String, dynamic>, int>((ref, ejercicioId) async {
  final repository = ref.watch(registroRepositoryProvider);
  return await repository.getEstadisticas(ejercicioId);
});

// Controller para gestión de registros
class RegistroController extends StateNotifier<AsyncValue<void>> {
  final RegistroRepository _repository;

  RegistroController(this._repository) : super(const AsyncValue.data(null));

  Future<void> guardarRegistro(RegistroEjercicio registro) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.save(registro);
    });
  }

  Future<void> eliminarRegistro(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.delete(id);
    });
  }

  Future<List<RegistroEjercicio>> obtenerRegistrosPorFecha(DateTime start, DateTime end) async {
    return await _repository.getByDateRange(start, end);
  }
}

// Provider del controller
final registroControllerProvider = StateNotifierProvider<RegistroController, AsyncValue<void>>((ref) {
  final repository = ref.watch(registroRepositoryProvider);
  return RegistroController(repository);
});
