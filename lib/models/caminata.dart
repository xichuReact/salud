import 'package:isar/isar.dart';

part 'caminata.g.dart';

@collection
class Caminata {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime fecha;

  // Duración en segundos
  late int duracionSegundos;

  // Distancia opcional en metros
  double? distanciaMetros;

  // Desnivel opcional en metros
  double? desnivelMetros;

  // Ubicación/ruta
  String? ubicacion;

  // Calorías estimadas
  int? caloriasEstimadas;

  // Ritmo cardiaco promedio
  int? ritmoCardiacoPromedio;

  // Notas
  String? notas;

  // Preparado para Firebase
  String? firebaseId;
}
