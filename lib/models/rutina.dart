import 'package:isar/isar.dart';

part 'rutina.g.dart';

@collection
class Rutina {
  Id id = Isar.autoIncrement;

  @Index()
  late String nombre;

  String? descripcion;

  // Ejercicios en esta rutina
  List<EjercicioRutina> ejercicios = [];

  // Días de la semana: 0=Domingo, 1=Lunes, ..., 6=Sábado
  List<int> diasSemana = [];

  // Duración estimada en minutos
  int? duracionEstimada;

  // Color para UI
  String? color;

  DateTime fechaCreacion = DateTime.now();
  bool activa = true;

  // Preparado para Firebase
  String? firebaseId;
}

@embedded
class EjercicioRutina {
  late int ejercicioId;
  int orden = 0;
  int series = 3;
  int repeticiones = 10;
  double? peso;
  int? descansoSegundos;
}
