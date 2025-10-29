import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/backup_service.dart';
import '../../config/theme.dart';
import '../../controllers/ejercicio_controller.dart';
import '../../controllers/rutina_controller.dart';
import '../../controllers/rutina_sesion_controller.dart';
import '../../controllers/registro_controller.dart';
import '../../controllers/caminata_controller.dart';
import '../../controllers/calendario_controller.dart';
import '../../controllers/pasos_controller.dart';
import '../../controllers/alimento_controller.dart';
import 'recordatorios_screen.dart';

final backupServiceProvider = Provider((ref) => BackupService());

class PerfilScreen extends ConsumerStatefulWidget {
  const PerfilScreen({super.key});

  @override
  ConsumerState<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends ConsumerState<PerfilScreen> {
  bool _isSignedIn = false;
  bool _isLoading = false;
  Map<String, dynamic>? _lastBackupInfo;

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  Future<void> _checkSignInStatus() async {
    final service = ref.read(backupServiceProvider);
    setState(() {
      _isSignedIn = service.currentUser != null;
    });
    if (_isSignedIn) {
      await _loadBackupInfo();
    }
  }

  Future<void> _loadBackupInfo() async {
    final service = ref.read(backupServiceProvider);
    final info = await service.getLastBackupInfo();
    if (mounted) {
      setState(() {
        _lastBackupInfo = info;
      });
    }
  }

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      final service = ref.read(backupServiceProvider);
      final account = await service.signInWithGoogle();
      if (mounted) {
        setState(() {
          _isSignedIn = account != null;
          _isLoading = false;
        });
        if (_isSignedIn) {
          await _loadBackupInfo();
          if (mounted) {
            _showSnackBar('Sesión iniciada correctamente', isError: false);
          }
        } else {
          _showSnackBar('No se pudo iniciar sesión');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar('Error al iniciar sesión: $e');
      }
    }
  }

