import 'package:isar/isar.dart';

part 'plan_semanal.g.dart';

@collection
class PlanSemanal {
  Id id = Isar.autoIncrement;

  // Fecha de inicio de la semana
  @Index()
  late DateTime fechaInicio;

  // Fecha de fin de la semana
  late DateTime fechaFin;

  // Días planificados
  List<DiaPlanificado> dias = [];

  String? notas;

  // Preparado para Firebase
  String? firebaseId;
}

@embedded
class DiaPlanificado {
  late DateTime fecha;
  
  // IDs de rutinas planificadas para este día
  List<int> rutinaIds = [];
  
  // Completado
  bool completado = false;
  
  // Notas del día
  String? notas;
}
