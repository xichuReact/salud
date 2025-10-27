import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/ejercicio_controller.dart';
import '../../models/ejercicio.dart';
import '../../config/theme.dart';

class ConfiguracionScreen extends ConsumerWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ejercicios = ref.watch(ejerciciosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Ejercicios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever_outlined),
            tooltip: 'Borrar todos los datos',
            onPressed: () => _confirmarLimpiarDatos(context, ref),
          ),
        ],
      ),
      body: ejercicios.when(
        data: (ejerciciosList) => ejerciciosList.isEmpty
            ? _buildEmptyState(context)
            : _buildEjerciciosList(context, ref, ejerciciosList),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarFormularioEjercicio(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Ejercicio'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fitness_center, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 24),
          Text(
            'No tienes ejercicios configurados',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Crea tu primer ejercicio para comenzar',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildEjerciciosList(
    BuildContext context,
    WidgetRef ref,
    List<Ejercicio> ejercicios,
  ) {
    // Agrupar por tipo
    final Map<String, List<Ejercicio>> porTipo = {};
    for (var ejercicio in ejercicios) {
      porTipo.putIfAbsent(ejercicio.tipo, () => []).add(ejercicio);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: porTipo.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.getColorForTipo(entry.key),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    entry.key.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.getColorForTipo(entry.key),
                        ),
                  ),
                ],
              ),
            ),
            ...entry.value.map((ejercicio) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.getColorForTipo(ejercicio.tipo)
                          .withOpacity(0.1),
                      child: Icon(
                        Icons.fitness_center,
                        color: AppTheme.getColorForTipo(ejercicio.tipo),
                      ),
                    ),
                    title: Text(
                      ejercicio.nombre,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      ejercicio.descripcion ?? 'Sin descripción',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'editar',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 20),
                              SizedBox(width: 8),
                              Text('Editar'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'eliminar',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 20, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Eliminar',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'editar') {
                          _mostrarFormularioEjercicio(context, ref, ejercicio);
                        } else if (value == 'eliminar') {
                          _confirmarEliminar(context, ref, ejercicio);
                        }
                      },
                    ),
                  ),
                )),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  void _mostrarFormularioEjercicio(
    BuildContext context,
    WidgetRef ref, [
    Ejercicio? ejercicio,
  ]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _FormularioEjercicio(ejercicio: ejercicio),
    );
  }

  void _confirmarEliminar(
      BuildContext context, WidgetRef ref, Ejercicio ejercicio) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar ejercicio'),
        content: Text('¿Seguro que deseas eliminar "${ejercicio.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(ejercicioControllerProvider.notifier)
                  .eliminarEjercicio(ejercicio.id);
              Navigator.pop(context);
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

    void _confirmarLimpiarDatos(BuildContext parentContext, WidgetRef ref) {
      showDialog(
        context: parentContext,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Eliminar todos los datos'),
          content: const Text(
            'Esto borrará ejercicios, rutinas, registros y caminatas guardadas. ¿Deseas continuar?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(parentContext);
                Navigator.pop(dialogContext);
                try {
                  await ref.read(isarServiceProvider).clearDatabase();
                  messenger.showSnackBar(
                    const SnackBar(content: Text('Datos eliminados correctamente')),
                  );
                } catch (e) {
                  messenger.showSnackBar(
                    SnackBar(content: Text('Error al eliminar: $e')),
                  );
                }
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    }
}

class _FormularioEjercicio extends ConsumerStatefulWidget {
  final Ejercicio? ejercicio;

  const _FormularioEjercicio({this.ejercicio});

  @override
  ConsumerState<_FormularioEjercicio> createState() =>
      _FormularioEjercicioState();
}

class _FormularioEjercicioState extends ConsumerState<_FormularioEjercicio> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  String _tipoSeleccionado = 'fuerza';
  final List<String> _gruposSeleccionados = [];

  final List<String> _tipos = ['fuerza', 'cardio', 'flexibilidad', 'otro'];
  final List<String> _gruposMusculares = [
    'pecho',
    'espalda',
    'piernas',
    'brazos',
    'hombros',
    'core',
    'cardio'
  ];

  @override
  void initState() {
    super.initState();
    _nombreController =
        TextEditingController(text: widget.ejercicio?.nombre ?? '');
    _descripcionController =
        TextEditingController(text: widget.ejercicio?.descripcion ?? '');
    if (widget.ejercicio != null) {
      _tipoSeleccionado = widget.ejercicio!.tipo;
      _gruposSeleccionados.addAll(widget.ejercicio!.gruposMusculares);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.ejercicio == null
                    ? 'Nuevo Ejercicio'
                    : 'Editar Ejercicio',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del ejercicio',
                  hintText: 'Ej: Press de banca',
                  prefixIcon: Icon(Icons.fitness_center),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción (opcional)',
                  hintText: 'Detalles del ejercicio',
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _tipoSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'Tipo de ejercicio',
                  prefixIcon: Icon(Icons.category),
                ),
                items: _tipos.map((tipo) {
                  return DropdownMenuItem(
                    value: tipo,
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppTheme.getColorForTipo(tipo),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(tipo),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _tipoSeleccionado = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Grupos musculares',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _gruposMusculares.map((grupo) {
                  final seleccionado = _gruposSeleccionados.contains(grupo);
                  return FilterChip(
                    label: Text(grupo),
                    selected: seleccionado,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _gruposSeleccionados.add(grupo);
                        } else {
                          _gruposSeleccionados.remove(grupo);
                        }
                      });
                    },
                    selectedColor: AppTheme.primaryColor.withOpacity(0.3),
                    checkmarkColor: AppTheme.primaryColor,
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _guardar,
                  child: Text(widget.ejercicio == null ? 'Crear' : 'Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _guardar() {
    if (_formKey.currentState?.validate() ?? false) {
      final ejercicio = widget.ejercicio ?? Ejercicio();
      ejercicio.nombre = _nombreController.text;
      ejercicio.descripcion = _descripcionController.text;
      ejercicio.tipo = _tipoSeleccionado;
      ejercicio.gruposMusculares = _gruposSeleccionados;
      ejercicio.unidadMedida = 'repeticiones';

      ref
          .read(ejercicioControllerProvider.notifier)
          .actualizarEjercicio(ejercicio);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }
}