  Future<void> _signOut() async {
    final confirm = await _showConfirmDialog(
      '¿Cerrar sesión?',
      'Se cerrará tu sesión de Google Drive',
    );
    if (confirm != true) return;

    setState(() => _isLoading = true);
    try {
      final service = ref.read(backupServiceProvider);
      await service.signOut();
      if (mounted) {
        setState(() {
          _isSignedIn = false;
          _isLoading = false;
          _lastBackupInfo = null;
        });
        _showSnackBar('Sesión cerrada', isError: false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar('Error al cerrar sesión: $e');
      }
    }
  }

  Future<void> _createBackup() async {
    if (!_isSignedIn) {
      _showSnackBar('Primero inicia sesión con Google');
      return;
    }

    final confirm = await _showConfirmDialog(
      '¿Crear respaldo?',
      'Se creará un respaldo de toda tu información en Google Drive',
    );
    if (confirm != true) return;

    setState(() => _isLoading = true);
    try {
      final service = ref.read(backupServiceProvider);
      final success = await service.uploadToGoogleDrive();
      if (mounted) {
        setState(() => _isLoading = false);
        if (success) {
          await _loadBackupInfo();
          _showSnackBar('Respaldo creado exitosamente', isError: false);
        } else {
          _showSnackBar('Error al crear respaldo');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar('Error: $e');
      }
    }
  }

  Future<void> _restoreBackup() async {
    if (!_isSignedIn) {
      _showSnackBar('Primero inicia sesión con Google');
      return;
    }

    final confirm = await _showConfirmDialog(
      '¿Restaurar respaldo?',
      'Se reemplazará toda la información actual con el último respaldo. Esta acción no se puede deshacer.',
      isDestructive: true,
    );
    if (confirm != true) return;

    setState(() => _isLoading = true);
    try {
      final service = ref.read(backupServiceProvider);

      // Descargar backup
      final backupFile = await service.downloadFromGoogleDrive();
      if (backupFile == null) {
        if (mounted) {
          setState(() => _isLoading = false);
          _showSnackBar('No se pudo descargar el respaldo');
        }
        return;
      }

      // Restaurar
      final success = await service.restoreFromBackup(backupFile);
      if (mounted) {
        if (success) {
          await _refreshDataAfterRestore();
        }
        setState(() => _isLoading = false);
        if (success) {
          _showSnackBar('Respaldo restaurado exitosamente', isError: false);
          // Reiniciar la app o navegar al inicio
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else {
          final reason = service.lastError;
          _showSnackBar(reason ?? 'Error al restaurar respaldo');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar('Error: $e');
      }
    }
  }

  Future<void> _refreshDataAfterRestore() async {
    ref.invalidate(ejerciciosProvider);
    ref.invalidate(rutinasProvider);
    ref.invalidate(rutinaSesionProvider);
    ref.invalidate(caminatasProvider);
    ref.invalidate(estadisticasCaminatasProvider);
    ref.invalidate(registrosHoyProvider);
    ref.invalidate(registrosSemanalesProvider);
    ref.invalidate(sensacionUltimos7Provider);
    ref.invalidate(sensacionHoyProvider);
    ref.invalidate(pasosRegistrosProvider);
    ref.invalidate(pasosEstadisticasProvider);
    ref.invalidate(pasosControllerProvider);
    ref.invalidate(calendarioControllerProvider);

    // Nutrición: invalidar datos para refrescar UI tras restaurar respaldo
    ref.invalidate(registrosAlimentosHoyProvider);
    ref.invalidate(caloriasHoyProvider);
    ref.invalidate(macrosHoyProvider);
    ref.invalidate(alimentosBaseProvider);
    // Invalidaciones parametrizadas comunes
    // Nota: los family providers requieren parámetros al invalidar en uso; se refrescarán en la próxima suscripción
  }

  Future<void> _clearLocalDatabase() async {
    final confirm = await _showConfirmDialog(
      '¿Eliminar datos locales?',
      'Se borrará toda la información almacenada en este dispositivo. Esta acción no se puede deshacer.',
      isDestructive: true,
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(isarServiceProvider).clearDatabase();
      await _refreshDataAfterRestore();

      if (!mounted) return;
      setState(() => _isLoading = false);
      _showSnackBar('Datos locales eliminados correctamente', isError: false);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showSnackBar('Error al eliminar datos: $e');
    }
  }

  void _showSnackBar(String message, {bool isError = true}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<bool?> _showConfirmDialog(
    String title,
    String message, {
    bool isDestructive = false,
  }) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: isDestructive,
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Perfil y Configuración'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CupertinoActivityIndicator(radius: 16))
          : ListView(
              children: [
                const SizedBox(height: 20),

                // Avatar y nombre de usuario
                _buildUserSection(),

                const SizedBox(height: 30),

                // Sección: Google Drive
                _buildSectionHeader('Respaldo en Google Drive'),
                _buildGroupedList([
                  if (!_isSignedIn)
                    _buildListTile(
                      icon: CupertinoIcons.square_arrow_right,
                      iconColor: AppTheme.primaryColor,
                      title: 'Iniciar sesión con Google',
                      onTap: _signIn,
                      trailing:
                          const Icon(CupertinoIcons.chevron_right, size: 20),
                    )
                  else ...[
                    _buildListTile(
                      icon: CupertinoIcons.cloud_upload,
                      iconColor: Colors.blue,
                      title: 'Crear respaldo',
                      subtitle: 'Guardar toda tu información',
                      onTap: _createBackup,
                    ),
                    _buildDivider(),
                    _buildListTile(
                      icon: CupertinoIcons.cloud_download,
                      iconColor: Colors.green,
                      title: 'Restaurar respaldo',
                      subtitle: 'Recuperar información guardada',
                      onTap: _restoreBackup,
                    ),
                    if (_lastBackupInfo != null) ...[
                      _buildDivider(),
                      _buildLastBackupInfo(),
                    ],
                    _buildDivider(),
                    _buildListTile(
                      icon: CupertinoIcons.square_arrow_left,
                      iconColor: Colors.red,
                      title: 'Cerrar sesión',
                      onTap: _signOut,
                    ),
                  ],
                ]),

                const SizedBox(height: 30),

                // Sección: Configuración
                _buildSectionHeader('Configuración'),
                _buildGroupedList([
                  _buildListTile(
                    icon: CupertinoIcons.bell,
                    iconColor: Colors.orange,
                    title: 'Recordatorios',
                    subtitle: 'Notificaciones de ejercicio',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecordatoriosScreen(),
                        ),
                      );
                    },
                    trailing: const Icon(CupertinoIcons.chevron_right,
                        size: 20, color: Colors.grey),
                  ),
                  _buildDivider(),
                  _buildListTile(
                    icon: CupertinoIcons.delete,
                    iconColor: Colors.red,
                    title: 'Borrar base local',
                    subtitle: 'Elimina todos los datos de este dispositivo',
                    onTap: _clearLocalDatabase,
                  ),
                ]),

                const SizedBox(height: 30),

                // Sección: Acerca de
                _buildSectionHeader('Acerca de'),
                _buildGroupedList([
                  _buildListTile(
                    icon: CupertinoIcons.info_circle,
                    iconColor: Colors.grey,
                    title: 'Versión',
                    trailing: Text(
                      '1.0.0',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ),
                  _buildDivider(),
                  _buildListTile(
                    icon: CupertinoIcons.heart_fill,
                    iconColor: Colors.red,
                    title: 'Salud Fitness',
                    subtitle: 'Tu compañero de ejercicio',
                  ),
                ]),

                const SizedBox(height: 40),
              ],
            ),
    );
  }

  Widget _buildUserSection() {
    final service = ref.read(backupServiceProvider);
    final user = service.currentUser;

    return Center(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: user?.photoUrl != null
                ? ClipOval(
                    child: Image.network(
                      user!.photoUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        CupertinoIcons.person_fill,
                        size: 50,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  )
                : const Icon(
                    CupertinoIcons.person_fill,
                    size: 50,
                    color: AppTheme.primaryColor,
                  ),
          ),
          const SizedBox(height: 12),
          Text(
            user?.displayName ?? 'Usuario',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (user?.email != null) ...[
            const SizedBox(height: 4),
            Text(
              user!.email,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  Widget _buildGroupedList(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 60),
      child: Divider(height: 1, color: Colors.grey.shade800),
    );
  }

  Widget _buildLastBackupInfo() {
    if (_lastBackupInfo == null) return const SizedBox.shrink();

    final modifiedTime = _lastBackupInfo!['modifiedTime'] as DateTime?;
    final size = _lastBackupInfo!['size'];

    String timeAgo = '';
    if (modifiedTime != null) {
      final now = DateTime.now();
      final difference = now.difference(modifiedTime);
      if (difference.inDays > 0) {
        timeAgo =
            'Hace ${difference.inDays} día${difference.inDays > 1 ? 's' : ''}';
      } else if (difference.inHours > 0) {
        timeAgo =
            'Hace ${difference.inHours} hora${difference.inHours > 1 ? 's' : ''}';
      } else if (difference.inMinutes > 0) {
        timeAgo =
            'Hace ${difference.inMinutes} minuto${difference.inMinutes > 1 ? 's' : ''}';
      } else {
        timeAgo = 'Hace unos momentos';
      }
    }

    String sizeStr = '';
    if (size != null) {
      final bytes = int.tryParse(size) ?? 0;
      if (bytes > 1024 * 1024) {
        sizeStr = '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
      } else if (bytes > 1024) {
        sizeStr = '${(bytes / 1024).toStringAsFixed(1)} KB';
      } else {
        sizeStr = '$bytes bytes';
      }
    }

    return _buildListTile(
      icon: CupertinoIcons.time,
      iconColor: Colors.grey,
      title: 'Último respaldo',
      subtitle: timeAgo + (sizeStr.isNotEmpty ? ' • $sizeStr' : ''),
    );
  }
}
