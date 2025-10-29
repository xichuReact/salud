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
  DateTime? _inicioActivo;
  int _acumulado = 0;

  CronometroController() : super(const CronometroState());

  void iniciar() {
    if (state.corriendo) return;

    if (!state.pausado) {
      _acumulado = 0;
      state = const CronometroState();
    }

    _inicioActivo = DateTime.now();
    state = state.copyWith(corriendo: true, pausado: false);
    _iniciarTicker();
  }

  void pausar() {
    if (!state.corriendo || state.pausado) return;

    final ahora = DateTime.now();
    if (_inicioActivo != null) {
      _acumulado += ahora.difference(_inicioActivo!).inSeconds;
      _inicioActivo = null;
    }

    _detenerTicker();
    state = state.copyWith(
      corriendo: false,
      pausado: true,
      segundos: _acumulado,
    );
  }

  void reanudar() {
    if (!state.pausado) return;

    _inicioActivo = DateTime.now();
    state = state.copyWith(corriendo: true, pausado: false);
    _iniciarTicker();
  }

  void detener() {
    if (!_estaActivo) return;

    pausar();
    _acumulado = 0;
    _inicioActivo = null;
    state = const CronometroState();
  }

  void reiniciar() {
    _detenerTicker();
    _inicioActivo = null;
    _acumulado = 0;
    state = const CronometroState();
  }

  int obtenerTiempoFinal() {
    final total = _elapsedSeconds;
    reiniciar();
    return total;
  }

  void sincronizar() {
    state = state.copyWith(segundos: _elapsedSeconds);
  }

  void manejarPausaSistema() {
    if (state.corriendo) {
      sincronizar();
      _detenerTicker();
    }
  }

  void reanudarSiCorriendo() {
    if (state.corriendo) {
      _inicioActivo ??= DateTime.now();
      sincronizar();
      _iniciarTicker();
    }
  }

  @override
  void dispose() {
    _detenerTicker();
    super.dispose();
  }

  bool get _estaActivo => state.corriendo || state.pausado;

  int get _elapsedSeconds {
    final base = _acumulado;
    if (_inicioActivo != null) {
      return base + DateTime.now().difference(_inicioActivo!).inSeconds;
    }
    return base;
  }

  void _iniciarTicker() {
    _detenerTicker();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(segundos: _elapsedSeconds);
    });
    // Actualizar de inmediato para reflejar el salto tras reanudar
    state = state.copyWith(segundos: _elapsedSeconds);
  }

  void _detenerTicker() {
    _timer?.cancel();
    _timer = null;
  }
}

// Provider del controller
final cronometroControllerProvider =
    StateNotifierProvider<CronometroController, CronometroState>((ref) {
  return CronometroController();
});
