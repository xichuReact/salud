import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/recordatorio_controller.dart';
import '../../models/recordatorio.dart';
import '../../config/theme.dart';
import '../widgets/recordatorio_dialog_android.dart';

class RecordatoriosScreen extends ConsumerStatefulWidget {
  const RecordatoriosScreen({super.key});

  @override
  ConsumerState<RecordatoriosScreen> createState() =>
      _RecordatoriosScreenState();
}

class _RecordatoriosScreenState extends ConsumerState<RecordatoriosScreen> {
  @override
  Widget build(BuildContext context) {
    final recordatorios = ref.watch(recordatorioControllerProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Recordatorios',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _mostrarDialog(context, null),
          ),
        ],
      ),
      body: recordatorios.when(
        data: (recordatorios) {
          if (recordatorios.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 80,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay recordatorios',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Toca + para crear uno',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: recordatorios.length,
            itemBuilder: (context, index) {
              final recordatorio = recordatorios[index];
              return _buildRecordatorioCard(recordatorio);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child:
              Text('Error: $error', style: const TextStyle(color: Colors.red)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarDialog(context, null),
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRecordatorioCard(Recordatorio recordatorio) {
    final diasNombres = ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];
    final diasSeleccionados =
        recordatorio.diasSemana.map((d) => diasNombres[d]).join(', ');

    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          recordatorio.titulo,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: recordatorio.activo ? Colors.white : Colors.grey,
            decoration: recordatorio.activo ? null : TextDecoration.lineThrough,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Text(
                  recordatorio.hora,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 16, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    diasSeleccionados,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  ),
                ),
              ],
            ),
            if (recordatorio.descripcion != null &&
                recordatorio.descripcion!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                recordatorio.descripcion!,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: recordatorio.activo,
              onChanged: (_) {
                ref
                    .read(recordatorioControllerProvider.notifier)
                    .toggleActivo(recordatorio);
              },
              activeColor: AppTheme.primaryColor,
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              color: Colors.grey[850],
              onSelected: (value) {
                if (value == 'edit') {
                  _showEditDialog(context, recordatorio);
                } else if (value == 'delete') {
                  _showDeleteDialog(recordatorio);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Editar', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Eliminar', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialog(BuildContext context, Recordatorio? recordatorio) {
    showDialog(
      context: context,
      builder: (context) =>
          RecordatorioDialogAndroid(recordatorio: recordatorio),
    );
  }

  void _showEditDialog(BuildContext context, Recordatorio recordatorio) {
    _mostrarDialog(context, recordatorio);
  }

  void _showDeleteDialog(Recordatorio recordatorio) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('¿Eliminar recordatorio?',
            style: TextStyle(color: Colors.white)),
        content: Text(
          'Se eliminará "${recordatorio.titulo}" y sus notificaciones programadas.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(recordatorioControllerProvider.notifier)
                  .eliminarRecordatorio(recordatorio.id);
              Navigator.pop(context);
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
