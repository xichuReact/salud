import 'package:isar/isar.dart';

part 'pasos_registro.g.dart';

@collection
class PasosRegistro {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime fecha;

  late int pasos;

  DateTime get fechaSinHora => DateTime(fecha.year, fecha.month, fecha.day);
}
