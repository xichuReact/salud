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

    final ejercicios = [
      // Fuerza - Pecho
      Ejercicio()
        ..nombre = 'Press de Banca'
        ..descripcion = 'Ejercicio básico de pecho con barra'
        ..tipo = 'fuerza'
        ..gruposMusculares = ['pecho', 'brazos']
        ..unidadMedida = 'repeticiones'
        ..seriesPorDefecto = 4
        ..repeticionesPorDefecto = 10
        ..color = '#EF4444'
        ..icono = 'fitness_center',

      Ejercicio()
        ..nombre = 'Flexiones'
        ..descripcion = 'Flexiones de brazos clásicas'
        ..tipo = 'fuerza'
        ..gruposMusculares = ['pecho', 'brazos', 'core']
        ..unidadMedida = 'repeticiones'
        ..seriesPorDefecto = 3
        ..repeticionesPorDefecto = 15
        ..color = '#EF4444',

      // Fuerza - Espalda
      Ejercicio()
        ..nombre = 'Dominadas'
        ..descripcion = 'Pull-ups en barra fija'
        ..tipo = 'fuerza'
        ..gruposMusculares = ['espalda', 'brazos']
        ..unidadMedida = 'repeticiones'
        ..seriesPorDefecto = 4
        ..repeticionesPorDefecto = 8
        ..color = '#EF4444',

      Ejercicio()
        ..nombre = 'Remo con Barra'
        ..descripcion = 'Remo horizontal con barra'
        ..tipo = 'fuerza'
        ..gruposMusculares = ['espalda']
        ..unidadMedida = 'repeticiones'
        ..seriesPorDefecto = 4
        ..repeticionesPorDefecto = 10
        ..color = '#EF4444',

      // Fuerza - Piernas
      Ejercicio()
        ..nombre = 'Sentadillas'
        ..descripcion = 'Sentadillas con peso corporal o barra'
        ..tipo = 'fuerza'
        ..gruposMusculares = ['piernas']
        ..unidadMedida = 'repeticiones'
        ..seriesPorDefecto = 4
        ..repeticionesPorDefecto = 12
        ..color = '#EF4444',

      Ejercicio()
        ..nombre = 'Peso Muerto'
        ..descripcion = 'Levantamiento de peso muerto'
        ..tipo = 'fuerza'
        ..gruposMusculares = ['piernas', 'espalda']
        ..unidadMedida = 'repeticiones'
        ..seriesPorDefecto = 4
        ..repeticionesPorDefecto = 8
        ..color = '#EF4444',

      // Cardio
      Ejercicio()
        ..nombre = 'Correr'
        ..descripcion = 'Carrera continua'
        ..tipo = 'cardio'
        ..gruposMusculares = ['cardio']
        ..unidadMedida = 'tiempo'
        ..color = '#3B82F6',

      Ejercicio()
        ..nombre = 'Burpees'
        ..descripcion = 'Ejercicio de cuerpo completo'
        ..tipo = 'cardio'
        ..gruposMusculares = ['cardio', 'core']
        ..unidadMedida = 'repeticiones'
        ..seriesPorDefecto = 3
        ..repeticionesPorDefecto = 15
        ..color = '#3B82F6',

      Ejercicio()
        ..nombre = 'Saltar Cuerda'
        ..descripcion = 'Cardio con cuerda de saltar'
        ..tipo = 'cardio'
        ..gruposMusculares = ['cardio']
        ..unidadMedida = 'tiempo'
        ..color = '#3B82F6',

      // Flexibilidad
      Ejercicio()
        ..nombre = 'Yoga'
        ..descripcion = 'Sesión de yoga'
        ..tipo = 'flexibilidad'
        ..gruposMusculares = []
        ..unidadMedida = 'tiempo'
        ..color = '#8B5CF6',

      Ejercicio()
        ..nombre = 'Estiramientos'
        ..descripcion = 'Rutina de estiramientos'
        ..tipo = 'flexibilidad'
        ..gruposMusculares = []
        ..unidadMedida = 'tiempo'
        ..color = '#8B5CF6',

      // Core
      Ejercicio()
        ..nombre = 'Plancha'
        ..descripcion = 'Plancha isométrica'
        ..tipo = 'fuerza'
        ..gruposMusculares = ['core']
        ..unidadMedida = 'tiempo'
        ..seriesPorDefecto = 3
        ..color = '#EF4444',

      Ejercicio()
        ..nombre = 'Abdominales'
        ..descripcion = 'Crunches abdominales'
        ..tipo = 'fuerza'
        ..gruposMusculares = ['core']
        ..unidadMedida = 'repeticiones'
        ..seriesPorDefecto = 3
        ..repeticionesPorDefecto = 20
        ..color = '#EF4444',
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
    final ejercicios = await isar.ejercicios
        .filter()
        .activoEqualTo(true)
        .findAll();
    if (ejercicios.length < 5) {
      debugPrint('No hay suficientes ejercicios para crear registros. Ejecuta seedEjercicios primero.');
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
              ..peso = ejercicio.tipo == 'fuerza' ? 20 + (serieIndex * 5).toDouble() : null
              ..completada = true;
          });
        registros.add(registro);
      }
    }

    await isar.writeTxn(() async {
      await isar.registroEjercicios.putAll(registros);
    });

    debugPrint('✅ ${registros.length} registros de ejercicios creados exitosamente');
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
    final ejercicios = await isar.ejercicios
        .filter()
        .activoEqualTo(true)
        .findAll();
    if (ejercicios.length < 3) {
      debugPrint('No hay suficientes ejercicios para crear rutinas. Ejecuta seedEjercicios primero.');
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
            ..ejercicioId = ejercicios.firstWhere((e) => e.nombre == 'Press de Banca', orElse: () => ejercicios[0]).id
            ..orden = 0
            ..series = 4
            ..repeticiones = 10
            ..peso = 40.0,
          EjercicioRutina()
            ..ejercicioId = ejercicios.firstWhere((e) => e.nombre == 'Sentadillas', orElse: () => ejercicios[1]).id
            ..orden = 1
            ..series = 4
            ..repeticiones = 12
            ..peso = 60.0,
          EjercicioRutina()
            ..ejercicioId = ejercicios.firstWhere((e) => e.nombre == 'Dominadas', orElse: () => ejercicios[2]).id
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
            ..ejercicioId = ejercicios.firstWhere((e) => e.nombre == 'Correr', orElse: () => ejercicios[0]).id
            ..orden = 0
            ..series = 1
            ..repeticiones = 20,
          EjercicioRutina()
            ..ejercicioId = ejercicios.firstWhere((e) => e.nombre == 'Burpees', orElse: () => ejercicios[1]).id
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
