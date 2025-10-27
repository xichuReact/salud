import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Estado del cronómetro
class CronometroState {
  final int segundos;
  final bool corriendo;
  final bool pausado;

  const CronometroState({
    this.segundos = 0,
    this.corriendo = false,
    this.pausado = false,
  });

  CronometroState copyWith({
    int? segundos,
    bool? corriendo,
    bool? pausado,
  }) {
    return CronometroState(
      segundos: segundos ?? this.segundos,
      corriendo: corriendo ?? this.corriendo,
      pausado: pausado ?? this.pausado,
    );
  }

  String get tiempoFormateado {
    final horas = segundos ~/ 3600;
    final minutos = (segundos % 3600) ~/ 60;
    final segs = segundos % 60;
    
    if (horas > 0) {
      return '${horas.toString().padLeft(2, '0')}:${minutos.toString().padLeft(2, '0')}:${segs.toString().padLeft(2, '0')}';
    }
    return '${minutos.toString().padLeft(2, '0')}:${segs.toString().padLeft(2, '0')}';
  }
}

// Controller del cronómetro
class CronometroController extends StateNotifier<CronometroState> {
  Timer? _timer;

  CronometroController() : super(const CronometroState());

  void iniciar() {
    if (!state.corriendo) {
      state = state.copyWith(corriendo: true, pausado: false);
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        state = state.copyWith(segundos: state.segundos + 1);
      });
    }
  }

  void pausar() {
    if (state.corriendo && !state.pausado) {
      _timer?.cancel();
      state = state.copyWith(corriendo: false, pausado: true);
    }
  }

  void reanudar() {
    if (state.pausado) {
      iniciar();
    }
  }

  void detener() {
    _timer?.cancel();
    state = state.copyWith(corriendo: false, pausado: false);
  }

  void reiniciar() {
    _timer?.cancel();
    state = const CronometroState();
  }

  int obtenerTiempoFinal() {
    final tiempo = state.segundos;
    reiniciar();
    return tiempo;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// Provider del controller
final cronometroControllerProvider = StateNotifierProvider<CronometroController, CronometroState>((ref) {
  return CronometroController();
});
