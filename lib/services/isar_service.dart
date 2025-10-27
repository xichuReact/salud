import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/ejercicio.dart';
import '../models/registro_ejercicio.dart';
import '../models/rutina.dart';
import '../models/caminata.dart';
import '../models/plan_semanal.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  factory IsarService() => _instance;
  IsarService._internal();

  Isar? _isar;

  /// Inicializa la base de datos Isar
  Future<void> initialize() async {
    if (_isar != null && _isar!.isOpen) return;

    final dir = await getApplicationDocumentsDirectory();
    
    _isar = await Isar.open(
      [
        EjercicioSchema,
        RegistroEjercicioSchema,
        RutinaSchema,
        CaminataSchema,
        PlanSemanalSchema,
      ],
      directory: dir.path,
      inspector: kDebugMode, // Habilitar inspector en modo debug
    );
  }

  /// Obtiene la instancia de Isar (debe estar inicializada)
  Isar get db {
    if (_isar == null || !_isar!.isOpen) {
      throw Exception('Isar no está inicializada. Llama a initialize() primero.');
    }
    return _isar!;
  }

  /// Cierra la base de datos
  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }

  /// Limpia toda la base de datos (útil para desarrollo)
  Future<void> clearDatabase() async {
    await db.writeTxn(() async {
      await db.clear();
    });
  }

  // Preparado para migración a Firebase
  // TODO: Implementar FirebaseService como alternativa
  // TODO: Implementar sincronización automática
}
