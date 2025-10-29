import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../models/ejercicio.dart';
import '../models/registro_ejercicio.dart';
import '../models/rutina.dart';
import '../services/isar_service.dart';

/// Script para poblar la base de datos con datos de ejemplo
class SeedData {
  static Future<void> seedEjercicios() async {
    final isar = IsarService().db;

    // Verificar si ya hay ejercicios
    final count = await isar.ejercicios.count();
    if (count > 0) {
      debugPrint('Ya existen ejercicios en la base de datos');
      return;
    }

    Ejercicio crearEjercicio({
      required String nombre,
      String? descripcion,
      required String tipo,
      List<String> grupos = const [],
      required String unidad,
      int? series,
      int? repeticiones,
      double? peso,
      String? color,
      String? icono,
    }) {
      return Ejercicio()
        ..nombre = nombre
        ..descripcion = descripcion
        ..tipo = tipo
        ..gruposMusculares = List<String>.from(grupos)
        ..unidadMedida = unidad
        ..seriesPorDefecto = series
        ..repeticionesPorDefecto = repeticiones
        ..pesoPorDefecto = peso
        ..color = color
        ..icono = icono;
    }

    const fuerzaColor = '#EF4444';
    const cardioColor = '#3B82F6';
    const flexColor = '#8B5CF6';
    const otroColor = '#F59E0B';

    final ejercicios = <Ejercicio>[
      // Fuerza - Pecho y Espalda
      crearEjercicio(
        nombre: 'Press de banca',
        descripcion: 'Press con barra para pecho y triceps',
        tipo: 'fuerza',
        grupos: ['pecho', 'brazos'],
        unidad: 'repeticiones',
        series: 4,
        repeticiones: 10,
        peso: 40,
        color: fuerzaColor,
        icono: 'fitness_center',
      ),
      crearEjercicio(
        nombre: 'Press inclinado con mancuernas',
        descripcion: 'Trabaja la parte superior del pecho',
        tipo: 'fuerza',
        grupos: ['pecho', 'brazos'],
        unidad: 'repeticiones',
        series: 4,
        repeticiones: 10,
        color: fuerzaColor,
        icono: 'fitness_center',
      ),
      crearEjercicio(
        nombre: 'Flexiones',
        descripcion: 'Flexiones de brazos con peso corporal',
        tipo: 'fuerza',
        grupos: ['pecho', 'brazos', 'core'],
        unidad: 'repeticiones',
        series: 3,
        repeticiones: 15,
        color: fuerzaColor,
        icono: 'push_pin',
      ),
      crearEjercicio(
        nombre: 'Dominadas',
        descripcion: 'Pull ups con agarre pronado',
        tipo: 'fuerza',
        grupos: ['espalda', 'brazos'],
        unidad: 'repeticiones',
        series: 4,
        repeticiones: 8,
        color: fuerzaColor,
        icono: 'sports_martial_arts',
      ),
      crearEjercicio(
        nombre: 'Remo con barra',
        descripcion: 'Remo inclinado para espalda media',
        tipo: 'fuerza',
        grupos: ['espalda'],
        unidad: 'repeticiones',
        series: 4,
        repeticiones: 10,
        color: fuerzaColor,
        icono: 'rowing',
      ),
      crearEjercicio(
        nombre: 'Face pull en polea',
        descripcion: 'Fortalece deltoides posteriores y espalda alta',
        tipo: 'fuerza',
        grupos: ['espalda', 'hombros'],
        unidad: 'repeticiones',
        series: 3,
        repeticiones: 15,
        color: fuerzaColor,
        icono: 'psychology',
      ),

      // Fuerza - Piernas y Gluteos
      crearEjercicio(
        nombre: 'Sentadilla trasera',
        descripcion: 'Sentadilla profunda con barra',
        tipo: 'fuerza',
        grupos: ['piernas', 'core'],
        unidad: 'repeticiones',
        series: 4,
        repeticiones: 8,
        peso: 60,
        color: fuerzaColor,
        icono: 'sports_gymnastics',
      ),
      crearEjercicio(
        nombre: 'Sentadilla frontal',
        descripcion: 'Variacion frontal para cuadriceps y core',
        tipo: 'fuerza',
        grupos: ['piernas', 'core'],
        unidad: 'repeticiones',
        series: 4,
        repeticiones: 8,
        color: fuerzaColor,
        icono: 'sports_martial_arts',
      ),
      crearEjercicio(
        nombre: 'Zancadas caminando',
        descripcion: 'Lunges alternos con mancuerna',
        tipo: 'fuerza',
        grupos: ['piernas', 'gluteos'],
        unidad: 'repeticiones',
        series: 3,
        repeticiones: 12,
        color: fuerzaColor,
        icono: 'directions_walk',
      ),
      crearEjercicio(
        nombre: 'Peso muerto rumano',
        descripcion: 'Enfasis en isquiotibiales y gluteos',
        tipo: 'fuerza',
        grupos: ['piernas', 'espalda'],
        unidad: 'repeticiones',
        series: 4,
        repeticiones: 10,
        color: fuerzaColor,
        icono: 'self_improvement',
      ),
      crearEjercicio(
        nombre: 'Hip thrust',
        descripcion: 'Elevacion de cadera con barra',
        tipo: 'fuerza',
        grupos: ['gluteos', 'piernas'],
        unidad: 'repeticiones',
        series: 4,
        repeticiones: 12,
        color: fuerzaColor,
        icono: 'airline_seat_flat',
      ),
      crearEjercicio(
        nombre: 'Prensa de piernas',
        descripcion: 'Prensa inclinada para cuadriceps',
        tipo: 'fuerza',
        grupos: ['piernas'],
        unidad: 'repeticiones',
        series: 4,
        repeticiones: 12,
        color: fuerzaColor,
        icono: 'directions_bus_filled',
      ),

      // Fuerza - Hombros y Brazos
      crearEjercicio(
        nombre: 'Press militar de pie',
        descripcion: 'Press overhead con barra',
        tipo: 'fuerza',
        grupos: ['hombros', 'brazos'],
        unidad: 'repeticiones',
        series: 4,
        repeticiones: 8,
        color: fuerzaColor,
        icono: 'military_tech',
      ),
      crearEjercicio(
        nombre: 'Elevaciones laterales',
        descripcion: 'Mancuernas para deltoides medios',
        tipo: 'fuerza',
        grupos: ['hombros'],
        unidad: 'repeticiones',
        series: 3,
        repeticiones: 15,
        color: fuerzaColor,
        icono: 'flare',
      ),
      crearEjercicio(
        nombre: 'Curl de biceps con mancuernas',
        descripcion: 'Curl alterno en bipedestacion',
        tipo: 'fuerza',
        grupos: ['brazos'],
        unidad: 'repeticiones',
        series: 3,
        repeticiones: 12,
        color: fuerzaColor,
        icono: 'front_hand',
      ),
      crearEjercicio(
        nombre: 'Extension de triceps en polea',
        descripcion: 'Trabajo de triceps con cuerda',
        tipo: 'fuerza',
        grupos: ['brazos'],
        unidad: 'repeticiones',
        series: 3,
        repeticiones: 12,
        color: fuerzaColor,
        icono: 'precision_manufacturing',
      ),

      // Core y estabilidad
      crearEjercicio(
        nombre: 'Plancha frontal',
        descripcion: 'Plancha isometrica tradicional',
        tipo: 'fuerza',
        grupos: ['core'],
        unidad: 'tiempo',
        series: 3,
        color: fuerzaColor,
        icono: 'view_stream',
      ),
      crearEjercicio(
        nombre: 'Plancha lateral',
        descripcion: 'Plancha apoyada en antebrazo lateral',
        tipo: 'fuerza',
        grupos: ['core'],
        unidad: 'tiempo',
        series: 3,
        color: fuerzaColor,
        icono: 'segment',
      ),
      crearEjercicio(
        nombre: 'Mountain climbers',
        descripcion: 'Escaladores dinamicos para core y cardio',
        tipo: 'fuerza',
        grupos: ['core', 'cardio'],
        unidad: 'tiempo',
        series: 4,
        color: fuerzaColor,
        icono: 'terrain',
      ),
      crearEjercicio(
        nombre: 'Russian twist',
        descripcion: 'Giros de torso con peso',
        tipo: 'fuerza',
        grupos: ['core'],
        unidad: 'repeticiones',
        series: 3,
        repeticiones: 20,
        color: fuerzaColor,
        icono: 'rotate_right',
      ),
      crearEjercicio(
        nombre: 'Dead bug',
        descripcion: 'Ejercicio anti extension controlado',
        tipo: 'fuerza',
        grupos: ['core'],
        unidad: 'repeticiones',
        series: 3,
        repeticiones: 12,
        color: fuerzaColor,
        icono: 'bug_report',
      ),

      // Cardio y acondicionamiento
      crearEjercicio(
        nombre: 'Correr continuo',
        descripcion: 'Rodaje suave en exterior o cinta',
        tipo: 'cardio',
        grupos: ['cardio'],
        unidad: 'tiempo',
        color: cardioColor,
        icono: 'directions_run',
      ),
      crearEjercicio(
        nombre: 'Sprints en pista',
        descripcion: 'Intervalos de alta intensidad',
        tipo: 'cardio',
        grupos: ['cardio'],
        unidad: 'distancia',
        color: cardioColor,
        icono: 'speed',
      ),
      crearEjercicio(
        nombre: 'Bicicleta estatica',
        descripcion: 'Trabajo continuo en bicicleta indoor',
        tipo: 'cardio',
        grupos: ['cardio'],
        unidad: 'tiempo',
        color: cardioColor,
        icono: 'pedal_bike',
      ),
      crearEjercicio(
        nombre: 'Remo indoor',
        descripcion: 'Ergometro de remo para cuerpo completo',
        tipo: 'cardio',
        grupos: ['cardio', 'espalda'],
        unidad: 'tiempo',
        color: cardioColor,
        icono: 'kayaking',
      ),
      crearEjercicio(
        nombre: 'Eliptica por intervalos',
        descripcion: 'Intervalos moderados alta intensidad',
        tipo: 'cardio',
        grupos: ['cardio'],
        unidad: 'tiempo',
        color: cardioColor,
        icono: 'directions_walk',
      ),
      crearEjercicio(
        nombre: 'Escaladora',
        descripcion: 'Stepper o subidas de escaleras',
        tipo: 'cardio',
        grupos: ['cardio', 'piernas'],
        unidad: 'tiempo',
        color: cardioColor,
        icono: 'stairs',
      ),
      crearEjercicio(
        nombre: 'Battle rope',
        descripcion: 'Intervalos con cuerdas pesadas',
        tipo: 'cardio',
        grupos: ['cardio', 'brazos'],
        unidad: 'tiempo',
        series: 5,
        color: cardioColor,
        icono: 'waves',
      ),
      crearEjercicio(
        nombre: 'Burpees',
        descripcion: 'Ejercicio pliometrico de cuerpo completo',
        tipo: 'cardio',
        grupos: ['cardio', 'core'],
        unidad: 'repeticiones',
        series: 3,
        repeticiones: 15,
        color: cardioColor,
        icono: 'run_circle',
      ),
      crearEjercicio(
        nombre: 'Saltar cuerda',
        descripcion: 'Cuerda de velocidad',
        tipo: 'cardio',
        grupos: ['cardio'],
        unidad: 'tiempo',
        color: cardioColor,
        icono: 'sports',
      ),

      // Flexibilidad y movilidad
      crearEjercicio(
        nombre: 'Yoga vinyasa',
        descripcion: 'Secuencia dinamica fluida',
        tipo: 'flexibilidad',
        grupos: ['flexibilidad'],
        unidad: 'tiempo',
        color: flexColor,
        icono: 'self_improvement',
      ),
      crearEjercicio(
        nombre: 'Yin yoga',
        descripcion: 'Posturas mantenidas para movilidad',
        tipo: 'flexibilidad',
        grupos: ['flexibilidad'],
        unidad: 'tiempo',
        color: flexColor,
        icono: 'bedtime',
      ),
      crearEjercicio(
        nombre: 'Estiramientos globales',
        descripcion: 'Rutina basica de estiramientos',
        tipo: 'flexibilidad',
        grupos: ['flexibilidad'],
        unidad: 'tiempo',
        color: flexColor,
        icono: 'accessibility_new',
      ),
      crearEjercicio(
        nombre: 'Movilidad de cadera',
        descripcion: 'Secuencia para apertura de cadera',
        tipo: 'flexibilidad',
        grupos: ['piernas', 'flexibilidad'],
        unidad: 'tiempo',
        color: flexColor,
        icono: 'hail',
      ),
      crearEjercicio(
        nombre: 'Movilidad de hombros con banda',
        descripcion: 'Trabajo de movilidad toracica y hombro',
        tipo: 'flexibilidad',
        grupos: ['hombros'],
        unidad: 'repeticiones',
        series: 3,
        repeticiones: 15,
        color: flexColor,
        icono: 'sync',
      ),
      crearEjercicio(
        nombre: 'Pigeon stretch',
        descripcion: 'Estiramiento de gluteo y piriforme',
        tipo: 'flexibilidad',
        grupos: ['gluteos'],
        unidad: 'tiempo',
        color: flexColor,
        icono: 'gesture',
      ),
      crearEjercicio(
        nombre: 'Estiramiento de isquiotibiales',
        descripcion: 'Con banda o apoyo',
        tipo: 'flexibilidad',
        grupos: ['piernas'],
        unidad: 'tiempo',
        color: flexColor,
        icono: 'airline_stops',
      ),
      crearEjercicio(
        nombre: 'Rotaciones toracicas',
        descripcion: 'Movilidad de columna en cuadrupedia',
        tipo: 'flexibilidad',
        grupos: ['espalda'],
        unidad: 'repeticiones',
        series: 3,
        repeticiones: 12,
        color: flexColor,
        icono: 'swipe',
      ),

      // Funcional y otros
      crearEjercicio(
        nombre: 'Kettlebell swing',
        descripcion: 'Potencia de cadera con kettlebell',
        tipo: 'otro',
        grupos: ['piernas', 'espalda', 'cardio'],
        unidad: 'repeticiones',
        series: 5,
        repeticiones: 15,
        color: otroColor,
        icono: 'sports_kabaddi',
      ),
      crearEjercicio(
        nombre: 'Turkish get up',
        descripcion: 'Secuencia completa con kettlebell',
        tipo: 'otro',
        grupos: ['core', 'hombros'],
        unidad: 'repeticiones',
        series: 3,
        repeticiones: 5,
        color: otroColor,
        icono: 'hiking',
      ),
      crearEjercicio(
        nombre: 'Box jump',
        descripcion: 'Saltos pliometricos a caja',
        tipo: 'otro',
        grupos: ['piernas', 'cardio'],
        unidad: 'repeticiones',
        series: 4,
        repeticiones: 10,
        color: otroColor,
        icono: 'ad_units',
      ),
      crearEjercicio(
        nombre: 'Farmer walk',
        descripcion: 'Caminata con cargas pesadas',
        tipo: 'otro',
        grupos: ['core', 'brazos', 'piernas'],
        unidad: 'distancia',
        color: otroColor,
        icono: 'shopping_bag',
      ),
      crearEjercicio(
        nombre: 'Wall ball shots',
        descripcion: 'Lanzamientos de balon medicinal a pared',
        tipo: 'otro',
        grupos: ['piernas', 'cardio', 'hombros'],
        unidad: 'repeticiones',
        series: 4,
        repeticiones: 12,
        color: otroColor,
        icono: 'sports_handball',
      ),
      crearEjercicio(
        nombre: 'Foam rolling cuerpo completo',
        descripcion: 'Liberacion miofascial guiada',
        tipo: 'otro',
        grupos: ['recuperacion'],
        unidad: 'tiempo',
        color: otroColor,
        icono: 'roller_skating',
      ),
      crearEjercicio(
        nombre: 'Respiracion diafragmatica',
        descripcion: 'Sesion guiada de respiracion consciente',
        tipo: 'otro',
        grupos: ['recuperacion'],
        unidad: 'tiempo',
        color: otroColor,
        icono: 'air',
      ),
      crearEjercicio(
        nombre: 'Caminata suave',
        descripcion: 'Recuperacion activa al aire libre',
        tipo: 'otro',
        grupos: ['cardio'],
        unidad: 'tiempo',
        color: otroColor,
        icono: 'directions_walk',
      ),
      crearEjercicio(
        nombre: 'Bicicleta de recuperacion',
        descripcion: 'Pedaleo ligero para regenerar',
        tipo: 'otro',
        grupos: ['cardio'],
        unidad: 'tiempo',
        color: otroColor,
        icono: 'two_wheeler',
      ),
    ];

    await isar.writeTxn(() async {
      await isar.ejercicios.putAll(ejercicios);
    });

    debugPrint('✅ ${ejercicios.length} ejercicios creados exitosamente');
  }

