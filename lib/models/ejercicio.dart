import 'package:isar/isar.dart';

part 'ejercicio.g.dart';

@collection
class Ejercicio {
  Id id = Isar.autoIncrement;

  @Index()
  late String nombre;

  String? descripcion;

  // Tipo de ejercicio: 'fuerza', 'cardio', 'flexibilidad', 'otro'
  @Index()
  late String tipo;

  // Grupos musculares: 'pecho', 'espalda', 'piernas', 'brazos', 'core', 'cardio'
  List<String> gruposMusculares = [];

  // Unidad de medida: 'repeticiones', 'tiempo', 'distancia', 'peso'
  late String unidadMedida;

  // Configuración por defecto
  int? seriesPorDefecto;
  int? repeticionesPorDefecto;
  double? pesoPorDefecto;

  // Metadata
  DateTime fechaCreacion = DateTime.now();
  bool activo = true;

  // Color para UI (hex string)
  String? color;

  // Icono (nombre del icono de Material Icons)
  String? icono;

  // Preparado para Firebase
  String? firebaseId;
}
