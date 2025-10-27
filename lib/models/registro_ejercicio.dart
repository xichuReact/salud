import 'package:isar/isar.dart';

part 'registro_ejercicio.g.dart';

@collection
class RegistroEjercicio {
  Id id = Isar.autoIncrement;

  // Relación con Ejercicio
  @Index()
  late int ejercicioId;

  // Fecha y hora del registro
  @Index()
  late DateTime fecha;

  // Series realizadas
  List<Serie> series = [];

  // Notas opcionales
  String? notas;

  // Duración total del ejercicio en segundos
  int? duracionSegundos;

  // Sensación: 1-5 (1=muy fácil, 5=muy difícil)
  int? sensacion;

  // Preparado para Firebase
  String? firebaseId;
}

@embedded
class Serie {
  int repeticiones = 0;
  double? peso;
  int? duracionSegundos;
  bool completada = true;
}