  static Future<void> seedRegistros() async {
    final isar = IsarService().db;

    // Verificar si ya hay registros
    final count = await isar.registroEjercicios.count();
    if (count > 0) {
      debugPrint('Ya existen registros en la base de datos');
      return;
    }

    // Obtener algunos ejercicios para crear registros
    final ejercicios =
        await isar.ejercicios.filter().activoEqualTo(true).findAll();
    if (ejercicios.length < 5) {
      debugPrint(
          'No hay suficientes ejercicios para crear registros. Ejecuta seedEjercicios primero.');
      return;
    }

    final registros = <RegistroEjercicio>[];
    final now = DateTime.now();

    // Crear registros para los últimos 7 días
    for (int i = 0; i < 7; i++) {
      final fecha = now.subtract(Duration(days: i));
      // 2-4 registros por día
      final cantidadRegistros = 2 + (i % 3);

      for (int j = 0; j < cantidadRegistros && j < 5; j++) {
        final ejercicio = ejercicios[j];
        final registro = RegistroEjercicio()
          ..ejercicioId = ejercicio.id
          ..fecha = DateTime(fecha.year, fecha.month, fecha.day, 10 + i, j * 15)
          ..series = List.generate(3, (serieIndex) {
            return Serie()
              ..repeticiones = 10 + serieIndex
              ..peso = ejercicio.tipo == 'fuerza'
                  ? 20 + (serieIndex * 5).toDouble()
                  : null
              ..completada = true;
          });
        registros.add(registro);
      }
    }

    await isar.writeTxn(() async {
      await isar.registroEjercicios.putAll(registros);
    });

    debugPrint(
        '✅ ${registros.length} registros de ejercicios creados exitosamente');
  }

