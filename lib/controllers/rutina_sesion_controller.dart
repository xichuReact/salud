import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rutina.dart';

class RutinaSesion {
  final int rutinaId;
  int ejercicioActual;
  final List<List<bool>> seriesCompletadas; // [ejercicioIndex][serieIndex]
  final DateTime inicio;
  int? sensacion; // 5 = con fuerza, 3 = poca fuerza, 1 = sin fuerza

  RutinaSesion({
    required this.rutinaId,
    required this.ejercicioActual,
    required this.seriesCompletadas,
    required this.inicio,
    this.sensacion,
  });

  bool get iniciada => true;

  RutinaSesion copyWith({
    int? ejercicioActual,
    List<List<bool>>? seriesCompletadas,
    int? sensacion,
  }) {
    return RutinaSesion(
      rutinaId: rutinaId,
      ejercicioActual: ejercicioActual ?? this.ejercicioActual,
      seriesCompletadas: seriesCompletadas ?? this.seriesCompletadas,
      inicio: inicio,
      sensacion: sensacion ?? this.sensacion,
    );
  }
}

class RutinaSesionController extends StateNotifier<Map<int, RutinaSesion>> {
  RutinaSesionController() : super({});

  bool isActiva(int rutinaId) => state.containsKey(rutinaId);

  RutinaSesion? getSesion(int rutinaId) => state[rutinaId];

  void iniciar(Rutina rutina) {
    if (state.containsKey(rutina.id)) return; // ya iniciada

    // Construir estructura de series
    final series = rutina.ejercicios
        .map((ej) => List<bool>.filled(ej.series, false))
        .toList();

    state = {
      ...state,
      rutina.id: RutinaSesion(
        rutinaId: rutina.id,
        ejercicioActual: 0,
        seriesCompletadas: series,
        inicio: DateTime.now(),
        sensacion: null,
      ),
    };
  }

  void reanudarSiExiste(Rutina rutina) {
    // no-op si no existe
    if (!state.containsKey(rutina.id)) {
      iniciar(rutina);
    }
  }

  void terminar(int rutinaId) {
    if (!state.containsKey(rutinaId)) return;
    final newState = Map<int, RutinaSesion>.from(state);
    newState.remove(rutinaId);
    state = newState;
  }

  void toggleSerie({
    required int rutinaId,
    required int ejercicioIndex,
    required int serieIndex,
    required bool value,
  }) {
    final sesion = state[rutinaId];
    if (sesion == null) return;

    final newSeries = sesion.seriesCompletadas
        .map((inner) => List<bool>.from(inner))
        .toList();
    if (ejercicioIndex < 0 ||
        ejercicioIndex >= newSeries.length ||
        serieIndex < 0 ||
        serieIndex >= newSeries[ejercicioIndex].length) {
      return;
    }

    newSeries[ejercicioIndex][serieIndex] = value;

    state = {
      ...state,
      rutinaId: sesion.copyWith(seriesCompletadas: newSeries),
    };
  }

  void setEjercicioActual({required int rutinaId, required int index}) {
    final sesion = state[rutinaId];
    if (sesion == null) return;
    state = {
      ...state,
      rutinaId: sesion.copyWith(ejercicioActual: index),
    };
  }

  void setSensacion({required int rutinaId, required int? sensacion}) {
    final sesion = state[rutinaId];
    if (sesion == null) return;
    state = {
      ...state,
      rutinaId: sesion.copyWith(sensacion: sensacion),
    };
  }
}

final rutinaSesionProvider =
    StateNotifierProvider<RutinaSesionController, Map<int, RutinaSesion>>(
        (ref) => RutinaSesionController());
