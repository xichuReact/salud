import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../config/theme.dart';
import '../../controllers/pasos_controller.dart';
import '../../models/pasos_registro.dart';

class PasosScreen extends ConsumerStatefulWidget {
  const PasosScreen({super.key});

  @override
  ConsumerState<PasosScreen> createState() => _PasosScreenState();
}

class _PasosScreenState extends ConsumerState<PasosScreen> {
  @override
  Widget build(BuildContext context) {
    final estadisticasAsync = ref.watch(pasosEstadisticasProvider);
    final registrosAsync = ref.watch(pasosRegistrosProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Pasos'),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: AppTheme.primaryColor),
                ),
                tooltip: 'Agregar registro',
                onPressed: () => _mostrarEditorRegistro(context),
              ),
              const SizedBox(width: 8),
            ],
          ),
          estadisticasAsync.when(
            data: (estadisticas) => registrosAsync.when(
              data: (registros) =>
                  _buildContent(context, estadisticas, registros),
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SliverFillRemaining(
                child: Center(child: Text('Error al cargar registros: $e')),
              ),
            ),
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => SliverFillRemaining(
              child: Center(child: Text('Error al cargar estadísticas: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PasosEstadisticas estadisticas,
    List<PasosRegistro> registros,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          // Tarjeta destacada principal
          _buildHeroCard(context, estadisticas),
          const SizedBox(height: 16),

          // Gráfica semanal
          _buildWeeklyChart(context, estadisticas),
          const SizedBox(height: 16),

          // Comparativa mensual
          _buildComparativaCard(context, estadisticas),
          const SizedBox(height: 24),

          // Título historial
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Historial',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (registros.isNotEmpty)
                TextButton.icon(
                  onPressed: () => _mostrarEditorRegistro(context),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Agregar'),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Lista de registros
          if (registros.isEmpty)
            _buildEmptyState(context)
          else
            ...registros
                .take(10)
                .map((registro) => _buildRegistroCard(context, registro)),
        ]),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context, PasosEstadisticas estadisticas) {
    final diferencia = estadisticas.pasosHoy - estadisticas.promedioUltimos7;
    final esPositivo = diferencia >= 0;
    final porcentaje = estadisticas.promedioUltimos7 > 0
        ? ((diferencia.abs() / estadisticas.promedioUltimos7) * 100)
            .toStringAsFixed(0)
        : '0';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: esPositivo
              ? [AppTheme.primaryColor, AppTheme.secondaryColor]
              : [Colors.orange.shade700, Colors.deepOrange.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: (esPositivo ? AppTheme.primaryColor : Colors.deepOrange)
                .withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  esPositivo ? Icons.trending_up : Icons.trending_down,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white, size: 14),
                    SizedBox(width: 6),
                    Text(
                      'Hoy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            estadisticas.pasosHoy.toStringAsFixed(0),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'pasos registrados',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  esPositivo ? Icons.arrow_upward : Icons.arrow_downward,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        esPositivo
                            ? '¡$porcentaje% por encima!'
                            : '$porcentaje% por debajo',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'vs. promedio semanal (${estadisticas.promedioUltimos7} pasos)',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart(
      BuildContext context, PasosEstadisticas estadisticas) {
    final datos = estadisticas.ultimos7Dias;
    final maxPasos = datos.isEmpty
        ? 0
        : datos
            .map((d) => d.pasos)
            .reduce((value, element) => value > element ? value : element);
    final maxY = maxPasos == 0
        ? 10000.0
        : (maxPasos * 1.2).clamp(1000.0, double.infinity);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .outlineVariant
              .withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.bar_chart_rounded,
                  color: AppTheme.primaryColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Últimos 7 días',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Promedio: ${estadisticas.promedioUltimos7} pasos/día',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 220,
            child: datos.isEmpty
                ? Center(
                    child: Text(
                      'Sin datos esta semana',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  )
                : BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxY,
                      barGroups: [
                        for (int i = 0; i < datos.length; i++)
                          BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: datos[i].pasos.toDouble(),
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.primaryColor
                                        .withValues(alpha: 0.7),
                                    AppTheme.secondaryColor,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                                width: 20,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(6),
                                ),
                              ),
                            ],
                          ),
                      ],
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index < 0 || index >= datos.length) {
                                return const SizedBox.shrink();
                              }
                              final fecha = datos[index].fecha;
                              final label = DateFormat.E('es')
                                  .format(fecha)
                                  .substring(0, 1)
                                  .toUpperCase();
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            interval: maxY / 4,
                            getTitlesWidget: (value, meta) {
                              if (value == 0) return const SizedBox.shrink();
                              final formatted = value >= 1000
                                  ? '${(value / 1000).toStringAsFixed(1)}k'
                                  : value.toInt().toString();
                              return Text(
                                formatted,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                ),
                              );
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: maxY / 4,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Colors.grey.shade200,
                          strokeWidth: 1,
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipPadding: const EdgeInsets.all(10),
                          tooltipMargin: 8,
                          tooltipRoundedRadius: 12,
                          getTooltipColor: (_) =>
                              AppTheme.primaryColor.withValues(alpha: 0.95),
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final fecha = datos[groupIndex].fecha;
                            final dia = DateFormat('EEE d', 'es').format(fecha);
                            return BarTooltipItem(
                              '$dia\n',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              children: [
                                TextSpan(
                                  text: '${rod.toY.toInt()} pasos',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparativaCard(
      BuildContext context, PasosEstadisticas estadisticas) {
    final diferenciaMes =
        estadisticas.promedioMesActual - estadisticas.promedioMesAnterior;
    final esPositivo = diferenciaMes >= 0;
    final porcentaje = estadisticas.promedioMesAnterior > 0
        ? ((diferenciaMes.abs() / estadisticas.promedioMesAnterior) * 100)
            .toStringAsFixed(0)
        : '0';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .outlineVariant
              .withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.insights_rounded,
                  color: AppTheme.accentColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Comparativa mensual',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildMetricaTendencia(
                  context,
                  titulo: 'Mes actual',
                  valor: estadisticas.promedioMesActual,
                  esDestacado: true,
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.grey.shade200,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              Expanded(
                child: _buildMetricaTendencia(
                  context,
                  titulo: 'Mes anterior',
                  valor: estadisticas.promedioMesAnterior,
                  esDestacado: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: esPositivo ? Colors.green.shade50 : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    esPositivo ? Colors.green.shade200 : Colors.orange.shade200,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  esPositivo
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  color: esPositivo
                      ? Colors.green.shade700
                      : Colors.orange.shade700,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    esPositivo
                        ? '¡Aumentaste $porcentaje% respecto al mes anterior!'
                        : 'Disminuyó $porcentaje% respecto al mes anterior',
                    style: TextStyle(
                      color: esPositivo
                          ? Colors.green.shade900
                          : Colors.orange.shade900,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricaTendencia(
    BuildContext context, {
    required String titulo,
    required int valor,
    required bool esDestacado,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          valor.toStringAsFixed(0),
          style: TextStyle(
            fontSize: esDestacado ? 28 : 24,
            fontWeight: FontWeight.bold,
            color: esDestacado ? AppTheme.primaryColor : Colors.grey.shade700,
          ),
        ),
        Text(
          'pasos/día',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade500,
              ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .outlineVariant
              .withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.directions_walk,
              size: 48,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Sin registros aún',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega tus pasos diarios de la app Salud\npara visualizar tus tendencias',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => _mostrarEditorRegistro(context),
            icon: const Icon(Icons.add),
            label: const Text('Agregar primer registro'),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistroCard(BuildContext context, PasosRegistro registro) {
    final fechaFormatted =
        DateFormat('EEEE, d MMMM', 'es').format(registro.fecha);
    final esHoy = DateTime.now().difference(registro.fecha).inDays == 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: esHoy
            ? AppTheme.primaryColor.withValues(alpha: 0.05)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: esHoy
              ? AppTheme.primaryColor.withValues(alpha: 0.2)
              : Theme.of(context)
                  .colorScheme
                  .outlineVariant
                  .withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: esHoy
                  ? AppTheme.primaryColor.withValues(alpha: 0.15)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.directions_walk,
              color: esHoy ? AppTheme.primaryColor : Colors.grey.shade600,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        fechaFormatted.capitalize(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    if (esHoy)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'HOY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${registro.pasos.toStringAsFixed(0)} pasos',
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.grey.shade400,
            ),
            onPressed: () => _confirmarEliminar(context, registro.id),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmarEliminar(BuildContext context, int id) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        icon: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.delete_outline,
            color: Colors.red.shade600,
            size: 32,
          ),
        ),
        title: const Text(
          'Eliminar registro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          '¿Estás seguro de que deseas eliminar este registro de pasos? Esta acción no se puede deshacer.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmar == true && mounted) {
      await ref.read(pasosControllerProvider.notifier).eliminarRegistro(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Registro eliminado'),
              ],
            ),
            backgroundColor: Colors.green.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  Future<void> _mostrarEditorRegistro(BuildContext context) async {
    final pasosController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: StatefulBuilder(builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle visual
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Título
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.directions_walk,
                        color: AppTheme.primaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Registrar pasos',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Ingresa los pasos registrados en la app Salud de iOS',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),

                // Selector de fecha
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.calendar_today,
                          color: AppTheme.accentColor, size: 20),
                    ),
                    title: const Text(
                      'Fecha',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('EEEE, d MMMM y', 'es')
                          .format(selectedDate)
                          .capitalize(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing:
                        Icon(Icons.chevron_right, color: Colors.grey.shade400),
                    onTap: () async {
                      final nuevaFecha = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now(),
                        locale: const Locale('es'),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: AppTheme.primaryColor,
                                onPrimary: Colors.white,
                                surface: Colors.white,
                                onSurface: Colors.black,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (nuevaFecha != null) {
                        setState(() => selectedDate = nuevaFecha);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Campo de pasos
                TextField(
                  controller: pasosController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Número de pasos',
                    hintText: 'Ej: 8500',
                    prefixIcon: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.trending_up,
                        color: AppTheme.primaryColor,
                        size: 20,
                      ),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Theme.of(context)
                            .colorScheme
                            .outlineVariant
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppTheme.primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 24),

                // Botón de guardar
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton(
                    onPressed: () async {
                      final pasos = int.tryParse(pasosController.text.trim());
                      if (pasos == null || pasos <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                                'Ingresa un número válido de pasos.'),
                            backgroundColor: Colors.red.shade600,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                        return;
                      }

                      final parentContext = this.context;
                      final messenger = ScaffoldMessenger.of(parentContext);
                      final navigator = Navigator.of(parentContext);

                      await ref
                          .read(pasosControllerProvider.notifier)
                          .guardarRegistro(fecha: selectedDate, pasos: pasos);

                      if (!mounted) return;

                      if (navigator.mounted && navigator.canPop()) {
                        navigator.pop();
                      }
                      messenger.showSnackBar(
                        SnackBar(
                          content: const Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 12),
                              Text('Registro guardado correctamente'),
                            ],
                          ),
                          backgroundColor: Colors.green.shade600,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Guardar registro',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      },
    );

    pasosController.dispose();
  }
}

extension _StringCasing on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
