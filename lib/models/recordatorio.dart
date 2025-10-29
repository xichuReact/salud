import 'package:isar/isar.dart';

part 'recordatorio.g.dart';

@collection
class Recordatorio {
  Id id = Isar.autoIncrement;

  late String titulo;
  String? descripcion;

  // Días de la semana (0=Domingo, 1=Lunes, ..., 6=Sábado)
  late List<int> diasSemana;

  // Hora del recordatorio (formato HH:mm)
  late String hora; // "09:00", "18:30", etc.

  late bool activo;

  late DateTime fechaCreacion;
  DateTime? ultimaNotificacion;

  // IDs de las notificaciones programadas para cada día
  // Necesitamos uno por día de la semana para poder cancelarlos individualmente
  late List<int> notificationIds;

  // Sonido de la notificación: 'default' | 'silent' | (futuros sonidos)
  String? sonido; // null => 'default'
}
