import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/rutina_controller.dart';
import '../../controllers/rutina_sesion_controller.dart';
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
    final sesiones = ref.watch(rutinaSesionProvider);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rutinas.length,
      itemBuilder: (context, index) {
        final rutina = rutinas[index];
        final activa = sesiones.containsKey(rutina.id);
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () => _mostrarHojaInicio(context, ref, rutina, activa),
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
                      PopupMenuButton<String>(
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
                          } else if (value == 'editar') {
                            _mostrarFormularioRutina(context, ref, rutina);
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
                      const Spacer(),
                      // Estado de la rutina
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: activa
                              ? Colors.green.withOpacity(0.1)
                              : AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              activa
                                  ? Icons.play_arrow
                                  : Icons.play_circle_outline,
                              size: 16,
                              color:
                                  activa ? Colors.green : AppTheme.primaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              activa ? 'Rutina iniciada' : 'Empezar rutina',
                              style: TextStyle(
                                fontSize: 12,
                                color: activa
                                    ? Colors.green
                                    : AppTheme.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildMetricPill({
    required IconData icon,
    required String label,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w600,
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

  void _mostrarHojaInicio(
      BuildContext context, WidgetRef ref, Rutina rutina, bool activa) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        final dias = ['D', 'L', 'M', 'X', 'J', 'V', 'S'];
        final sesionActual = ref.read(rutinaSesionProvider)[rutina.id];
        int? sensacionSeleccionada = sesionActual?.sensacion;
        return SafeArea(
          top: false,
          child: DraggableScrollableSheet(
            initialChildSize: 0.48,
            minChildSize: 0.38,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, scrollController) {
              return Container
                  // Capa base con esquinas redondeadas
                  (
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: StatefulBuilder(builder: (ctx, setModalState) {
                    Widget buildChip({
                      required int value,
                      required IconData icon,
                      required String label,
                      required Color color,
                    }) {
                      final isSelected = sensacionSeleccionada == value;
                      return ChoiceChip(
                        selected: isSelected,
                        onSelected: (sel) {
                          setModalState(() {
                            sensacionSeleccionada = sel ? value : null;
                          });
                        },
                        avatar: Icon(icon,
                            size: 18, color: isSelected ? Colors.white : color),
                        label: Text(label),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : color,
                          fontWeight: FontWeight.w600,
                        ),
                        side: BorderSide(color: color.withOpacity(0.6)),
                        backgroundColor: color.withOpacity(0.08),
                        selectedColor: color,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      );
                    }

                    String microText() {
                      switch (sensacionSeleccionada) {
                        case 5:
                          return 'Te sientes con fuerza. ¡Vamos con todo!';
                        case 3:
                          return 'Energía media, escoge ritmo constante.';
                        case 1:
                          return 'Baja energía, prioriza técnica y control.';
                        default:
                          return 'Elige cómo te sientes hoy para ajustar el esfuerzo.';
                      }
                    }

                    return SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Handle
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 40,
                              height: 4,
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),

                          // Header con gradiente
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [
                                  AppTheme.primaryColor,
                                  AppTheme.secondaryColor,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.25)),
                                  ),
                                  child: const Icon(
                                    Icons.assignment,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              rutina.nombre,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.white
                                                  .withOpacity(0.18),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Colors.white
                                                      .withOpacity(0.24)),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  activa
                                                      ? Icons.play_arrow
                                                      : Icons.play_circle,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  activa
                                                      ? 'Rutina iniciada'
                                                      : 'Lista para empezar',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (rutina.descripcion != null &&
                                          rutina.descripcion!.trim().isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6.0),
                                          child: Text(
                                            rutina.descripcion!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Métricas
                          Row(
                            children: [
                              _buildMetricPill(
                                icon: Icons.fitness_center,
                                label: '${rutina.ejercicios.length} ejercicios',
                                context: context,
                              ),
                              const SizedBox(width: 8),
                              if (rutina.duracionEstimada != null)
                                _buildMetricPill(
                                  icon: Icons.timer,
                                  label: '${rutina.duracionEstimada} min',
                                  context: context,
                                ),
                              const Spacer(),
                              if (rutina.diasSemana.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: colorScheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.event,
                                          size: 16, color: Colors.grey),
                                      const SizedBox(width: 6),
                                      Text(
                                        rutina.diasSemana
                                            .map((d) => dias[(d % 7)])
                                            .join(' · '),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Calificar antes de iniciar
                          Text(
                            '¿Cómo te sientes hoy?',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 10,
                            runSpacing: 8,
                            children: [
                              buildChip(
                                value: 5,
                                icon: Icons.bolt,
                                label: 'Con fuerza',
                                color: AppTheme.accentColor,
                              ),
                              buildChip(
                                value: 3,
                                icon: Icons.speed,
                                label: 'Poca fuerza',
                                color: AppTheme.warningColor,
                              ),
                              buildChip(
                                value: 1,
                                icon: Icons.energy_savings_leaf,
                                label: 'Sin fuerza',
                                color: AppTheme.errorColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            microText(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),

                          // Botón principal
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.play_arrow),
                              label: Text(activa
                                  ? 'Reanudar rutina'
                                  : 'Comenzar rutina'),
                              onPressed: () {
                                final sesionCtrl =
                                    ref.read(rutinaSesionProvider.notifier);
                                if (!activa) {
                                  sesionCtrl.iniciar(rutina);
                                  if (sensacionSeleccionada != null) {
                                    sesionCtrl.setSensacion(
                                      rutinaId: rutina.id,
                                      sensacion: sensacionSeleccionada,
                                    );
                                  }
                                }
                                Navigator.pop(context);
                                _iniciarRutina(context, ref, rutina);
                              },
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Botón secundario
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cerrar'),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _mostrarFormularioRutina(BuildContext context, WidgetRef ref,
      [Rutina? rutinaAEditar]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _RutinaForm(ref: ref, rutina: rutinaAEditar),
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
              ref
                  .read(rutinaControllerProvider.notifier)
                  .eliminarRutina(rutina.id);
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
  final Rutina? rutina;

  const _RutinaForm({required this.ref, this.rutina});

  @override
  State<_RutinaForm> createState() => _RutinaFormState();
}

class _RutinaFormState extends State<_RutinaForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();
  final _duracionCtrl = TextEditingController();
  final _buscarCtrl = TextEditingController();
  final _formScrollCtrl = ScrollController();
  final _buscarFocus = FocusNode();
  final _buscarKey = GlobalKey();
  String _query = '';
  bool _dirty = false;

  // Dias: 0=Dom,1=Lun..6=Sab
  final List<bool> _dias = List.generate(7, (_) => false);

  // Map ejercicioId -> EjercicioRutina
  final Map<int, EjercicioRutina> _seleccionados = {};

  @override
  void initState() {
    super.initState();
    // Marcar cambios en campos texto
    void mark() {
      if (!_dirty) setState(() => _dirty = true);
    }
    _nombreCtrl.addListener(mark);
    _descripcionCtrl.addListener(mark);
    _duracionCtrl.addListener(mark);
    _buscarFocus.addListener(() {
      if (_buscarFocus.hasFocus) {
        // Asegura que el buscador quede visible en la parte superior
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final ctx = _buscarKey.currentContext;
          if (ctx != null) {
            Scrollable.ensureVisible(
              ctx,
              alignment: 0.0, // top
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });

    // Prefill en modo edición
    final r = widget.rutina;
    if (r != null) {
      _nombreCtrl.text = r.nombre;
      _descripcionCtrl.text = r.descripcion ?? '';
      _duracionCtrl.text = r.duracionEstimada?.toString() ?? '';
      for (final d in r.diasSemana) {
        if (d >= 0 && d < _dias.length) _dias[d] = true;
      }
      // Cargar ejercicios seleccionados con sus configuraciones
      for (final er in r.ejercicios) {
        _seleccionados[er.ejercicioId] = er;
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _descripcionCtrl.dispose();
    _duracionCtrl.dispose();
    _buscarCtrl.dispose();
    _buscarFocus.dispose();
    _formScrollCtrl.dispose();
    super.dispose();
  }

  Future<bool> _confirmDiscard() async {
    final res = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Descartar cambios'),
        content: const Text(
            'Tienes cambios sin guardar. ¿Quieres salir sin guardar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Salir'),
          ),
        ],
      ),
    );
    return res == true;
  }

  Future<void> _attemptClose() async {
    if (!_dirty) {
      if (mounted) Navigator.pop(context);
      return;
    }
    final ok = await _confirmDiscard();
    if (ok && mounted) Navigator.pop(context);
  }

  // Resalta el fragmento que coincide con la búsqueda en un texto
  Widget _highlightText(String text, {bool isTitle = false}) {
    final q = _query.toLowerCase();
    if (q.isEmpty) {
      return Text(
        text,
        style: isTitle ? Theme.of(context).textTheme.bodyLarge : null,
      );
    }

    final lower = text.toLowerCase();
    final idx = lower.indexOf(q);
    if (idx == -1) {
      return Text(
        text,
        style: isTitle ? Theme.of(context).textTheme.bodyLarge : null,
      );
    }

    final baseStyle = (isTitle
            ? Theme.of(context).textTheme.bodyLarge
            : Theme.of(context).textTheme.bodyMedium) ??
        const TextStyle();

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: text.substring(0, idx)),
          TextSpan(
            text: text.substring(idx, idx + q.length),
            style: const TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(text: text.substring(idx + q.length)),
        ],
      ),
    );
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
      _dirty = true;
    });
  }

  Future<void> _abrirCreadorEjercicio() async {
    final nuevoEjercicio = await showModalBottomSheet<Ejercicio>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => const _CrearEjercicioSheet(),
    );

    if (nuevoEjercicio != null && mounted) {
      setState(() {
        final er = EjercicioRutina()
          ..ejercicioId = nuevoEjercicio.id
          ..orden = _seleccionados.length
          ..series = 3
          ..repeticiones = 10;
        _seleccionados[nuevoEjercicio.id] = er;
        _dirty = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Ejercicio "${nuevoEjercicio.nombre}" agregado')),
      );
    }
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
    ..descripcion = _descripcionCtrl.text.trim().isEmpty
      ? null
      : _descripcionCtrl.text.trim()
    ..diasSemana =
      _dias.asMap().entries.where((e) => e.value).map((e) => e.key).toList()
    ..duracionEstimada = _duracionCtrl.text.trim().isEmpty
      ? null
      : int.tryParse(_duracionCtrl.text.trim())
    ..ejercicios = _seleccionados.values.toList();

  if (widget.rutina != null) {
    // Mantener metadatos
    rutina.id = widget.rutina!.id;
    rutina.fechaCreacion = widget.rutina!.fechaCreacion;
    rutina.activa = widget.rutina!.activa;
    rutina.color = widget.rutina!.color;
    rutina.firebaseId = widget.rutina!.firebaseId;
  }

    // Guardar mediante el controller
    try {
      final controller = widget.ref.read(rutinaControllerProvider.notifier);
      if (widget.rutina == null) {
        await controller.crearRutina(rutina);
      } else {
        await controller.actualizarRutina(rutina);
      }
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.rutina == null
              ? 'Rutina creada correctamente'
              : 'Rutina actualizada correctamente'),
        ),
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
              final double listMaxHeight =
                  rawListHeight.clamp(160.0, 320.0).toDouble();

              return PopScope(
                canPop: false,
                onPopInvoked: (didPop) async {
                  if (didPop) return;
                  if (!_dirty) {
                    if (mounted) Navigator.pop(context);
                    return;
                  }
                  final ok = await _confirmDiscard();
                  if (ok && mounted) Navigator.pop(context);
                },
                child: Column(
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
                      controller: _formScrollCtrl,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const ClampingScrollPhysics(),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _nombreCtrl,
                              decoration: const InputDecoration(
                                  labelText: 'Nombre de la rutina'),
                              validator: (v) => (v == null || v.trim().isEmpty)
                                  ? 'Ingresa un nombre'
                                  : null,
                            ),
                            TextFormField(
                              controller: _descripcionCtrl,
                              decoration: const InputDecoration(
                                  labelText: 'Descripción (opcional)'),
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
                                      const dias = [
                                        'D',
                                        'L',
                                        'M',
                                        'X',
                                        'J',
                                        'V',
                                        'S'
                                      ];
                                      return FilterChip(
                                        label: Text(dias[i]),
                                        selected: _dias[i],
                                        onSelected: (sel) => setState(() {
                                          _dias[i] = sel;
                                          _dirty = true;
                                        }),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _duracionCtrl,
                              decoration: const InputDecoration(
                                  labelText: 'Duración estimada (min)'),
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Selecciona ejercicios',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: _abrirCreadorEjercicio,
                                  icon: const Icon(Icons.add),
                                  label: const Text('Crear ejercicio'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Buscador de ejercicios
                            TextField(
                              key: _buscarKey,
                              controller: _buscarCtrl,
                              focusNode: _buscarFocus,
                              onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
                              // Aumenta la separación del teclado cuando se enfoca
                              scrollPadding: EdgeInsets.only(
                                bottom: mediaQuery.viewInsets.bottom + 96,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Buscar por nombre o tipo...',
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: _query.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          _buscarCtrl.clear();
                                          setState(() => _query = '');
                                        },
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: listMaxHeight,
                              child: ejerciciosAsync.when(
                                data: (ejercicios) {
                                  if (ejercicios.isEmpty) {
                                    return const Center(
                                      child:
                                          Text('No hay ejercicios disponibles'),
                                    );
                                  }
                                  final q = _query;
                                  final listaFiltrada = q.isEmpty
                                      ? ejercicios
                                      : ejercicios.where((e) {
                                          final n = e.nombre.toLowerCase();
                                          final t = e.tipo.toLowerCase();
                                          return n.contains(q) || t.contains(q);
                                        }).toList();

                                  if (listaFiltrada.isEmpty) {
                                    return Center(
                                      child: Text(
                                        'Sin coincidencias',
                                        style: TextStyle(color: Colors.grey.shade600),
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: listaFiltrada.length,
                                    primary: false,
                                    physics: const ClampingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final ej = listaFiltrada[index];
                                      final selected =
                                          _seleccionados.containsKey(ej.id);

                                      Widget buildSeriesField() =>
                                          TextFormField(
                                            key: ValueKey('series_${ej.id}'),
                                            initialValue: _seleccionados[ej.id]
                                                    ?.series
                                                    .toString() ??
                                                '3',
                                            decoration: const InputDecoration(
                                                labelText: 'Series'),
                                            keyboardType: TextInputType.number,
                                            onChanged: (val) => setState(() {
                        _seleccionados[ej.id]!.series =
                          int.tryParse(val) ?? 3;
                        _dirty = true;
                                            }),
                                          );

                                      Widget buildRepsField() => TextFormField(
                                            key: ValueKey('reps_${ej.id}'),
                                            initialValue: _seleccionados[ej.id]
                                                    ?.repeticiones
                                                    .toString() ??
                                                '10',
                                            decoration: const InputDecoration(
                                                labelText: 'Reps'),
                                            keyboardType: TextInputType.number,
                                            onChanged: (val) => setState(() {
                        _seleccionados[ej.id]!
                            .repeticiones =
                          int.tryParse(val) ?? 10;
                        _dirty = true;
                                            }),
                                          );

                                      Widget buildPesoField() => TextFormField(
                                            key: ValueKey('peso_${ej.id}'),
                                            initialValue: _seleccionados[ej.id]
                                                    ?.peso
                                                    ?.toString() ??
                                                '',
                                            decoration: const InputDecoration(
                                                labelText: 'Peso kg'),
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal: true),
                                            onChanged: (val) => setState(() {
                        _seleccionados[ej.id]!.peso =
                          val.trim().isEmpty
                            ? null
                            : double.tryParse(val);
                        _dirty = true;
                                            }),
                                          );

                    final nameMatch = ej.nombre
                      .toLowerCase()
                      .contains(_query.toLowerCase());
                    final typeMatch = ej.tipo
                      .toLowerCase()
                      .contains(_query.toLowerCase());
                    final anyMatch = _query.isNotEmpty &&
                      (nameMatch || typeMatch);

                    return Column(
                                        children: [
                                          CheckboxListTile(
                                            value: selected,
                                            dense: true,
                      tileColor: anyMatch
                        ? AppTheme.primaryColor
                          .withOpacity(0.06)
                        : null,
                      title: _highlightText(ej.nombre,
                        isTitle: true),
                      subtitle: _highlightText(ej.tipo),
                                            onChanged: (v) {
                                              // Cierra el teclado al seleccionar
                                              FocusScope.of(context).unfocus();
                                              _toggleEjercicio(ej, v ?? false);
                                            },
                                          ),
                                          if (selected)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 6,
                                              ),
                                              child: LayoutBuilder(
                                                builder: (context,
                                                    fieldConstraints) {
                                                  final stackFields =
                                                      fieldConstraints
                                                              .maxWidth <
                                                          360;

                                                  if (stackFields) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        buildSeriesField(),
                                                        const SizedBox(
                                                            height: 8),
                                                        buildRepsField(),
                                                        const SizedBox(
                                                            height: 8),
                                                        buildPesoField(),
                                                      ],
                                                    );
                                                  }

                                                  return Row(
                                                    children: [
                                                      Expanded(
                                                          child:
                                                              buildSeriesField()),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                          child:
                                                              buildRepsField()),
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
                                          if (index < listaFiltrada.length - 1)
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
                                final stackButtons =
                                    buttonConstraints.maxWidth < 360;
                                if (stackButtons) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
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
                                        onPressed: _attemptClose,
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
              ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CrearEjercicioSheet extends ConsumerStatefulWidget {
  const _CrearEjercicioSheet();

  @override
  ConsumerState<_CrearEjercicioSheet> createState() =>
      _CrearEjercicioSheetState();
}

class _CrearEjercicioSheetState extends ConsumerState<_CrearEjercicioSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();
  String _tipoSeleccionado = 'fuerza';
  String _unidadSeleccionada = 'repeticiones';
  final Set<String> _gruposSeleccionados = <String>{};
  bool _guardando = false;

  static const List<String> _tipos = [
    'fuerza',
    'cardio',
    'flexibilidad',
    'otro',
  ];

  static const List<String> _unidades = [
    'repeticiones',
    'tiempo',
    'distancia',
    'peso',
  ];

  static const List<String> _gruposMusculares = [
    'pecho',
    'espalda',
    'piernas',
    'brazos',
    'hombros',
    'core',
    'cardio',
  ];

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _descripcionCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _guardando = true;
    });

    final descripcion = _descripcionCtrl.text.trim();
    final ejercicio = Ejercicio()
      ..nombre = _nombreCtrl.text.trim()
      ..descripcion = descripcion.isEmpty ? null : descripcion
      ..tipo = _tipoSeleccionado
      ..unidadMedida = _unidadSeleccionada
      ..gruposMusculares = List<String>.from(_gruposSeleccionados);

    final messenger = ScaffoldMessenger.of(context);

    try {
      await ref
          .read(ejercicioControllerProvider.notifier)
          .crearEjercicio(ejercicio);

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop(ejercicio);
      messenger.showSnackBar(
        SnackBar(content: Text('Ejercicio "${ejercicio.nombre}" creado')),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Error al crear ejercicio: $e')),
      );
      if (mounted) {
        setState(() {
          _guardando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 16),
                  Text(
                    'Crear ejercicio',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nombreCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Nombre del ejercicio',
                      prefixIcon: Icon(Icons.fitness_center),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty)
                            ? 'Ingresa un nombre'
                            : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descripcionCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Descripción (opcional)',
                      prefixIcon: Icon(Icons.description_outlined),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _tipoSeleccionado,
                    decoration: const InputDecoration(
                      labelText: 'Tipo',
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    items: _tipos
                        .map(
                          (tipo) => DropdownMenuItem(
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
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _tipoSeleccionado = value);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _unidadSeleccionada,
                    decoration: const InputDecoration(
                      labelText: 'Unidad de medida',
                      prefixIcon: Icon(Icons.straighten),
                    ),
                    items: _unidades
                        .map(
                          (unidad) => DropdownMenuItem(
                            value: unidad,
                            child: Text(unidad),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _unidadSeleccionada = value);
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
                      onPressed: _guardando ? null : _guardar,
                      child: _guardando
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Guardar ejercicio'),
                    ),
                  ),
                ],
              ),
            ),
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

class _PantallaEjecucionRutinaState
    extends ConsumerState<_PantallaEjecucionRutina> {
  // Migrado a estado global de sesión (rutinaSesionProvider)

  @override
  Widget build(BuildContext context) {
    final sesionMap = ref.watch(rutinaSesionProvider);
    final sesion = sesionMap[widget.rutina.id];

    if (sesion == null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.rutina.nombre)),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('La rutina no está iniciada'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(rutinaSesionProvider.notifier)
                      .iniciar(widget.rutina);
                  setState(() {});
                },
                child: const Text('Iniciar ahora'),
              ),
            ],
          ),
        ),
      );
    }

    final ejercicioRutina = widget.rutina.ejercicios[sesion.ejercicioActual];
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
                value: (sesion.ejercicioActual + 1) /
                    widget.rutina.ejercicios.length,
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
                        'Ejercicio ${sesion.ejercicioActual + 1} de ${widget.rutina.ejercicios.length}',
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
                      ...sesion.seriesCompletadas[sesion.ejercicioActual]
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key;
                        final completada = entry.value;
                        void toggleSerie() {
                          ref.read(rutinaSesionProvider.notifier).toggleSerie(
                                rutinaId: widget.rutina.id,
                                ejercicioIndex: sesion.ejercicioActual,
                                serieIndex: index,
                                value: !completada,
                              );
                        }

                        final textColor =
                            completada ? Colors.white : Colors.grey.shade800;

                        return Card(
                          elevation: completada ? 4 : 1,
                          shadowColor: completada
                              ? AppTheme.primaryColor.withOpacity(0.35)
                              : Colors.black.withOpacity(0.08),
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: toggleSerie,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: completada
                                    ? const LinearGradient(
                                        colors: [
                                          AppTheme.primaryColor,
                                          AppTheme.accentColor,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : null,
                                color: completada
                                    ? null
                                    : Theme.of(context).colorScheme.surface,
                                border: Border.all(
                                  color: completada
                                      ? Colors.transparent
                                      : Theme.of(context)
                                          .colorScheme
                                          .outline
                                          .withOpacity(0.12),
                                  width: 1.4,
                                ),
                              ),
                              child: Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 220),
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: completada
                                          ? Colors.white.withOpacity(0.18)
                                          : AppTheme.primaryColor
                                              .withOpacity(0.12),
                                    ),
                                    child: Icon(
                                      completada
                                          ? Icons.check_rounded
                                          : Icons.fitness_center,
                                      color: completada
                                          ? Colors.white
                                          : AppTheme.primaryColor,
                                      size: 26,
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Serie ${index + 1}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: textColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${ejercicioRutina.repeticiones} reps'
                                          '${ejercicioRutina.peso != null ? ' × ${ejercicioRutina.peso} kg' : ''}',
                                          style: TextStyle(
                                            color: completada
                                                ? Colors.white70
                                                : Colors.grey.shade600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  SizedBox(
                                    height: 36,
                                    child: OutlinedButton.icon(
                                      onPressed: toggleSerie,
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: completada
                                            ? Colors.white
                                            : AppTheme.primaryColor,
                                        side: BorderSide(
                                          color: completada
                                              ? Colors.white.withOpacity(0.6)
                                              : AppTheme.primaryColor
                                                  .withOpacity(0.6),
                                        ),
                                        backgroundColor: completada
                                            ? Colors.white.withOpacity(0.12)
                                            : AppTheme.primaryColor
                                                .withOpacity(0.08),
                                      ),
                                      icon: Icon(
                                        completada
                                            ? Icons.restart_alt
                                            : Icons.check_circle_outline,
                                        size: 18,
                                      ),
                                      label: Text(
                                        completada ? 'Desmarcar' : 'Completar',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 12),
                      _buildCalificacionSection(context, sesion),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (sesion.ejercicioActual > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            ref
                                .read(rutinaSesionProvider.notifier)
                                .setEjercicioActual(
                                    rutinaId: widget.rutina.id,
                                    index: sesion.ejercicioActual - 1);
                          },
                          child: const Text('Anterior'),
                        ),
                      ),
                    if (sesion.ejercicioActual > 0) const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _confirmarTerminar,
                        child: const Text('Terminar rutina'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (sesion.ejercicioActual <
                              widget.rutina.ejercicios.length - 1) {
                            ref
                                .read(rutinaSesionProvider.notifier)
                                .setEjercicioActual(
                                    rutinaId: widget.rutina.id,
                                    index: sesion.ejercicioActual + 1);
                          } else {
                            _finalizarRutina();
                          }
                        },
                        child: Text(
                          sesion.ejercicioActual <
                                  widget.rutina.ejercicios.length - 1
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
    final sesion = ref.read(rutinaSesionProvider)[widget.rutina.id];
    if (sesion != null) {
      final int finalSensacion =
          sesion.sensacion ?? 3; // valor por defecto si no se calificó
      // Guardar registros de ejercicios
      for (int i = 0; i < widget.rutina.ejercicios.length; i++) {
        final ejercicioRutina = widget.rutina.ejercicios[i];
        final registro = RegistroEjercicio()
          ..ejercicioId = ejercicioRutina.ejercicioId
          ..fecha = DateTime.now()
          ..series = sesion.seriesCompletadas[i]
              .map((c) => Serie()..completada = c)
              .toList()
          ..sensacion = finalSensacion;

        ref.read(registroControllerProvider.notifier).guardarRegistro(registro);
      }

      // Refrescar estadísticas dependientes
      ref.invalidate(sensacionUltimos7Provider);
      ref.invalidate(sensacionHoyProvider);

      // Limpiar sesión
      ref.read(rutinaSesionProvider.notifier).terminar(widget.rutina.id);
    }

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Rutina completada!')),
      );
    }
  }

  Widget _buildCalificacionSection(BuildContext context, RutinaSesion sesion) {
    final selected = sesion.sensacion;

    Widget buildChip({
      required int value,
      required IconData icon,
      required String label,
      required Color color,
    }) {
      final isSelected = selected == value;
      return ChoiceChip(
        selected: isSelected,
        onSelected: (sel) {
          ref.read(rutinaSesionProvider.notifier).setSensacion(
              rutinaId: widget.rutina.id, sensacion: sel ? value : null);
        },
        avatar: Icon(icon, size: 18, color: isSelected ? Colors.white : color),
        label: Text(label),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : color,
          fontWeight: FontWeight.w600,
        ),
        side: BorderSide(color: color.withOpacity(0.6)),
        backgroundColor: color.withOpacity(0.08),
        selectedColor: color,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      );
    }

    String helperText() {
      switch (selected) {
        case 5:
          return 'Te sentiste con fuerza. Mantén la intensidad y el control.';
        case 3:
          return 'Energía media. Prioriza la técnica con ritmo constante.';
        case 1:
          return 'Baja energía. Enfócate en moverte seguro y sin forzar.';
        default:
          return 'Elige cómo te sentiste para guardar esta rutina con contexto.';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Calificar rutina',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            buildChip(
              value: 5,
              icon: Icons.bolt,
              label: 'Con fuerza',
              color: AppTheme.accentColor,
            ),
            buildChip(
              value: 3,
              icon: Icons.speed,
              label: 'Poca fuerza',
              color: AppTheme.warningColor,
            ),
            buildChip(
              value: 1,
              icon: Icons.energy_savings_leaf,
              label: 'Sin fuerza',
              color: AppTheme.errorColor,
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          helperText(),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  void _confirmarTerminar() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Terminar rutina'),
        content: const Text(
            '¿Deseas terminar la rutina y guardar el progreso actual?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _finalizarRutina();
            },
            child: const Text('Terminar'),
          ),
        ],
      ),
    );
  }
}
