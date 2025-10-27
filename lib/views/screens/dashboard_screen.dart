import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../controllers/registro_controller.dart';
import '../../controllers/ejercicio_controller.dart';
import '../../controllers/caminata_controller.dart';
import '../../models/ejercicio.dart';
import '../../config/theme.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrosHoy = ref.watch(registrosHoyProvider);
    final registrosSemanales = ref.watch(registrosSemanalesProvider);
    final ejercicios = ref.watch(ejerciciosProvider);
    final estadisticasCaminatas = ref.watch(estadisticasCaminatasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarjeta de bienvenida
            _buildWelcomeCard(context),
            const SizedBox(height: 24),

            // Métricas rápidas
            _buildQuickMetrics(context, registrosHoy, estadisticasCaminatas),
            const SizedBox(height: 24),

            // Gráfica de progreso semanal
            Text(
              'Progreso Semanal',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildWeeklyProgressChart(context, registrosSemanales),
            const SizedBox(height: 24),

            // Ejercicios de hoy
            Text(
              'Hoy',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            registrosHoy.when(
              data: (registros) => registros.isEmpty
                  ? _buildEmptyState(context)
                  : _buildRegistrosHoy(context, registros, ejercicios),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
            ),
            const SizedBox(height: 24),

            // Gráfica de distribución por tipo
            ejercicios.when(
              data: (ejerciciosList) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Distribución de Ejercicios',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildDistributionChart(context, ejerciciosList),
                ],
              ),
              loading: () => const SizedBox.shrink(),
              error: (e, _) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    final hora = DateTime.now().hour;
    String saludo;
    if (hora < 12) {
      saludo = '¡Buenos días!';
    } else if (hora < 20) {
      saludo = '¡Buenas tardes!';
    } else {
      saludo = '¡Buenas noches!';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppTheme.primaryColor,
            AppTheme.secondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            saludo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Continúa con tu progreso',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickMetrics(
    BuildContext context,
    AsyncValue registrosHoy,
    AsyncValue estadisticasCaminatas,
  ) {
  return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final availableWidth = maxWidth.isFinite
            ? maxWidth
            : MediaQuery.of(context).size.width;
        const spacing = 12.0;
    // Mantener 3 columnas en teléfonos típicos (Pixel ~411dp),
    // degradar a 2/1 solo en anchos realmente pequeños.
    final columns = availableWidth >= 360
      ? 3
      : availableWidth >= 300
        ? 2
        : 1;
        final horizontalGaps = spacing * (columns - 1);
        final itemWidth = columns == 1
            ? availableWidth
            : (availableWidth - horizontalGaps) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment:
              columns == 1 ? WrapAlignment.center : WrapAlignment.start,
          children: [
            SizedBox(
              width: itemWidth,
              child: _buildMetricCard(
                context,
                'Ejercicios Hoy',
                registrosHoy.when(
                  data: (data) => '${data.length}',
                  loading: () => '-',
                  error: (_, __) => '0',
                ),
                Icons.fitness_center,
                AppTheme.primaryColor,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _buildMetricCard(
                context,
                'Caminatas',
                estadisticasCaminatas.when(
                  data: (stats) => '${stats['total']}',
                  loading: () => '-',
                  error: (_, __) => '0',
                ),
                Icons.directions_walk,
                AppTheme.accentColor,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _buildMetricCard(
                context,
                'Tiempo Total',
                estadisticasCaminatas.when(
                  data: (stats) {
                    final duracion = stats['duracionTotal'] as int;
                    final minutos = duracion ~/ 60;
                    return '${minutos}m';
                  },
                  loading: () => '-',
                  error: (_, __) => '0m',
                ),
                Icons.timer,
                AppTheme.secondaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
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
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyProgressChart(BuildContext context, AsyncValue<Map<int, int>> registrosSemanales) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: registrosSemanales.when(
        data: (conteo) => BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: conteo.values.isEmpty ? 10 : (conteo.values.reduce((a, b) => a > b ? a : b) + 2).toDouble(),
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        days[value.toInt()],
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: TextStyle(color: Colors.grey.shade600),
                    );
                  },
                ),
              ),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 2,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.shade200,
                  strokeWidth: 1,
                );
              },
            ),
            borderData: FlBorderData(show: false),
            barGroups: List.generate(7, (index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: conteo[index]?.toDouble() ?? 0,
                    gradient: const LinearGradient(
                      colors: [
                        AppTheme.primaryColor,
                        AppTheme.secondaryColor,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    width: 16,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                  ),
                ],
              );
            }),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error al cargar datos: $e', style: TextStyle(color: Colors.grey.shade600))),
      ),
    );
  }

  Widget _buildRegistrosHoy(BuildContext context, List registros, AsyncValue ejercicios) {
    return ejercicios.when(
      data: (ejerciciosList) {
        return Column(
          children: registros.take(3).map((registro) {
            Ejercicio? ejercicio;
            try {
              ejercicio = ejerciciosList.firstWhere(
                (e) => e.id == registro.ejercicioId,
              );
            } catch (e) {
              // Ejercicio no encontrado
            }
            
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                  child: const Icon(Icons.fitness_center, color: AppTheme.primaryColor),
                ),
                title: Text(ejercicio?.nombre ?? 'Ejercicio #${registro.ejercicioId}'),
                subtitle: Text('${registro.series.length} series'),
                trailing: Text(
                  DateFormat('HH:mm').format(registro.fecha),
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            );
          }).toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Column(
        children: registros.take(3).map((registro) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                child: const Icon(Icons.fitness_center, color: AppTheme.primaryColor),
              ),
              title: Text('Ejercicio #${registro.ejercicioId}'),
              subtitle: Text('${registro.series.length} series'),
              trailing: Text(
                DateFormat('HH:mm').format(registro.fecha),
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(Icons.fitness_center, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No hay ejercicios registrados hoy',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '¡Comienza tu rutina!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistributionChart(BuildContext context, List ejercicios) {
    final Map<String, int> distribution = {};
    for (var ejercicio in ejercicios) {
      distribution[ejercicio.tipo] = (distribution[ejercicio.tipo] ?? 0) + 1;
    }

    if (distribution.isEmpty) return const SizedBox.shrink();

  return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final availableWidth = maxWidth.isFinite
            ? maxWidth
            : MediaQuery.of(context).size.width;
    // iPhone 15 (~393dp) usa layout compacto; Pixel (~411dp) mantiene layout amplio.
    final isCompact = availableWidth < 400;
        final chartRadius = isCompact ? 48.0 : 60.0;
        final centerRadius = isCompact ? 28.0 : 40.0;

        List<Widget> buildLegendItems() {
          return distribution.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppTheme.getColorForTipo(entry.key),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList();
        }

        Widget buildChart() {
          return PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: centerRadius,
              sections: distribution.entries.map((entry) {
                final color = AppTheme.getColorForTipo(entry.key);
                return PieChartSectionData(
                  value: entry.value.toDouble(),
                  title: '${entry.value}',
                  color: color,
                  radius: chartRadius,
                  titleStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
            ),
          );
        }

        final legend = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildLegendItems(),
        );

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: isCompact
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 200,
                      child: buildChart(),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: legend,
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 220,
                        child: buildChart(),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: legend,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
