import 'package:isar/isar.dart';

part 'registro_agua.g.dart';

@collection
class RegistroAgua {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime fecha;

  // Cantidad en mililitros
  late int cantidadMl;

  // Objetivo diario en ml (por defecto 2000ml = 2L)
  int objetivoDiario = 2000;

  // Metadata
  String? nota;

  // Para sincronización futura
  String? firebaseId;

  DateTime fechaCreacion = DateTime.now();
}
