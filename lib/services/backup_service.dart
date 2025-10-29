import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../services/isar_service.dart';

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

class BackupService {
  String? _lastError;
  String? get lastError => _lastError;
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      drive.DriveApi.driveFileScope,
    ],
  );

  // Nombre de la carpeta en Google Drive
  static const String _backupFolderName = 'SaludFitnessBackups';
  static const String _backupFileName = 'salud_backup.isar';

  Future<void> _deleteTempFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('No se pudo eliminar archivo temporal de respaldo: $e');
    }
  }

  /// Autenticar con Google
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      // Intentar sesión silenciosa primero (evita saltos de UI si ya hay cuenta)
      GoogleSignInAccount? account = await _googleSignIn.signInSilently();
      if (account != null) return account;

      // Iniciar flujo interactivo
      account = await _googleSignIn.signIn();
      return account;
    } catch (e) {
      debugPrint('Error al autenticar con Google: $e');
      return null;
    }
  }

  /// Cerrar sesión de Google
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  /// Obtener cuenta actual
  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  /// Crear backup de la base de datos Isar
  Future<File?> createBackup() async {
    try {
      final isar = IsarService().isar;
      if (isar == null) throw Exception('Base de datos no inicializada');

      // Obtener directorio temporal
      final tempDir = await getTemporaryDirectory();
      final backupPath = '${tempDir.path}/$_backupFileName';
      final backupFile = File(backupPath);

      if (await backupFile.exists()) {
        await backupFile.delete();
      }

      // Generar snapshot consistente de la base de datos sin cerrarla
      await isar.copyToFile(backupPath);

      // Verificar que el archivo se creó correctamente
      if (!await backupFile.exists()) {
        throw Exception('Error al crear archivo de respaldo');
      }

      final fileSize = await backupFile.length();
      if (fileSize == 0) {
        throw Exception('Archivo de respaldo vacío');
      }

      debugPrint('Backup creado exitosamente: $backupPath ($fileSize bytes)');
      _lastError = null;
      return backupFile;
    } catch (e) {
      debugPrint('Error al crear backup: $e');
      _lastError = 'Error al crear backup: $e';
      return null;
    }
  }

  /// Subir backup a Google Drive
  Future<bool> uploadToGoogleDrive() async {
    File? backupFile;
    try {
      final account = _googleSignIn.currentUser;
      if (account == null) {
        _lastError =
            'Inicia sesión con tu cuenta de Google antes de crear un respaldo.';
        return false;
      }

      final authHeaders = await account.authHeaders;
      final client = GoogleAuthClient(authHeaders);
      final driveApi = drive.DriveApi(client);

      backupFile = await createBackup();
      if (backupFile == null) {
        _lastError ??= 'No se pudo preparar el archivo de respaldo.';
        return false;
      }

      final folderId = await _getOrCreateBackupFolder(driveApi);
      if (folderId == null) {
        _lastError ??=
            'No pudimos conectarnos con Google Drive. Verifica tu conexión a internet e inténtalo nuevamente.';
        await _deleteTempFile(backupFile);
        backupFile = null;
        return false;
      }

      final existingFiles = await driveApi.files.list(
        q: "name='$_backupFileName' and '$folderId' in parents and trashed=false",
        spaces: 'drive',
      );

      final fileBytes = await backupFile.readAsBytes();
      final media =
          drive.Media(Stream.value(fileBytes.toList()), fileBytes.length);

      if (existingFiles.files != null && existingFiles.files!.isNotEmpty) {
        final fileId = existingFiles.files!.first.id!;
        await driveApi.files.update(
          drive.File(
            name: _backupFileName,
            modifiedTime: DateTime.now().toUtc(),
          ),
          fileId,
          uploadMedia: media,
        );
        debugPrint('Backup actualizado en Google Drive: $fileId');
      } else {
        final driveFile = drive.File(
          name: _backupFileName,
          parents: [folderId],
          description: 'Respaldo automático de Salud Fitness',
          createdTime: DateTime.now().toUtc(),
        );

        final response = await driveApi.files.create(
          driveFile,
          uploadMedia: media,
        );
        debugPrint('Backup subido a Google Drive: ${response.id}');
      }

      await backupFile.delete();
      backupFile = null;

      _lastError = null;
      return true;
    } on SocketException catch (e) {
      debugPrint('Error de red al subir a Google Drive: $e');
      if (backupFile != null) {
        await _deleteTempFile(backupFile);
      }
      _lastError =
          'Parece que no hay conexión a internet. Revisa tu red e inténtalo de nuevo.';
      return false;
    } on drive.DetailedApiRequestError catch (e) {
      debugPrint('Drive rechazó la solicitud: ${e.message}');
      if (backupFile != null) {
        await _deleteTempFile(backupFile);
      }
      _lastError = e.message ??
          'Google Drive rechazó la solicitud de respaldo. Inténtalo más tarde.';
      return false;
    } catch (e) {
      debugPrint('Error al subir a Google Drive: $e');
      if (backupFile != null) {
        await _deleteTempFile(backupFile);
      }
      _lastError ??=
          'No pudimos completar el respaldo. Inténtalo nuevamente más tarde.';
      return false;
    }
  }

  /// Descargar backup desde Google Drive
  Future<File?> downloadFromGoogleDrive() async {
    try {
      final account = _googleSignIn.currentUser;
      if (account == null) {
        throw Exception('No hay sesión de Google activa');
      }

      final authHeaders = await account.authHeaders;
      final client = GoogleAuthClient(authHeaders);
      final driveApi = drive.DriveApi(client);

      // Buscar carpeta de backups
      final folderId = await _getBackupFolderId(driveApi);
      if (folderId == null) {
        throw Exception('No se encontró la carpeta de respaldos');
      }

      // Buscar archivo de backup
      final files = await driveApi.files.list(
        q: "name='$_backupFileName' and '$folderId' in parents and trashed=false",
        spaces: 'drive',
        orderBy: 'modifiedTime desc',
      );

      if (files.files == null || files.files!.isEmpty) {
        throw Exception('No se encontró ningún respaldo en Google Drive');
      }

      final fileId = files.files!.first.id!;

      // Descargar archivo
      final media = await driveApi.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;

      // Guardar en directorio temporal
      final tempDir = await getTemporaryDirectory();
      final downloadPath = '${tempDir.path}/restore_$_backupFileName';
      final downloadFile = File(downloadPath);

      final bytes = <int>[];
      await for (var chunk in media.stream) {
        bytes.addAll(chunk);
      }

      await downloadFile.writeAsBytes(bytes);

      // Verificar integridad
      if (!await downloadFile.exists()) {
        throw Exception('Error al descargar el archivo');
      }

      final fileSize = await downloadFile.length();
      if (fileSize == 0) {
        throw Exception('Archivo descargado está vacío');
      }

      debugPrint(
          'Backup descargado desde Google Drive: $downloadPath ($fileSize bytes)');
      _lastError = null;
      return downloadFile;
    } catch (e) {
      debugPrint('Error al descargar desde Google Drive: $e');
      _lastError = 'Error al descargar desde Google Drive: $e';
      return null;
    }
  }

  /// Restaurar base de datos desde backup
  Future<bool> restoreFromBackup(File backupFile) async {
    try {
      final isar = IsarService().isar;
      if (isar == null) throw Exception('Base de datos no inicializada');

      // Capturar el directorio ANTES de cerrar la instancia para evitar usar un Isar cerrado
      final dbPath = isar.directory;

      // Verificar que el archivo existe y no está vacío
      if (!await backupFile.exists()) {
        throw Exception('Archivo de respaldo no encontrado');
      }

      final fileSize = await backupFile.length();
      if (fileSize == 0) {
        throw Exception('Archivo de respaldo está vacío');
      }

      // Cerrar la base de datos actual
      await IsarService().close();
      // Dar un pequeño margen para liberar handles del archivo
      await Future.delayed(const Duration(milliseconds: 100));

      // Obtener archivos de base de datos
      final dbFile = File('$dbPath/default.isar');
      final dbLockFile = File('$dbPath/default.isar.lock');

      // Hacer backup del archivo actual por si acaso
      if (await dbFile.exists()) {
        final oldBackup = File('$dbPath/default.isar.old');
        await dbFile.copy(oldBackup.path);
      }

      // Eliminar archivos de base de datos actuales
      if (await dbFile.exists()) await dbFile.delete();
      if (await dbLockFile.exists()) await dbLockFile.delete();

      // Copiar el backup a la ubicación de la base de datos
      await backupFile.copy(dbFile.path);

      // Intentar abrir la base de datos restaurada
      try {
        await IsarService().initialize();

        // Verificar que la base de datos se abrió correctamente
        final restoredIsar = IsarService().isar;
        if (restoredIsar == null) {
          throw Exception('No se pudo abrir la base de datos restaurada');
        }

        debugPrint('Base de datos restaurada exitosamente');
        _lastError = null;

        // Eliminar backup temporal
        await backupFile.delete();

        // Eliminar backup antiguo si todo salió bien
        final oldBackup = File('$dbPath/default.isar.old');
        if (await oldBackup.exists()) {
          await oldBackup.delete();
        }

        return true;
      } catch (e) {
        // Si falla, intentar restaurar el backup antiguo
        debugPrint('Error al abrir base de datos restaurada, revirtiendo: $e');
        _lastError =
            'El respaldo no es compatible con esta versión de la app o está corrupto. Detalle: $e';
        final oldBackup = File('$dbPath/default.isar.old');
        if (await oldBackup.exists()) {
          if (await dbFile.exists()) await dbFile.delete();
          await oldBackup.copy(dbFile.path);
        }

        await IsarService().initialize();
        throw Exception('Base de datos restaurada no pudo abrirse');
      }
    } catch (e) {
      debugPrint('Error al restaurar backup: $e');
      _lastError ??= 'Error al restaurar backup: $e';
      // Asegurar que la base de datos esté abierta
      await IsarService().initialize();
      return false;
    }
  }

  /// Obtener o crear la carpeta de backups en Google Drive
  Future<String?> _getOrCreateBackupFolder(drive.DriveApi driveApi) async {
    try {
      // Buscar carpeta existente
      final folderId = await _getBackupFolderId(driveApi);
      if (folderId != null) return folderId;

      // Crear carpeta nueva
      final folder = drive.File(
        name: _backupFolderName,
        mimeType: 'application/vnd.google-apps.folder',
        description: 'Respaldos de Salud Fitness App',
      );

      final createdFolder = await driveApi.files.create(folder);
      return createdFolder.id;
    } catch (e) {
      debugPrint('Error al obtener/crear carpeta: $e');
      if (e is SocketException) {
        _lastError ??=
            'No pudimos conectarnos con Google Drive. Revisa tu conexión e inténtalo nuevamente.';
      }
      return null;
    }
  }

  /// Buscar ID de la carpeta de backups
  Future<String?> _getBackupFolderId(drive.DriveApi driveApi) async {
    try {
      final folders = await driveApi.files.list(
        q: "name='$_backupFolderName' and mimeType='application/vnd.google-apps.folder' and trashed=false",
        spaces: 'drive',
      );

      if (folders.files != null && folders.files!.isNotEmpty) {
        return folders.files!.first.id;
      }
      return null;
    } catch (e) {
      debugPrint('Error al buscar carpeta: $e');
      if (e is SocketException) {
        _lastError ??=
            'No pudimos conectarnos con Google Drive. Verifica tu señal e inténtalo otra vez.';
      }
      return null;
    }
  }

  /// Obtener información del último backup
  Future<Map<String, dynamic>?> getLastBackupInfo() async {
    try {
      final account = _googleSignIn.currentUser;
      if (account == null) return null;

      final authHeaders = await account.authHeaders;
      final client = GoogleAuthClient(authHeaders);
      final driveApi = drive.DriveApi(client);

      final folderId = await _getBackupFolderId(driveApi);
      if (folderId == null) return null;

      final files = await driveApi.files.list(
        q: "name='$_backupFileName' and '$folderId' in parents and trashed=false",
        spaces: 'drive',
        orderBy: 'modifiedTime desc',
      );

      if (files.files == null || files.files!.isEmpty) {
        return null;
      }

      final file = files.files!.first;
      return {
        'id': file.id,
        'name': file.name,
        'size': file.size,
        'modifiedTime': file.modifiedTime,
      };
    } catch (e) {
      debugPrint('Error al obtener info del backup: $e');
      return null;
    }
  }
}
