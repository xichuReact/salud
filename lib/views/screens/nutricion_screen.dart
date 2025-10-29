import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/alimento_controller.dart';
import '../../models/alimento.dart';
import '../../config/theme.dart';
import '../../utils/alimentos_comunes.dart';

class NutricionScreen extends ConsumerWidget {
  const NutricionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrosHoy = ref.watch(registrosAlimentosHoyProvider);
    final caloriasHoy = ref.watch(caloriasHoyProvider);
    final macrosHoy = ref.watch(macrosHoyProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Nutrición'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Historial',
            onPressed: () => _mostrarHistorial(context, ref),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(registrosAlimentosHoyProvider);
          ref.invalidate(caloriasHoyProvider);
          ref.invalidate(macrosHoyProvider);
        },
        child: registrosHoy.when(
          data: (registros) => _buildContent(
            context,
            ref,
            registros,
            caloriasHoy,
            macrosHoy,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
      floatingActionButton: isSmallScreen
          ? FloatingActionButton(
              onPressed: () => _mostrarAgregarAlimento(context, ref),
              child: const Icon(Icons.add),
            )
          : FloatingActionButton.extended(
              onPressed: () => _mostrarAgregarAlimento(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('Agregar alimento'),
            ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<RegistroAlimento> registros,
    AsyncValue<double> caloriasHoy,
    AsyncValue<Map<String, double>> macrosHoy,
  ) {
    if (registros.isEmpty) {
      return _buildEmptyState(context);
    }

    // Agrupar por tipo de comida
    final Map<String, List<RegistroAlimento>> porTipo = {
      'desayuno': [],
      'comida': [],
      'cena': [],
      'snack': [],
    };

    for (var registro in registros) {
      porTipo[registro.tipoComida]?.add(registro);
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final horizontalPadding = isSmallScreen ? 12.0 : 16.0;
    final verticalSpacing = isSmallScreen ? 12.0 : 16.0;

    return ListView(
      padding: EdgeInsets.all(horizontalPadding),
      children: [
        // Resumen de calorías
        _buildResumenCalorias(context, caloriasHoy),
        SizedBox(height: verticalSpacing),

        // Tarjeta de macros
        _buildMacrosCard(context, macrosHoy),
        SizedBox(height: verticalSpacing + 8),

        // Desayuno
        _buildSeccionComida(
          context,
          ref,
          'Desayuno',
          Icons.wb_sunny_outlined,
          Colors.orange,
          porTipo['desayuno']!,
        ),
        SizedBox(height: verticalSpacing),

        // Comida
        _buildSeccionComida(
          context,
          ref,
          'Comida',
          Icons.restaurant_outlined,
          Colors.green,
          porTipo['comida']!,
        ),
        SizedBox(height: verticalSpacing),

        // Cena
        _buildSeccionComida(
          context,
          ref,
          'Cena',
          Icons.nightlight_outlined,
          Colors.indigo,
          porTipo['cena']!,
        ),
        SizedBox(height: verticalSpacing),

        // Snacks
        if (porTipo['snack']!.isNotEmpty)
          _buildSeccionComida(
            context,
            ref,
            'Snacks',
            Icons.cookie_outlined,
            Colors.pink,
            porTipo['snack']!,
          ),

        const SizedBox(height: 80),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_menu, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 24),
          Text(
            'No has registrado alimentos hoy',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Comienza a registrar tu alimentación',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildResumenCalorias(
      BuildContext context, AsyncValue<double> caloriasHoy) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return caloriasHoy.when(
      data: (calorias) => Container(
        padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.3),
              blurRadius: isSmallScreen ? 15 : 20,
              offset: Offset(0, isSmallScreen ? 8 : 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Calorías de hoy',
              style: TextStyle(
                color: Colors.white70,
                fontSize: isSmallScreen ? 14 : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: isSmallScreen ? 8 : 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  calorias.toStringAsFixed(0),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 44 : 56,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                SizedBox(width: isSmallScreen ? 6 : 8),
                Text(
                  'kcal',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isSmallScreen ? 16 : 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 8 : 12),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 12 : 16,
                vertical: isSmallScreen ? 6 : 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
                    size: isSmallScreen ? 16 : 18,
                  ),
                  SizedBox(width: isSmallScreen ? 4 : 6),
                  Text(
                    'Meta: 2000 kcal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 12 : 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      loading: () => SizedBox(
        height: isSmallScreen ? 160 : 200,
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => const SizedBox.shrink(),
    );
  }

  Widget _buildMacrosCard(
      BuildContext context, AsyncValue<Map<String, double>> macrosHoy) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return macrosHoy.when(
      data: (macros) {
        final proteinas = macros['proteinas'] ?? 0.0;
        final carbohidratos = macros['carbohidratos'] ?? 0.0;
        final grasas = macros['grasas'] ?? 0.0;

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: EdgeInsets.all(isSmallScreen ? 12.0 : 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Macronutrientes',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 12 : 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildMacroItem(
                        context,
                        'Proteínas',
                        proteinas,
                        Colors.red,
                        Icons.fitness_center,
                      ),
                    ),
                    Expanded(
                      child: _buildMacroItem(
                        context,
                        'Carbos',
                        carbohidratos,
                        Colors.blue,
                        Icons.grain,
                      ),
                    ),
                    Expanded(
                      child: _buildMacroItem(
                        context,
                        'Grasas',
                        grasas,
                        Colors.amber,
                        Icons.water_drop,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (e, _) => const SizedBox.shrink(),
    );
  }

  Widget _buildMacroItem(
    BuildContext context,
    String label,
    double value,
    Color color,
    IconData icon,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Column(
      children: [
        Container(
          width: isSmallScreen ? 40 : 48,
          height: isSmallScreen ? 40 : 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: isSmallScreen ? 20 : 24),
        ),
        SizedBox(height: isSmallScreen ? 6 : 8),
        Text(
          '${value.toStringAsFixed(0)}g',
          style: TextStyle(
            fontSize: isSmallScreen ? 16 : 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: isSmallScreen ? 2 : 4),
        Text(
          label,
          style: TextStyle(
            fontSize: isSmallScreen ? 10 : 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSeccionComida(
    BuildContext context,
    WidgetRef ref,
    String titulo,
    IconData icono,
    Color color,
    List<RegistroAlimento> registros,
  ) {
    final totalCalorias = registros.fold<double>(
      0.0,
      (sum, r) => sum + r.calorias,
    );

    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isSmallScreen ? 12 : 16),
                topRight: Radius.circular(isSmallScreen ? 12 : 16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: isSmallScreen ? 36 : 40,
                  height: isSmallScreen ? 36 : 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child:
                      Icon(icono, color: color, size: isSmallScreen ? 18 : 20),
                ),
                SizedBox(width: isSmallScreen ? 10 : 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 14 : 16,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      if (registros.isNotEmpty)
                        Text(
                          '${totalCalorias.toStringAsFixed(0)} kcal',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 11 : 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: color),
                  iconSize: isSmallScreen ? 22 : 24,
                  padding: EdgeInsets.all(isSmallScreen ? 4 : 8),
                  constraints: BoxConstraints(
                    minWidth: isSmallScreen ? 32 : 40,
                    minHeight: isSmallScreen ? 32 : 40,
                  ),
                  onPressed: () => _mostrarAgregarAlimento(
                    context,
                    ref,
                    tipoComidaPreseleccionado: titulo.toLowerCase(),
                  ),
                ),
              ],
            ),
          ),

          // Lista de alimentos
          if (registros.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Sin registros',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: registros.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: Colors.grey.shade200,
              ),
              itemBuilder: (context, index) {
                final registro = registros[index];
                return _buildAlimentoItem(context, ref, registro);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildAlimentoItem(
    BuildContext context,
    WidgetRef ref,
    RegistroAlimento registro,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 16,
        vertical: isSmallScreen ? 4 : 8,
      ),
      leading: Container(
        width: isSmallScreen ? 40 : 48,
        height: isSmallScreen ? 40 : 48,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(isSmallScreen ? 10 : 12),
        ),
        child: Icon(
          Icons.restaurant,
          color: AppTheme.primaryColor,
          size: isSmallScreen ? 20 : 24,
        ),
      ),
      title: Text(
        registro.nombre,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: isSmallScreen ? 13 : 15,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${registro.cantidad.toStringAsFixed(0)} ${registro.unidadMedida} • '
        'P: ${registro.proteinas.toStringAsFixed(0)}g • '
        'C: ${registro.carbohidratos.toStringAsFixed(0)}g • '
        'G: ${registro.grasas.toStringAsFixed(0)}g',
        style: TextStyle(
          fontSize: isSmallScreen ? 10 : 12,
          color: Colors.grey.shade600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            registro.calorias.toStringAsFixed(0),
            style: TextStyle(
              fontSize: isSmallScreen ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          Text(
            'kcal',
            style: TextStyle(
              fontSize: isSmallScreen ? 10 : 11,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
      onLongPress: () => _confirmarEliminar(context, ref, registro),
    );
  }

  void _mostrarHistorial(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _HistorialComidas(),
    );
  }

  void _mostrarAgregarAlimento(
    BuildContext context,
    WidgetRef ref, {
    String? tipoComidaPreseleccionado,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _FormularioAlimento(
        tipoComidaInicial: tipoComidaPreseleccionado,
      ),
    );
  }

  void _confirmarEliminar(
    BuildContext context,
    WidgetRef ref,
    RegistroAlimento registro,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar registro'),
        content: Text('¿Eliminar "${registro.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref
                  .read(alimentoControllerProvider.notifier)
                  .eliminarRegistro(registro.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registro eliminado')),
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

// ========== FORMULARIO DE AGREGAR ALIMENTO ==========

class _FormularioAlimento extends ConsumerStatefulWidget {
  final String? tipoComidaInicial;

  const _FormularioAlimento({this.tipoComidaInicial});

  @override
  ConsumerState<_FormularioAlimento> createState() =>
      _FormularioAlimentoState();
}

class _FormularioAlimentoState extends ConsumerState<_FormularioAlimento> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _caloriasCtrl = TextEditingController();
  final _proteinasCtrl = TextEditingController();
  final _carbohidratosCtrl = TextEditingController();
  final _grasasCtrl = TextEditingController();
  final _cantidadCtrl = TextEditingController(text: '100');

  String _tipoComida = 'desayuno';
  String _unidadMedida = 'gramos';
  bool _calculoAutomatico = true; // Activar cálculo automático por defecto
  bool _mostrarBiblioteca = true; // Mostrar biblioteca por defecto
  List<AlimentoBase> _alimentosFiltrados = [];
  final _buscarCtrl = TextEditingController();

  // Variables para almacenar valores de referencia (cuando se selecciona un alimento)
  double? _cantidadReferencia;
  double? _caloriasReferencia;
  double? _proteinasReferencia;
  double? _carbohidratosReferencia;
  double? _grasasReferencia;
  String? _unidadReferencia;

  @override
  void initState() {
    super.initState();
    if (widget.tipoComidaInicial != null) {
      _tipoComida = widget.tipoComidaInicial!;
    }

    // Cargar alimentos comunes
    _alimentosFiltrados = AlimentosComunes.obtenerAlimentosBase();

    // Listener para búsqueda
    _buscarCtrl.addListener(_filtrarAlimentos);

    // Listener para cantidad - recalcular proporcionalmente
    _cantidadCtrl.addListener(_ajustarValoresPorCantidad);

    // Listener para nombre - limpiar referencias si se edita manualmente
    _nombreCtrl.addListener(() {
      // Si el usuario edita el nombre manualmente, limpiar referencias
      // para que no se aplique ajuste automático
      if (_nombreCtrl.text.isEmpty) {
        _limpiarReferencias();
      }
    });

    // Listeners para cálculo automático de calorías basado en macros
    _proteinasCtrl.addListener(() {
      _calcularCalorias();
      // Si edita manualmente los macros, limpiar referencias
      if (_proteinasCtrl.text.isNotEmpty && _proteinasReferencia != null) {
        final valorActual = double.tryParse(_proteinasCtrl.text);
        final valorReferencia = _proteinasReferencia! * (_cantidadCtrl.text.isEmpty ? 1 : (double.tryParse(_cantidadCtrl.text) ?? 1) / (_cantidadReferencia ?? 1));
        if (valorActual != null && (valorActual - valorReferencia).abs() > 0.5) {
          // Usuario editó manualmente, limpiar referencias
          _limpiarReferencias();
        }
      }
    });
    _carbohidratosCtrl.addListener(() {
      _calcularCalorias();
    });
    _grasasCtrl.addListener(() {
      _calcularCalorias();
    });

    // Si el usuario edita calorías manualmente, desactivar auto-cálculo
    _caloriasCtrl.addListener(() {
      if (_caloriasCtrl.text.isNotEmpty && !_calculoAutomatico) {
        return;
      }
    });
  }

  void _filtrarAlimentos() {
    final query = _buscarCtrl.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _alimentosFiltrados = AlimentosComunes.obtenerAlimentosBase();
      } else {
        _alimentosFiltrados = AlimentosComunes.obtenerAlimentosBase()
            .where((a) => a.nombre.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _seleccionarAlimento(AlimentoBase alimento) {
    setState(() {
      _nombreCtrl.text = alimento.nombre;
      _cantidadCtrl.text = alimento.cantidadReferencia.toStringAsFixed(0);
      _unidadMedida = alimento.unidadReferencia;
      
      // Guardar valores de referencia
      _cantidadReferencia = alimento.cantidadReferencia;
      _caloriasReferencia = alimento.calorias;
      _proteinasReferencia = alimento.proteinas;
      _carbohidratosReferencia = alimento.carbohidratos;
      _grasasReferencia = alimento.grasas;
      _unidadReferencia = alimento.unidadReferencia;
      
      // Establecer valores iniciales
      _proteinasCtrl.text = alimento.proteinas.toStringAsFixed(1);
      _carbohidratosCtrl.text = alimento.carbohidratos.toStringAsFixed(1);
      _grasasCtrl.text = alimento.grasas.toStringAsFixed(1);
      _caloriasCtrl.text = alimento.calorias.toStringAsFixed(0);
      
      _mostrarBiblioteca = false; // Ocultar biblioteca tras seleccionar
    });
  }

  void _limpiarReferencias() {
    _cantidadReferencia = null;
    _caloriasReferencia = null;
    _proteinasReferencia = null;
    _carbohidratosReferencia = null;
    _grasasReferencia = null;
  }

  // Permite parsear números con coma o punto como separador decimal
  double? _parseNumero(String? v) {
    if (v == null) return null;
    final s = v.trim().replaceAll(',', '.');
    return double.tryParse(s);
  }

  void _ajustarValoresPorCantidad() {
    // Solo ajustar si tenemos valores de referencia (se seleccionó un alimento)
    if (_cantidadReferencia == null || _cantidadReferencia == 0) return;

    // Solo escalar si la unidad actual coincide con la unidad de referencia
    if (_unidadReferencia != null && _unidadReferencia != _unidadMedida) {
      return;
    }
    
    final cantidadActual = _parseNumero(_cantidadCtrl.text);
    if (cantidadActual == null) return;
    
    // Calcular el factor de multiplicación
    final factor = cantidadActual / _cantidadReferencia!;
    
    // Ajustar valores proporcionalmente
    if (_caloriasReferencia != null) {
      _caloriasCtrl.text = (_caloriasReferencia! * factor).toStringAsFixed(0);
    }
    if (_proteinasReferencia != null) {
      _proteinasCtrl.text = (_proteinasReferencia! * factor).toStringAsFixed(1);
    }
    if (_carbohidratosReferencia != null) {
      _carbohidratosCtrl.text = (_carbohidratosReferencia! * factor).toStringAsFixed(1);
    }
    if (_grasasReferencia != null) {
      _grasasCtrl.text = (_grasasReferencia! * factor).toStringAsFixed(1);
    }
  }

  void _calcularCalorias() {
    if (!_calculoAutomatico) return;

    final proteinas = double.tryParse(_proteinasCtrl.text) ?? 0.0;
    final carbohidratos = double.tryParse(_carbohidratosCtrl.text) ?? 0.0;
    final grasas = double.tryParse(_grasasCtrl.text) ?? 0.0;

    // Fórmula: 1g proteína = 4kcal, 1g carbos = 4kcal, 1g grasa = 9kcal
    final caloriasCalculadas =
        (proteinas * 4) + (carbohidratos * 4) + (grasas * 9);

    if (caloriasCalculadas > 0) {
      _caloriasCtrl.text = caloriasCalculadas.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _caloriasCtrl.dispose();
    _proteinasCtrl.dispose();
    _carbohidratosCtrl.dispose();
    _grasasCtrl.dispose();
    _cantidadCtrl.dispose();
    _buscarCtrl.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    final registro = RegistroAlimento()
      ..nombre = _nombreCtrl.text.trim()
      ..calorias = double.parse(_caloriasCtrl.text.trim())
      ..proteinas = double.parse(_proteinasCtrl.text.trim())
      ..carbohidratos = double.parse(_carbohidratosCtrl.text.trim())
      ..grasas = double.parse(_grasasCtrl.text.trim())
      ..cantidad = double.parse(_cantidadCtrl.text.trim())
      ..unidadMedida = _unidadMedida
      ..tipoComida = _tipoComida
      ..fecha = DateTime.now();

    try {
      await ref
          .read(alimentoControllerProvider.notifier)
          .guardarRegistro(registro);
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alimento registrado')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(
        left: isSmallScreen ? 12 : 16,
        right: isSmallScreen ? 12 : 16,
        top: isSmallScreen ? 8 : 12,
        bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(isSmallScreen ? 16 : 20),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle
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
                  SizedBox(height: isSmallScreen ? 12 : 16),

                  Text(
                    'Agregar alimento',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 18 : 22,
                        ),
                  ),
                  SizedBox(height: isSmallScreen ? 6 : 8),

                  // Toggle para mostrar/ocultar biblioteca
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _mostrarBiblioteca = !_mostrarBiblioteca;
                            });
                          },
                          icon: Icon(
                            _mostrarBiblioteca
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: isSmallScreen ? 18 : 20,
                          ),
                          label: Text(
                            _mostrarBiblioteca
                                ? 'Ocultar biblioteca'
                                : 'Ver biblioteca de alimentos',
                            style: TextStyle(fontSize: isSmallScreen ? 11 : 13),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Biblioteca de alimentos
                  if (_mostrarBiblioteca) ...[
                    SizedBox(height: isSmallScreen ? 6 : 8),
                    TextField(
                      controller: _buscarCtrl,
                      style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                      decoration: InputDecoration(
                        hintText: 'Buscar alimento...',
                        hintStyle: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                        prefixIcon:
                            Icon(Icons.search, size: isSmallScreen ? 20 : 24),
                        suffixIcon: _buscarCtrl.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear,
                                    size: isSmallScreen ? 20 : 24),
                                onPressed: () {
                                  _buscarCtrl.clear();
                                },
                              )
                            : null,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 12 : 16,
                          vertical: isSmallScreen ? 8 : 12,
                        ),
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 6 : 8),
                    Container(
                      height: isSmallScreen ? 180 : 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.separated(
                        itemCount: _alimentosFiltrados.length,
                        separatorBuilder: (_, __) =>
                            Divider(height: 1, color: Colors.grey.shade200),
                        itemBuilder: (context, index) {
                          final alimento = _alimentosFiltrados[index];
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 8 : 12,
                              vertical: isSmallScreen ? 2 : 4,
                            ),
                            leading: Container(
                              width: isSmallScreen ? 28 : 32,
                              height: isSmallScreen ? 28 : 32,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                    isSmallScreen ? 6 : 8),
                              ),
                              child: Icon(
                                Icons.restaurant,
                                size: isSmallScreen ? 16 : 18,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            title: Text(
                              alimento.nombre,
                              style:
                                  TextStyle(fontSize: isSmallScreen ? 12 : 14),
                            ),
                            subtitle: Text(
                              '${alimento.calorias.toStringAsFixed(0)} kcal • ${alimento.cantidadReferencia.toStringAsFixed(0)} ${alimento.unidadReferencia}',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 10 : 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            onTap: () => _seleccionarAlimento(alimento),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 16),
                  ],

                  SizedBox(height: isSmallScreen ? 6 : 8),

                  // Nombre
                  TextFormField(
                    controller: _nombreCtrl,
                    style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                    decoration: InputDecoration(
                      labelText: 'Nombre del alimento',
                      labelStyle: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                      prefixIcon: Icon(Icons.restaurant_menu,
                          size: isSmallScreen ? 20 : 24),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 12 : 16,
                        vertical: isSmallScreen ? 12 : 14,
                      ),
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                  ),
                  SizedBox(height: isSmallScreen ? 12 : 16),

                  // Tipo de comida
                  DropdownButtonFormField<String>(
                    value: _tipoComida,
                    style: TextStyle(
                        fontSize: isSmallScreen ? 13 : 14, color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Tipo de comida',
                      labelStyle: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                      prefixIcon:
                          Icon(Icons.category, size: isSmallScreen ? 20 : 24),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 12 : 16,
                        vertical: isSmallScreen ? 12 : 14,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                          value: 'desayuno',
              child: Text('Desayuno',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 14))),
                      DropdownMenuItem(
                          value: 'comida',
              child: Text('Comida',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 14))),
                      DropdownMenuItem(
                          value: 'cena',
              child: Text('Cena',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 14))),
                      DropdownMenuItem(
                          value: 'snack',
                          child: Text('Snack',
                                style: TextStyle(
                                    fontSize: isSmallScreen ? 13 : 14))),
                    ],
                    onChanged: (v) => setState(() => _tipoComida = v!),
                  ),
                  SizedBox(height: isSmallScreen ? 12 : 16),

                  // Cantidad y unidad
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _cantidadCtrl,
                          style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                          decoration: InputDecoration(
                            labelText: 'Cantidad',
                            labelStyle:
                                TextStyle(fontSize: isSmallScreen ? 13 : 14),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                              vertical: isSmallScreen ? 12 : 14,
                            ),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          onChanged: (_) => _ajustarValoresPorCantidad(),
                          validator: (v) =>
                              (v == null || _parseNumero(v) == null)
                                  ? 'Inválido'
                                  : null,
                        ),
                      ),
                      SizedBox(width: isSmallScreen ? 8 : 12),
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<String>(
                          value: _unidadMedida,
                          style: TextStyle(
                              fontSize: isSmallScreen ? 13 : 14,
                              color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Unidad',
                            labelStyle:
                                TextStyle(fontSize: isSmallScreen ? 13 : 14),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                              vertical: isSmallScreen ? 12 : 14,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                                value: 'gramos',
                                child: Text('gramos',
                                    style: TextStyle(
                                        fontSize: isSmallScreen ? 13 : 14))),
                            DropdownMenuItem(
                                value: 'ml',
                                child: Text('ml',
                                    style: TextStyle(
                                        fontSize: isSmallScreen ? 13 : 14))),
                            DropdownMenuItem(
                                value: 'unidad',
                                child: Text('unidad',
                                    style: TextStyle(
                                        fontSize: isSmallScreen ? 13 : 14))),
                            DropdownMenuItem(
                                value: 'taza',
                                child: Text('taza',
                                    style: TextStyle(
                                        fontSize: isSmallScreen ? 13 : 14))),
                            DropdownMenuItem(
                                value: 'porción',
                                child: Text('porción',
                                    style: TextStyle(
                                        fontSize: isSmallScreen ? 13 : 14))),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              _unidadMedida = v;
                              // Si la unidad deja de coincidir con la referencia, limpiar referencias
                              if (_unidadReferencia != null &&
                                  _unidadMedida != _unidadReferencia) {
                                _limpiarReferencias();
                              } else {
                                // Si vuelve a coincidir, reintentar ajustar por cantidad
                                _ajustarValoresPorCantidad();
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 12 : 16),

                  // Macros con título y switch de auto-cálculo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Macronutrientes',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: isSmallScreen ? 13 : 14,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Auto',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 11 : 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(width: isSmallScreen ? 4 : 8),
                          Transform.scale(
                            scale: isSmallScreen ? 0.85 : 1.0,
                            child: Switch(
                              value: _calculoAutomatico,
                              onChanged: (value) {
                                setState(() {
                                  _calculoAutomatico = value;
                                  if (value) {
                                    _calcularCalorias();
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 6 : 8),

                  // Macros
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _proteinasCtrl,
                          style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                          decoration: InputDecoration(
                            labelText: 'Proteínas',
                            labelStyle:
                                TextStyle(fontSize: isSmallScreen ? 12 : 13),
                            suffixText: 'g',
                            suffixStyle:
                                TextStyle(fontSize: isSmallScreen ? 11 : 12),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 10 : 12,
                              vertical: isSmallScreen ? 12 : 14,
                            ),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator: (v) =>
                              (v == null || double.tryParse(v) == null)
                                  ? 'Inválido'
                                  : null,
                        ),
                      ),
                      SizedBox(width: isSmallScreen ? 6 : 12),
                      Expanded(
                        child: TextFormField(
                          controller: _carbohidratosCtrl,
                          style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                          decoration: InputDecoration(
                            labelText: 'Carbos',
                            labelStyle:
                                TextStyle(fontSize: isSmallScreen ? 12 : 13),
                            suffixText: 'g',
                            suffixStyle:
                                TextStyle(fontSize: isSmallScreen ? 11 : 12),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 10 : 12,
                              vertical: isSmallScreen ? 12 : 14,
                            ),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator: (v) =>
                              (v == null || double.tryParse(v) == null)
                                  ? 'Inválido'
                                  : null,
                        ),
                      ),
                      SizedBox(width: isSmallScreen ? 6 : 12),
                      Expanded(
                        child: TextFormField(
                          controller: _grasasCtrl,
                          style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                          decoration: InputDecoration(
                            labelText: 'Grasas',
                            labelStyle:
                                TextStyle(fontSize: isSmallScreen ? 12 : 13),
                            suffixText: 'g',
                            suffixStyle:
                                TextStyle(fontSize: isSmallScreen ? 11 : 12),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 10 : 12,
                              vertical: isSmallScreen ? 12 : 14,
                            ),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator: (v) =>
                              (v == null || double.tryParse(v) == null)
                                  ? 'Inválido'
                                  : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 12 : 16),

                  // Calorías (ahora abajo, después de macros)
                  TextFormField(
                    controller: _caloriasCtrl,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 14,
                      color: _calculoAutomatico ? Colors.grey : null,
                      fontWeight: _calculoAutomatico ? FontWeight.bold : null,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Calorías totales',
                      labelStyle: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                      prefixIcon: Icon(Icons.local_fire_department,
                          size: isSmallScreen ? 20 : 24),
                      suffixText: 'kcal',
                      suffixStyle: TextStyle(fontSize: isSmallScreen ? 11 : 12),
                      helperText: _calculoAutomatico
                          ? 'Calculadas automáticamente'
                          : 'Ingresa manualmente',
                      helperStyle: TextStyle(
                        fontSize: isSmallScreen ? 10 : 11,
                        color: _calculoAutomatico ? Colors.green : Colors.grey,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 12 : 16,
                        vertical: isSmallScreen ? 12 : 14,
                      ),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    readOnly: _calculoAutomatico,
                    enabled: !_calculoAutomatico,
                    validator: (v) => (v == null || double.tryParse(v) == null)
                        ? 'Inválido'
                        : null,
                  ),
                  SizedBox(height: isSmallScreen ? 16 : 24),

                  // Botón guardar
                  ElevatedButton(
                    onPressed: _guardar,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: isSmallScreen ? 12 : 16,
                      ),
                    ),
                    child: Text(
                      'Guardar alimento',
                      style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
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

// ========== HISTORIAL DE COMIDAS ==========

class _HistorialComidas extends ConsumerStatefulWidget {
  const _HistorialComidas();

  @override
  ConsumerState<_HistorialComidas> createState() => _HistorialComidasState();
}

class _HistorialComidasState extends ConsumerState<_HistorialComidas> {
  DateTime _fechaSeleccionada = DateTime.now().subtract(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    final registrosPorFecha = ref.watch(
      registrosAlimentosPorFechaProvider(_fechaSeleccionada),
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Historial de Comidas',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Selector de fecha
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        setState(() {
                          _fechaSeleccionada = _fechaSeleccionada
                              .subtract(const Duration(days: 1));
                        });
                      },
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final fecha = await showDatePicker(
                            context: context,
                            initialDate: _fechaSeleccionada,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                            locale: const Locale('es', 'ES'),
                          );
                          if (fecha != null) {
                            setState(() {
                              _fechaSeleccionada = fecha;
                            });
                          }
                        },
                        child: Center(
                          child: Text(
                            _formatearFecha(_fechaSeleccionada),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: _fechaSeleccionada.day == DateTime.now().day &&
                              _fechaSeleccionada.month == DateTime.now().month &&
                              _fechaSeleccionada.year == DateTime.now().year
                          ? null
                          : () {
                              setState(() {
                                _fechaSeleccionada = _fechaSeleccionada
                                    .add(const Duration(days: 1));
                              });
                            },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Contenido
          Expanded(
            child: registrosPorFecha.when(
              data: (registros) {
                if (registros.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant_menu,
                          size: 64,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No hay registros para esta fecha',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Agrupar por tipo de comida
                final Map<String, List<RegistroAlimento>> porTipo = {
                  'desayuno': [],
                  'comida': [],
                  'cena': [],
                  'snack': [],
                };

                for (var registro in registros) {
                  porTipo[registro.tipoComida]?.add(registro);
                }

                // Calcular totales
                final totalCalorias = registros.fold<double>(
                  0.0,
                  (sum, r) => sum + r.calorias,
                );
                final totalProteinas = registros.fold<double>(
                  0.0,
                  (sum, r) => sum + r.proteinas,
                );
                final totalCarbohidratos = registros.fold<double>(
                  0.0,
                  (sum, r) => sum + r.carbohidratos,
                );
                final totalGrasas = registros.fold<double>(
                  0.0,
                  (sum, r) => sum + r.grasas,
                );

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Resumen del día
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Resumen del día',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  totalCalorias.toStringAsFixed(0),
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'kcal',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildMacroChip(
                                  'Proteínas',
                                  totalProteinas,
                                  Colors.red,
                                ),
                                _buildMacroChip(
                                  'Carbos',
                                  totalCarbohidratos,
                                  Colors.blue,
                                ),
                                _buildMacroChip(
                                  'Grasas',
                                  totalGrasas,
                                  Colors.amber,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Comidas del día
                    if (porTipo['desayuno']!.isNotEmpty) ...[
                      _buildSeccionHistorial(
                        'Desayuno',
                        Icons.wb_sunny_outlined,
                        Colors.orange,
                        porTipo['desayuno']!,
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (porTipo['comida']!.isNotEmpty) ...[
                      _buildSeccionHistorial(
                        'Comida',
                        Icons.restaurant_outlined,
                        Colors.green,
                        porTipo['comida']!,
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (porTipo['cena']!.isNotEmpty) ...[
                      _buildSeccionHistorial(
                        'Cena',
                        Icons.nightlight_outlined,
                        Colors.indigo,
                        porTipo['cena']!,
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (porTipo['snack']!.isNotEmpty) ...[
                      _buildSeccionHistorial(
                        'Snacks',
                        Icons.cookie_outlined,
                        Colors.pink,
                        porTipo['snack']!,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Text('Error: $e'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroChip(String label, double value, Color color) {
    return Column(
      children: [
        Text(
          '${value.toStringAsFixed(0)}g',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSeccionHistorial(
    String titulo,
    IconData icono,
    Color color,
    List<RegistroAlimento> registros,
  ) {
    final totalCalorias = registros.fold<double>(
      0.0,
      (sum, r) => sum + r.calorias,
    );

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icono, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        '${totalCalorias.toStringAsFixed(0)} kcal',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Lista de alimentos
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: registros.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              color: Colors.grey.shade200,
            ),
            itemBuilder: (context, index) {
              final registro = registros[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.restaurant,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                ),
                title: Text(
                  registro.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  '${registro.cantidad.toStringAsFixed(0)} ${registro.unidadMedida} • '
                  'P: ${registro.proteinas.toStringAsFixed(0)}g • '
                  'C: ${registro.carbohidratos.toStringAsFixed(0)}g • '
                  'G: ${registro.grasas.toStringAsFixed(0)}g',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      registro.calorias.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    Text(
                      'kcal',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                onLongPress: () => _confirmarEliminar(context, registro),
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatearFecha(DateTime fecha) {
    final hoy = DateTime.now();
    final ayer = hoy.subtract(const Duration(days: 1));

    if (fecha.year == hoy.year &&
        fecha.month == hoy.month &&
        fecha.day == hoy.day) {
      return 'Hoy';
    } else if (fecha.year == ayer.year &&
        fecha.month == ayer.month &&
        fecha.day == ayer.day) {
      return 'Ayer';
    } else {
      // Formato: "Lunes 15 de Octubre"
      final meses = [
        'Enero',
        'Febrero',
        'Marzo',
        'Abril',
        'Mayo',
        'Junio',
        'Julio',
        'Agosto',
        'Septiembre',
        'Octubre',
        'Noviembre',
        'Diciembre'
      ];
      final dias = [
        'Lunes',
        'Martes',
        'Miércoles',
        'Jueves',
        'Viernes',
        'Sábado',
        'Domingo'
      ];

      final diaSemana = dias[(fecha.weekday - 1) % 7];
      final mes = meses[fecha.month - 1];

      return '$diaSemana ${fecha.day} de $mes';
    }
  }

  void _confirmarEliminar(BuildContext context, RegistroAlimento registro) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar registro'),
        content: Text('¿Eliminar "${registro.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref
                  .read(alimentoControllerProvider.notifier)
                  .eliminarRegistro(registro.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registro eliminado')),
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
