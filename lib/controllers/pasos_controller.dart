import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/pasos_registro.dart';
import '../repositories/pasos_repository.dart';
import 'ejercicio_controller.dart';

final pasosRepositoryProvider = Provider<PasosRepository>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return PasosRepository(isarService);
});

final pasosRegistrosProvider = StreamProvider<List<PasosRegistro>>((ref) {
  final repository = ref.watch(pasosRepositoryProvider);
  return repository.watchAll();
});

final pasosEstadisticasProvider =
    Provider<AsyncValue<PasosEstadisticas>>((ref) {
  final registrosAsync = ref.watch(pasosRegistrosProvider);
  return registrosAsync.whenData(PasosEstadisticas.fromRegistros);
});

class PasosController extends StateNotifier<AsyncValue<void>> {
  PasosController(this._repository) : super(const AsyncValue.data(null));

  final PasosRepository _repository;

  Future<void> guardarRegistro(
      {required DateTime fecha, required int pasos}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final registro = PasosRegistro()
        ..fecha = DateTime(fecha.year, fecha.month, fecha.day)
        ..pasos = pasos;
      await _repository.save(registro);
    });
  }

  Future<void> eliminarRegistro(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.delete(id);
    });
  }
}

final pasosControllerProvider =
    StateNotifierProvider<PasosController, AsyncValue<void>>((ref) {
  final repository = ref.watch(pasosRepositoryProvider);
  return PasosController(repository);
});

class PasosDia {
  PasosDia({required this.fecha, required this.pasos});

  final DateTime fecha;
  final int pasos;
}

class PasosEstadisticas {
  PasosEstadisticas({
    required this.ultimos7Dias,
    required this.promedioUltimos7,
    required this.pasosHoy,
    required this.promedioHistorico,
    required this.promedioMesActual,
    required this.promedioMesAnterior,
  });

  final List<PasosDia> ultimos7Dias;
  final int promedioUltimos7;
  final int pasosHoy;
  final int promedioHistorico;
  final int promedioMesActual;
  final int promedioMesAnterior;

  int get mejorDiaSemana => ultimos7Dias.isEmpty
      ? 0
      : ultimos7Dias.map((d) => d.pasos).reduce((a, b) => a > b ? a : b);

  static PasosEstadisticas fromRegistros(List<PasosRegistro> registros) {
    if (registros.isEmpty) {
      return PasosEstadisticas(
        ultimos7Dias: _buildUltimos7DiasLista(const {}),
        promedioUltimos7: 0,
        pasosHoy: 0,
        promedioHistorico: 0,
        promedioMesActual: 0,
        promedioMesAnterior: 0,
      );
    }

    final hoy = DateTime.now();
    final hoyKey = DateTime(hoy.year, hoy.month, hoy.day);

    final mapPorFecha = <DateTime, PasosRegistro>{};
    for (final registro in registros) {
      final key = DateTime(
          registro.fecha.year, registro.fecha.month, registro.fecha.day);
      mapPorFecha[key] = registro;
    }

    final ultimos7 = <DateTime, int>{};
    for (int i = 6; i >= 0; i--) {
      final dia = hoyKey.subtract(Duration(days: i));
      ultimos7[dia] = mapPorFecha[dia]?.pasos ?? 0;
    }

    final pasosHoy = mapPorFecha[hoyKey]?.pasos ?? 0;
    final promedioUltimos7 = ultimos7.values.isEmpty
        ? 0
        : (ultimos7.values.reduce((a, b) => a + b) / ultimos7.length).round();

    final promedioHistorico = registros.isEmpty
        ? 0
        : (registros.map((e) => e.pasos).reduce((a, b) => a + b) /
                registros.length)
            .round();

    final inicioMesActual = DateTime(hoy.year, hoy.month, 1);
    final inicioMesSiguiente = DateTime(hoy.year, hoy.month + 1, 1);
    final inicioMesAnterior = DateTime(hoy.year, hoy.month - 1, 1);

    final registrosMesActual = registros.where((r) {
      final date = DateTime(r.fecha.year, r.fecha.month, r.fecha.day);
      return !date.isBefore(inicioMesActual) &&
          date.isBefore(inicioMesSiguiente);
    }).toList();

    final registrosMesAnterior = registros.where((r) {
      final date = DateTime(r.fecha.year, r.fecha.month, r.fecha.day);
      return !date.isBefore(inicioMesAnterior) &&
          date.isBefore(inicioMesActual);
    }).toList();

    final promedioMesActual = registrosMesActual.isEmpty
        ? 0
        : (registrosMesActual.map((e) => e.pasos).reduce((a, b) => a + b) /
                registrosMesActual.length)
            .round();

    final promedioMesAnterior = registrosMesAnterior.isEmpty
        ? 0
        : (registrosMesAnterior.map((e) => e.pasos).reduce((a, b) => a + b) /
                registrosMesAnterior.length)
            .round();

    return PasosEstadisticas(
      ultimos7Dias: _buildUltimos7DiasLista(ultimos7),
      promedioUltimos7: promedioUltimos7,
      pasosHoy: pasosHoy,
      promedioHistorico: promedioHistorico,
      promedioMesActual: promedioMesActual,
      promedioMesAnterior: promedioMesAnterior,
    );
  }

  static List<PasosDia> _buildUltimos7DiasLista(Map<DateTime, int> data) {
    return data.entries
        .map((e) => PasosDia(fecha: e.key, pasos: e.value))
        .toList()
      ..sort((a, b) => a.fecha.compareTo(b.fecha));
  }
}