  static Future<void> seedRutinas() async {
    final isar = IsarService().db;

    // Verificar si ya hay rutinas
    final count = await isar.rutinas.count();
    if (count > 0) {
      debugPrint('Ya existen rutinas en la base de datos');
      return;
    }

    // Obtener ejercicios para las rutinas
    final ejercicios =
        await isar.ejercicios.filter().activoEqualTo(true).findAll();
    if (ejercicios.length < 3) {
      debugPrint(
          'No hay suficientes ejercicios para crear rutinas. Ejecuta seedEjercicios primero.');
      return;
    }

    final rutinas = [
      // Rutina de fuerza
      Rutina()
        ..nombre = 'Rutina de Fuerza'
        ..descripcion = 'Entrenamiento completo de fuerza'
        ..diasSemana = [1, 3, 5] // Lunes, Miércoles, Viernes
        ..duracionEstimada = 60
        ..ejercicios = [
          EjercicioRutina()
            ..ejercicioId = ejercicios
                .firstWhere((e) => e.nombre == 'Press de Banca',
                    orElse: () => ejercicios[0])
                .id
            ..orden = 0
            ..series = 4
            ..repeticiones = 10
            ..peso = 40.0,
          EjercicioRutina()
            ..ejercicioId = ejercicios
                .firstWhere((e) => e.nombre == 'Sentadillas',
                    orElse: () => ejercicios[1])
                .id
            ..orden = 1
            ..series = 4
            ..repeticiones = 12
            ..peso = 60.0,
          EjercicioRutina()
            ..ejercicioId = ejercicios
                .firstWhere((e) => e.nombre == 'Dominadas',
                    orElse: () => ejercicios[2])
                .id
            ..orden = 2
            ..series = 3
            ..repeticiones = 8,
        ],

      // Rutina de cardio
      Rutina()
        ..nombre = 'Rutina de Cardio'
        ..descripcion = 'Entrenamiento cardiovascular'
        ..diasSemana = [2, 4, 6] // Martes, Jueves, Sábado
        ..duracionEstimada = 30
        ..ejercicios = [
          EjercicioRutina()
            ..ejercicioId = ejercicios
                .firstWhere((e) => e.nombre == 'Correr',
                    orElse: () => ejercicios[0])
                .id
            ..orden = 0
            ..series = 1
            ..repeticiones = 20,
          EjercicioRutina()
            ..ejercicioId = ejercicios
                .firstWhere((e) => e.nombre == 'Burpees',
                    orElse: () => ejercicios[1])
                .id
            ..orden = 1
            ..series = 3
            ..repeticiones = 15,
        ],
    ];

    await isar.writeTxn(() async {
      await isar.rutinas.putAll(rutinas);
    });

    debugPrint('✅ ${rutinas.length} rutinas creadas exitosamente');
  }

  /// Llamar esto desde main.dart para poblar datos de prueba
  static Future<void> initialize() async {
    await seedEjercicios();
    await seedRegistros();
    await seedRutinas();
  }
}
