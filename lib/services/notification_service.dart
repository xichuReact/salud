import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/recordatorio.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  // Canal de notificación (usar un ID nuevo para forzar importancia correcta)
  static const String _channelName = 'Recordatorios de Ejercicio';
  static const String _channelDescription =
      'Notificaciones para recordar hacer ejercicio';
  static const String _channelDefault = 'recordatorios_ejercicio_v2_default';
  static const String _channelSilent = 'recordatorios_ejercicio_v2_silent';
  static const String _channelRadial = 'recordatorios_ejercicio_v2_radial';
  static const String _channelCampana = 'recordatorios_ejercicio_v2_campana';
  static const String _channelBeep = 'recordatorios_ejercicio_v2_beep';

  Future<void> initialize() async {
    if (_initialized) return;

    // Inicializar timezones
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Mexico_City'));

    // Configuración Android
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuración iOS
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Crear canales por sonido (Android)
    final android = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      // Canal con sonido por defecto
      await android.createNotificationChannel(const AndroidNotificationChannel(
        _channelDefault,
        _channelName,
        description: _channelDescription,
        importance: Importance.max,
        playSound: true,
      ));

      // Canal silencioso (solo vibración)
      await android.createNotificationChannel(const AndroidNotificationChannel(
        _channelSilent,
        _channelName,
        description: 'Recordatorios sin sonido',
        importance: Importance.max,
        playSound: false,
      ));

      // Canales con sonidos personalizados (requieren archivos en res/raw)
      // Si los recursos no existen, Android usará el sonido por defecto del canal o puede fallar la creación.
      // Por eso mantenemos además el fallback a canalDefault más adelante.
      await android.createNotificationChannel(const AndroidNotificationChannel(
        _channelRadial,
        _channelName,
        description: 'Recordatorios sonido Radial',
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('radial'),
      ));
      await android.createNotificationChannel(const AndroidNotificationChannel(
        _channelCampana,
        _channelName,
        description: 'Recordatorios sonido Campana',
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('campana'),
      ));
      await android.createNotificationChannel(const AndroidNotificationChannel(
        _channelBeep,
        _channelName,
        description: 'Recordatorios sonido Beep',
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('beep'),
      ));
    }

    _initialized = true;
    debugPrint('NotificationService initialized');
  }

  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    // Aquí puedes navegar a una pantalla específica si es necesario
  }

  Future<bool> requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidPlugin =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlugin != null) {
        // Solicitar permiso de notificaciones
        final notifGranted =
            await androidPlugin.requestNotificationsPermission();

        // Solicitar permiso de alarmas exactas (Android 12+)
        final exactAlarmGranted =
            await androidPlugin.requestExactAlarmsPermission();

        debugPrint('Notification permission: $notifGranted');
        debugPrint('Exact alarm permission: $exactAlarmGranted');

        return (notifGranted ?? false) && (exactAlarmGranted ?? false);
      }
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosPlugin = _notifications.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();

      if (iosPlugin != null) {
        final granted = await iosPlugin.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return granted ?? false;
      }
    }

    return false;
  }

  Future<bool> canScheduleExactAlarms() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidPlugin =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlugin != null) {
        return await androidPlugin.canScheduleExactNotifications() ?? false;
      }
    }
    return true; // iOS siempre puede
  }

  Future<void> scheduleRecordatorio(Recordatorio recordatorio) async {
    if (!_initialized) await initialize();

    // Cancelar notificaciones anteriores si existen
    await cancelRecordatorio(recordatorio);

    if (!recordatorio.activo) return;

    // Alinear longitudes para evitar errores por edición
    if (recordatorio.notificationIds.length != recordatorio.diasSemana.length) {
      debugPrint(
          '⚠️ Mismatch entre diasSemana(${recordatorio.diasSemana.length}) y notificationIds(${recordatorio.notificationIds.length}). Usando IDs temporales.');
      final baseId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      recordatorio.notificationIds = List.generate(
        recordatorio.diasSemana.length,
        (index) => baseId + index,
      );
    }

    // Parsear hora (formato "HH:mm")
    final timeParts = recordatorio.hora.split(':');
    if (timeParts.length != 2) {
      debugPrint('Formato de hora inválido: ${recordatorio.hora}');
      return;
    }

    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    // Programar una notificación para cada día seleccionado
    final now = tz.TZDateTime.now(tz.local);

    for (int i = 0; i < recordatorio.diasSemana.length; i++) {
      final dayOfWeek =
          recordatorio.diasSemana[i]; // 0 = Domingo, 1 = Lunes, etc.
      final notificationId = recordatorio.notificationIds[i];

      // Calcular el próximo día de la semana
      // En Dart: DateTime.weekday devuelve 1-7 (Lunes=1, Domingo=7)
      // Necesitamos convertir: 0=Domingo -> 7, 1=Lunes -> 1, etc.
      final targetWeekday = dayOfWeek == 0 ? 7 : dayOfWeek;

      var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      // Ajustar al día de la semana correcto
      while (scheduledDate.weekday != targetWeekday) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      // Si la hora ya pasó hoy y es el mismo día, programar para la próxima semana
      if (scheduledDate.isBefore(now) || scheduledDate.isAtSameMomentAs(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 7));
      }

      debugPrint('📅 Programando notificación:');
      debugPrint('   - ID: $notificationId');
      debugPrint('   - Día: $dayOfWeek (targetWeekday: $targetWeekday)');
      debugPrint('   - Fecha: ${scheduledDate.toString()}');
      debugPrint('   - Hora: $hour:$minute');

      final soundKey = (recordatorio.sonido ?? 'default');
      String channelId;
      switch (soundKey) {
        case 'silent':
          channelId = _channelSilent;
          break;
        case 'radial':
          channelId = _channelRadial;
          break;
        case 'campana':
          channelId = _channelCampana;
          break;
        case 'beep':
          channelId = _channelBeep;
          break;
        default:
          channelId = _channelDefault;
      }

      await _notifications.zonedSchedule(
        notificationId,
        recordatorio.titulo,
        recordatorio.descripcion ?? '¡Es hora de hacer ejercicio!',
        scheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channelId,
            _channelName,
            channelDescription: soundKey == 'silent'
                ? 'Recordatorios sin sonido'
                : _channelDescription,
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            playSound: soundKey != 'silent',
            enableVibration: true,
            vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
            enableLights: true,
            ledColor: const Color(0xFFFF0000),
            ledOnMs: 1000,
            ledOffMs: 500,
            fullScreenIntent: true,
            category: AndroidNotificationCategory.alarm,
            visibility: NotificationVisibility.public,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );

      debugPrint(
          'Notificación programada: ID=$notificationId, día=$dayOfWeek, hora=$hour:$minute');
    }
  }

  Future<void> cancelRecordatorio(Recordatorio recordatorio) async {
    for (final notificationId in recordatorio.notificationIds) {
      await _notifications.cancel(notificationId);
      debugPrint('Notificación cancelada: ID=$notificationId');
    }
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
    debugPrint('Todas las notificaciones canceladas');
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }

  // Mostrar notificación inmediata (para pruebas)
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    if (!_initialized) await initialize();

    await _notifications.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelDefault,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          playSound: true,
          enableVibration: true,
          vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
          enableLights: true,
          category: AndroidNotificationCategory.alarm,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  // Programar notificación de prueba en X segundos
  Future<void> scheduleTestNotification({
    required int seconds,
    String title = 'Prueba de Alarma',
    String body = '¡La alarma está funcionando correctamente!',
  }) async {
    if (!_initialized) await initialize();

    final scheduledDate =
        tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds));

    debugPrint(
        '📱 Programando notificación de prueba para: ${scheduledDate.toString()}');

    await _notifications.zonedSchedule(
      999999,
      title,
      body,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelDefault,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          playSound: true,
          enableVibration: true,
          vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]),
          enableLights: true,
          ledColor: const Color(0xFFFF0000),
          ledOnMs: 1000,
          ledOffMs: 500,
          fullScreenIntent: true,
          category: AndroidNotificationCategory.alarm,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
