import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recordatorio.dart';
import '../services/isar_service.dart';
import '../services/notification_service.dart';
import 'package:isar/isar.dart';

final recordatorioControllerProvider = StateNotifierProvider<
    RecordatorioController, AsyncValue<List<Recordatorio>>>((ref) {
  return RecordatorioController();
});

class RecordatorioController
    extends StateNotifier<AsyncValue<List<Recordatorio>>> {
  RecordatorioController() : super(const AsyncValue.loading()) {
    loadRecordatorios();
  }

  final _isarService = IsarService();
  final _notificationService = NotificationService();

  Future<void> loadRecordatorios() async {
    state = const AsyncValue.loading();
    try {
      final recordatorios = await _isarService.db.recordatorios
          .where()
          .sortByFechaCreacion()
          .findAll();
      state = AsyncValue.data(recordatorios);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> agregarRecordatorio({
    required String titulo,
    String? descripcion,
    required List<int> diasSemana,
    required String hora,
    String? sonido,
  }) async {
    try {
      // Verificar y solicitar permisos antes de crear
      final canSchedule = await _notificationService.canScheduleExactAlarms();
      if (!canSchedule) {
        final granted = await _notificationService.requestPermissions();
        if (!granted) {
          throw Exception(
              'Se requieren permisos de notificaciones y alarmas exactas');
        }
      }

      // Generar IDs únicos para las notificaciones de cada día
      final baseId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final notificationIds = List.generate(
        diasSemana.length,
        (index) => baseId + index,
      );

      final recordatorio = Recordatorio()
        ..titulo = titulo
        ..descripcion = descripcion
        ..diasSemana = diasSemana
        ..hora = hora
        ..activo = true
        ..fechaCreacion = DateTime.now()
        ..notificationIds = notificationIds
        ..sonido = sonido;

      await _isarService.db.writeTxn(() async {
        await _isarService.db.recordatorios.put(recordatorio);
      });

      // Programar notificaciones
      await _notificationService.scheduleRecordatorio(recordatorio);

      await loadRecordatorios();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> actualizarRecordatorio(Recordatorio recordatorio) async {
    try {
      // Obtener versión previa para cancelar notificaciones antiguas
      final previo = await _isarService.db.recordatorios.get(recordatorio.id);
      if (previo != null) {
        await _notificationService.cancelRecordatorio(previo);
      }

      // Asegurar que notificationIds coincidan con la cantidad de días
      if (recordatorio.notificationIds.length !=
          recordatorio.diasSemana.length) {
        final baseId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        recordatorio.notificationIds = List.generate(
          recordatorio.diasSemana.length,
          (index) => baseId + index,
        );
      }

      await _isarService.db.writeTxn(() async {
        await _isarService.db.recordatorios.put(recordatorio);
      });

      // Reprogramar notificaciones con los datos actualizados
      await _notificationService.scheduleRecordatorio(recordatorio);

      await loadRecordatorios();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleActivo(Recordatorio recordatorio) async {
    try {
      recordatorio.activo = !recordatorio.activo;

      await _isarService.db.writeTxn(() async {
        await _isarService.db.recordatorios.put(recordatorio);
      });

      if (recordatorio.activo) {
        await _notificationService.scheduleRecordatorio(recordatorio);
      } else {
        await _notificationService.cancelRecordatorio(recordatorio);
      }

      await loadRecordatorios();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> eliminarRecordatorio(int id) async {
    try {
      // Obtener el recordatorio para cancelar sus notificaciones
      final recordatorio = await _isarService.db.recordatorios.get(id);
      if (recordatorio != null) {
        await _notificationService.cancelRecordatorio(recordatorio);
      }

      await _isarService.db.writeTxn(() async {
        await _isarService.db.recordatorios.delete(id);
      });

      await loadRecordatorios();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> testNotification() async {
    await _notificationService.showNotification(
      id: 999999,
      title: '¡Prueba de notificación!',
      body: '¿Estás listo para hacer ejercicio?',
    );
  }
}
