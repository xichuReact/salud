import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/rutina_controller.dart';
import '../../controllers/ejercicio_controller.dart';
import '../../controllers/registro_controller.dart';
import '../../models/rutina.dart';
import '../../models/ejercicio.dart';
import '../../models/registro_ejercicio.dart';
import '../../config/theme.dart';

class RutinasScreen extends ConsumerWidget {
  const RutinasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rutinas = ref.watch(rutinasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutinas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _mostrarFormularioRutina(context, ref),
          ),
        ],
      ),
      body: rutinas.when(
        data: (rutinasList) => rutinasList.isEmpty
            ? _buildEmptyState(context)
            : _buildRutinasList(context, ref, rutinasList),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 24),
          Text(
            'No tienes rutinas creadas',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Crea una rutina para organizar tus ejercicios',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildRutinasList(
    BuildContext context,
    WidgetRef ref,
    List<Rutina> rutinas,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rutinas.length,
      itemBuilder: (context, index) {
        final rutina = rutinas[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => _iniciarRutina(context, ref, rutina),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.assignment,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              rutina.nombre,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (rutina.descripcion != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                rutina.descripcion!,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                      PopupMenuButton(
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
                          if (value == 'eliminar') {
                            _confirmarEliminar(context, ref, rutina);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildInfoChip(
                        Icons.fitness_center,
                        '${rutina.ejercicios.length} ejercicios',
                      ),
                      const SizedBox(width: 8),
                      if (rutina.duracionEstimada != null)
                        _buildInfoChip(
                          Icons.timer,
                          '${rutina.duracionEstimada} min',
                        ),
                    ],
                  ),
                  if (rutina.diasSemana.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 4,
                      children: rutina.diasSemana.map((dia) {
                        const dias = ['D', 'L', 'M', 'X', 'J', 'V', 'S'];
                        return Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            dias[dia],
                            style: const TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _iniciarRutina(BuildContext context, WidgetRef ref, Rutina rutina) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _PantallaEjecucionRutina(rutina: rutina),
      ),
    );
  }

  void _mostrarFormularioRutina(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _RutinaForm(ref: ref),
    );
  }

  void _confirmarEliminar(BuildContext context, WidgetRef ref, Rutina rutina) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar rutina'),
        content: Text('¿Seguro que deseas eliminar "${rutina.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ref.read(rutinaControllerProvider.notifier).eliminarRutina(rutina.id);
              Navigator.pop(context);
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _RutinaForm extends StatefulWidget {
  final WidgetRef ref;

  const _RutinaForm({required this.ref});

  @override
  State<_RutinaForm> createState() => _RutinaFormState();
}

class _RutinaFormState extends State<_RutinaForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();
  final _duracionCtrl = TextEditingController();

  // Dias: 0=Dom,1=Lun..6=Sab
  final List<bool> _dias = List.generate(7, (_) => false);

  // Map ejercicioId -> EjercicioRutina
  final Map<int, EjercicioRutina> _seleccionados = {};

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _descripcionCtrl.dispose();
    _duracionCtrl.dispose();
    super.dispose();
  }

  void _toggleEjercicio(Ejercicio ejercicio, bool selected) {
    setState(() {
      if (selected) {
        final er = EjercicioRutina()
          ..ejercicioId = ejercicio.id
          ..orden = _seleccionados.length
          ..series = 3
          ..repeticiones = 10;
        _seleccionados[ejercicio.id] = er;
      } else {
        _seleccionados.remove(ejercicio.id);
      }
    });
  }

  void _save() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    if (_seleccionados.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona al menos un ejercicio')),
      );
      return;
    }

    final rutina = Rutina()
      ..nombre = _nombreCtrl.text.trim()
      ..descripcion = _descripcionCtrl.text.trim().isEmpty ? null : _descripcionCtrl.text.trim()
      ..diasSemana = _dias.asMap().entries.where((e) => e.value).map((e) => e.key).toList()
      ..duracionEstimada = _duracionCtrl.text.trim().isEmpty ? null : int.tryParse(_duracionCtrl.text.trim())
      ..ejercicios = _seleccionados.values.toList();

    // Guardar mediante el controller
    try {
      await widget.ref.read(rutinaControllerProvider.notifier).crearRutina(rutina);
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rutina creada correctamente')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ejerciciosAsync = widget.ref.watch(ejerciciosProvider);

    final mediaQuery = MediaQuery.of(context);

    return FractionallySizedBox(
      heightFactor: 0.95,
      child: SafeArea(
        top: false,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
            bottom: 16 + mediaQuery.viewInsets.bottom,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final rawListHeight = constraints.maxHeight.isFinite
                  ? constraints.maxHeight * 0.45
                  : mediaQuery.size.height * 0.45;
              final double listMaxHeight = rawListHeight.clamp(160.0, 320.0).toDouble();

              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _nombreCtrl,
                              decoration: const InputDecoration(labelText: 'Nombre de la rutina'),
                              validator: (v) =>
                                  (v == null || v.trim().isEmpty) ? 'Ingresa un nombre' : null,
                            ),
                            TextFormField(
                              controller: _descripcionCtrl,
                              decoration: const InputDecoration(labelText: 'Descripción (opcional)'),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text('Días'),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: List.generate(7, (i) {
                                      const dias = ['D', 'L', 'M', 'X', 'J', 'V', 'S'];
                                      return FilterChip(
                                        label: Text(dias[i]),
                                        selected: _dias[i],
                                        onSelected: (sel) => setState(() => _dias[i] = sel),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _duracionCtrl,
                              decoration:
                                  const InputDecoration(labelText: 'Duración estimada (min)'),
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Selecciona ejercicios',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: listMaxHeight,
                              child: ejerciciosAsync.when(
                                data: (ejercicios) {
                                  if (ejercicios.isEmpty) {
                                    return const Center(
                                      child: Text('No hay ejercicios disponibles'),
                                    );
                                  }

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: ejercicios.length,
                                    primary: false,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final ej = ejercicios[index];
                                      final selected = _seleccionados.containsKey(ej.id);

                                      Widget buildSeriesField() => TextFormField(
                                            key: ValueKey('series_${ej.id}'),
                                            initialValue: _seleccionados[ej.id]?.series.toString() ?? '3',
                                            decoration:
                                                const InputDecoration(labelText: 'Series'),
                                            keyboardType: TextInputType.number,
                                            onChanged: (val) => setState(() {
                                              _seleccionados[ej.id]!.series =
                                                  int.tryParse(val) ?? 3;
                                            }),
                                          );

                                      Widget buildRepsField() => TextFormField(
                                            key: ValueKey('reps_${ej.id}'),
                                            initialValue:
                                                _seleccionados[ej.id]?.repeticiones.toString() ?? '10',
                                            decoration: const InputDecoration(labelText: 'Reps'),
                                            keyboardType: TextInputType.number,
                                            onChanged: (val) => setState(() {
                                              _seleccionados[ej.id]!.repeticiones =
                                                  int.tryParse(val) ?? 10;
                                            }),
                                          );

                                      Widget buildPesoField() => TextFormField(
                                            key: ValueKey('peso_${ej.id}'),
                                            initialValue:
                                                _seleccionados[ej.id]?.peso?.toString() ?? '',
                                            decoration: const InputDecoration(labelText: 'Peso kg'),
                                            keyboardType:
                                                const TextInputType.numberWithOptions(decimal: true),
                                            onChanged: (val) => setState(() {
                                              _seleccionados[ej.id]!.peso = val.trim().isEmpty
                                                  ? null
                                                  : double.tryParse(val);
                                            }),
                                          );

                                      return Column(
                                        children: [
                                          CheckboxListTile(
                                            value: selected,
                                            dense: true,
                                            title: Text(ej.nombre),
                                            subtitle: Text(ej.tipo),
                                            onChanged: (v) => _toggleEjercicio(ej, v ?? false),
                                          ),
                                          if (selected)
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 6,
                                              ),
                                              child: LayoutBuilder(
                                                builder: (context, fieldConstraints) {
                                                  final stackFields = fieldConstraints.maxWidth < 360;

                                                  if (stackFields) {
                                                    return Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: [
                                                        buildSeriesField(),
                                                        const SizedBox(height: 8),
                                                        buildRepsField(),
                                                        const SizedBox(height: 8),
                                                        buildPesoField(),
                                                      ],
                                                    );
                                                  }

                                                  return Row(
                                                    children: [
                                                      Expanded(child: buildSeriesField()),
                                                      const SizedBox(width: 8),
                                                      Expanded(child: buildRepsField()),
                                                      const SizedBox(width: 8),
                                                      SizedBox(
                                                        width: 90,
                                                        child: buildPesoField(),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          if (index < ejercicios.length - 1)
                                            const Divider(height: 1),
                                        ],
                                      );
                                    },
                                  );
                                },
                                loading: () => const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                error: (e, _) => Center(
                                  child: Text('Error cargando ejercicios: $e'),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            LayoutBuilder(
                              builder: (context, buttonConstraints) {
                                final stackButtons = buttonConstraints.maxWidth < 360;
                                if (stackButtons) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancelar'),
                                      ),
                                      const SizedBox(height: 12),
                                      ElevatedButton(
                                        onPressed: _save,
                                        child: const Text('Guardar rutina'),
                                      ),
                                    ],
                                  );
                                }

                                return Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancelar'),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: _save,
                                        child: const Text('Guardar rutina'),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// Pantalla de ejecución de rutina
class _PantallaEjecucionRutina extends ConsumerStatefulWidget {
  final Rutina rutina;

  const _PantallaEjecucionRutina({required this.rutina});

  @override
  ConsumerState<_PantallaEjecucionRutina> createState() =>
      _PantallaEjecucionRutinaState();
}

class _PantallaEjecucionRutinaState extends ConsumerState<_PantallaEjecucionRutina> {
  int _ejercicioActual = 0;
  final List<List<Serie>> _seriesCompletadas = [];

  @override
  void initState() {
    super.initState();
    // Inicializar series para cada ejercicio
    for (var ejercicio in widget.rutina.ejercicios) {
      _seriesCompletadas.add(
        List.generate(ejercicio.series, (index) => Serie()..completada = false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ejercicioRutina = widget.rutina.ejercicios[_ejercicioActual];
    final ejercicios = ref.watch(ejerciciosProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rutina.nombre),
      ),
      body: ejercicios.when(
        data: (ejerciciosList) {
          Ejercicio? ejercicio;
          try {
            ejercicio = ejerciciosList.firstWhere(
              (e) => e.id == ejercicioRutina.ejercicioId,
            );
          } catch (e) {
            // Ejercicio no encontrado
          }
          
          if (ejercicio == null) {
            return const Center(child: Text('Ejercicio no encontrado'));
          }

          return Column(
            children: [
              // Progreso
              LinearProgressIndicator(
                value: (_ejercicioActual + 1) / widget.rutina.ejercicios.length,
                backgroundColor: Colors.grey.shade200,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ejercicio ${_ejercicioActual + 1} de ${widget.rutina.ejercicios.length}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ejercicio.nombre,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ..._seriesCompletadas[_ejercicioActual]
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key;
                        final serie = entry.value;
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: serie.completada,
                                  onChanged: (value) {
                                    setState(() {
                                      serie.completada = value ?? false;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Serie ${index + 1}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${ejercicioRutina.repeticiones} reps'
                                        '${ejercicioRutina.peso != null ? ' × ${ejercicioRutina.peso} kg' : ''}',
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (_ejercicioActual > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() => _ejercicioActual--);
                          },
                          child: const Text('Anterior'),
                        ),
                      ),
                    if (_ejercicioActual > 0) const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_ejercicioActual < widget.rutina.ejercicios.length - 1) {
                            setState(() => _ejercicioActual++);
                          } else {
                            _finalizarRutina();
                          }
                        },
                        child: Text(
                          _ejercicioActual < widget.rutina.ejercicios.length - 1
                              ? 'Siguiente'
                              : 'Finalizar',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  void _finalizarRutina() {
    // Guardar registros de ejercicios
    for (int i = 0; i < widget.rutina.ejercicios.length; i++) {
      final ejercicioRutina = widget.rutina.ejercicios[i];
      final registro = RegistroEjercicio()
        ..ejercicioId = ejercicioRutina.ejercicioId
        ..fecha = DateTime.now()
        ..series = _seriesCompletadas[i];

      ref.read(registroControllerProvider.notifier).guardarRegistro(registro);
    }

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡Rutina completada!')),
    );
  }
}
