import 'package:isar/isar.dart';

part 'alimento.g.dart';

/// Modelo para registros de alimentos consumidos
@collection
class RegistroAlimento {
  Id id = Isar.autoIncrement;

  // Información del alimento
  @Index()
  late String nombre;

  String? descripcion;

  // Valores nutricionales
  late double calorias;
  late double proteinas; // en gramos
  late double carbohidratos; // en gramos
  late double grasas; // en gramos

  // Porción
  late double cantidad; // ej: 100, 1, 2.5
  late String unidadMedida; // 'gramos', 'unidad', 'taza', 'ml', etc.

  // Tipo de comida: 'desayuno', 'comida', 'cena', 'snack'
  @Index()
  late String tipoComida;

  // Fecha y hora del registro
  @Index()
  late DateTime fecha;

  // Metadata
  DateTime fechaCreacion = DateTime.now();

  // Preparado para Firebase
  String? firebaseId;

  /// Calcular calorías totales basado en macros si no se proporciona
  double get caloriasCalculadas {
    // 1g proteína = 4 kcal, 1g carbohidratos = 4 kcal, 1g grasa = 9 kcal
    return (proteinas * 4) + (carbohidratos * 4) + (grasas * 9);
  }

  /// Verificar si es del día actual
  bool get esHoy {
    final now = DateTime.now();
    return fecha.year == now.year &&
        fecha.month == now.month &&
        fecha.day == now.day;
  }
}

/// Modelo para biblioteca de alimentos predefinidos (opcional)
@collection
class AlimentoBase {
  Id id = Isar.autoIncrement;

  @Index()
  late String nombre;

  String? descripcion;
  String? categoria; // 'frutas', 'proteinas', 'granos', etc.

  // Valores por 100g o por unidad
  late double calorias;
  late double proteinas;
  late double carbohidratos;
  late double grasas;

  // Porción de referencia
  late double cantidadReferencia; // 100
  late String unidadReferencia; // 'gramos'

  bool activo = true;
  DateTime fechaCreacion = DateTime.now();

  // Icono y color para UI
  String? icono;
  String? color;

  String? firebaseId;
}
