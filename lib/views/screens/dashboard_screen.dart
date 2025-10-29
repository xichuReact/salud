import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../controllers/registro_controller.dart';
import '../../controllers/ejercicio_controller.dart';
import '../../controllers/caminata_controller.dart';
import '../../controllers/pasos_controller.dart';
import '../../controllers/alimento_controller.dart';
import '../../controllers/agua_controller.dart';
import '../../models/ejercicio.dart';
import '../../config/theme.dart';
import 'package:intl/intl.dart';
import 'perfil_screen.dart';
import 'recordatorios_screen.dart';
import 'pasos_screen.dart';
import 'agua_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrosHoy = ref.watch(registrosHoyProvider);
    final registrosSemanales = ref.watch(registrosSemanalesProvider);
    final ejercicios = ref.watch(ejerciciosProvider);
    final sensacion7d = ref.watch(sensacionUltimos7Provider);
    final estadisticasCaminatas = ref.watch(estadisticasCaminatasProvider);
    // Nutrición
    final caloriasHoy = ref.watch(caloriasHoyProvider);
    final macrosHoy = ref.watch(macrosHoyProvider);
    final caloriasSemanales = ref.watch(caloriasSemanalesProvider);
    final ultimosAlimentos = ref.watch(ultimosAlimentosProvider);
    final pasosEstadisticas = ref.watch(pasosEstadisticasProvider);
    // Hidratación
    final aguaTotalHoy = ref.watch(aguaTotalHoyProvider);
    final aguaProgreso = ref.watch(aguaProgresoProvider);
    final aguaSemanal = ref.watch(aguaConsumoSemanalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PerfilScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Recordatorios',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RecordatoriosScreen()),
              );
            },
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

            pasosEstadisticas.when(
              data: (stats) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStepsCard(context, stats),
                  const SizedBox(height: 24),
                ],
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),

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

            // Nutrición - Resumen y gráfico semanal
            Text(
              'Nutrición',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildNutritionSummary(context, caloriasHoy, macrosHoy),
            const SizedBox(height: 16),
            _buildNutritionWeeklyChart(context, caloriasSemanales),
            const SizedBox(height: 16),
            _buildUltimosAlimentos(context, ultimosAlimentos),
            const SizedBox(height: 24),

            // Hidratación
            _buildHidratacionSection(
              context,
              ref,
              aguaTotalHoy,
              aguaProgreso,
              aguaSemanal,
            ),
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

            const SizedBox(height: 24),
            Text(
              '¿Cómo me siento? (últimos 7 días)',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildFeelingChart(context, sensacion7d),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionSummary(
    BuildContext context,
    AsyncValue<double> caloriasHoy,
    AsyncValue<Map<String, double>> macrosHoy,
  ) {
    return Row(
      children: [
        Expanded(
          child: caloriasHoy.when(
            data: (kcal) => _buildMetricCard(
              context,
              'Calorías hoy',
              kcal.toStringAsFixed(0),
              Icons.local_fire_department,
              AppTheme.secondaryColor,
            ),
            loading: () => _buildMetricCard(
              context,
              'Calorías hoy',
              '-',
              Icons.local_fire_department,
              AppTheme.secondaryColor,
            ),
            error: (_, __) => _buildMetricCard(
              context,
              'Calorías hoy',
              '0',
              Icons.local_fire_department,
              AppTheme.secondaryColor,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: macrosHoy.when(
            data: (m) {
              final p = (m['proteinas'] ?? 0).toStringAsFixed(0);
              final c = (m['carbohidratos'] ?? 0).toStringAsFixed(0);
              final g = (m['grasas'] ?? 0).toStringAsFixed(0);
              return _buildMetricCard(
                context,
                'Macros hoy',
                'P$p C$c G$g',
                Icons.restaurant,
                AppTheme.primaryColor,
              );
            },
            loading: () => _buildMetricCard(
              context,
              'Macros hoy',
              '-',
              Icons.restaurant,
              AppTheme.primaryColor,
            ),
            error: (_, __) => _buildMetricCard(
              context,
              'Macros hoy',
              '0',
              Icons.restaurant,
              AppTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionWeeklyChart(
      BuildContext context, AsyncValue<Map<int, double>> caloriasSemanales) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calorías últimos 7 días',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: caloriasSemanales.when(
                data: (conteo) => BarChart(
                  BarChartData(
                    gridData: FlGridData(show: true),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const labels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
                            final idx = value.toInt();
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(labels[idx % 7]),
                            );
                          },
                        ),
                      ),
                    ),
                    barGroups: List.generate(7, (i) {
                      final y = (conteo[i] ?? 0).toDouble();
                      return BarChartGroupData(x: i, barRods: [
                        BarChartRodData(
                          toY: y,
                          width: 16,
                          gradient: const LinearGradient(
                            colors: [AppTheme.secondaryColor, AppTheme.primaryColor],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                        )
                      ]);
                    }),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUltimosAlimentos(
      BuildContext context, AsyncValue<List<dynamic>> ultimosAlimentos) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Últimos alimentos',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ultimosAlimentos.when(
              data: (registros) {
                if (registros.isEmpty) {
                  return Text('Sin registros recientes', style: TextStyle(color: Colors.grey.shade600));
                }
                return Column(
                  children: registros.take(5).map((r) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: AppTheme.secondaryColor.withOpacity(0.1),
                        child: const Icon(Icons.restaurant, color: AppTheme.secondaryColor),
                      ),
                      title: Text(r.nombre),
                      subtitle: Text('${r.cantidad.toStringAsFixed(0)} ${r.unidadMedida} • ${DateFormat('d/M, HH:mm').format(r.fecha)}'),
                      trailing: Text(
                        '${r.calorias.toStringAsFixed(0)} kcal',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
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
              color: Colors.white.withValues(alpha: 0.9),
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
    // No-op
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final availableWidth =
            maxWidth.isFinite ? maxWidth : MediaQuery.of(context).size.width;
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
          alignment: columns == 1 ? WrapAlignment.center : WrapAlignment.start,
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
            SizedBox(
              width: itemWidth,
              child: Consumer(builder: (context, ref, _) {
                final sensacion = ref.watch(sensacionHoyProvider);
                final value = sensacion.when(
                  data: (stats) {
                    final total = stats['total'] as int;
                    if (total == 0) return '-';
                    final avg = stats['average'] as double;
                    return avg.toStringAsFixed(1);
                  },
                  loading: () => '-',
                  error: (_, __) => '-',
                );
                return _buildMetricCard(
                  context,
                  'Ánimo Hoy',
                  value,
                  Icons.mood,
                  AppTheme.accentColor,
                );
              }),
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
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
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

  Widget _buildStepsCard(BuildContext context, PasosEstadisticas stats) {
    final diferencia = stats.pasosHoy - stats.promedioUltimos7;
    final esPositivo = diferencia >= 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PasosScreen()),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                AppTheme.secondaryColor,
                AppTheme.primaryColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.18),
                        ),
                        child: const Icon(Icons.directions_walk,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pasos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Toca para ver historial y registrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.chevron_right,
                      color: Colors.white.withValues(alpha: 0.7)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildStepMetric(
                      label: 'Promedio 7 días',
                      value: '${stats.promedioUltimos7}',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStepMetric(
                      label: 'Hoy',
                      value: '${stats.pasosHoy}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                esPositivo
                    ? '¡${diferencia.abs()} pasos sobre tu promedio semanal!'
                    : '${diferencia.abs()} pasos por debajo de tu promedio semanal',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepMetric({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyProgressChart(
      BuildContext context, AsyncValue<Map<int, int>> registrosSemanales) {
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
            maxY: conteo.values.isEmpty
                ? 10
                : (conteo.values.reduce((a, b) => a > b ? a : b) + 2)
                    .toDouble(),
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
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(6)),
                  ),
                ],
              );
            }),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
            child: Text('Error al cargar datos: $e',
                style: TextStyle(color: Colors.grey.shade600))),
      ),
    );
  }

  Widget _buildRegistrosHoy(
      BuildContext context, List registros, AsyncValue ejercicios) {
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
                  child: const Icon(Icons.fitness_center,
                      color: AppTheme.primaryColor),
                ),
                title: Text(
                    ejercicio?.nombre ?? 'Ejercicio #${registro.ejercicioId}'),
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
                child: const Icon(Icons.fitness_center,
                    color: AppTheme.primaryColor),
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
        final availableWidth =
            maxWidth.isFinite ? maxWidth : MediaQuery.of(context).size.width;
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

  Widget _buildFeelingChart(
      BuildContext context, AsyncValue<Map<String, dynamic>> sensacion7d) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: sensacion7d.when(
        data: (stats) {
          final counts = (stats['counts'] as Map<int, int>);
          final total = (stats['total'] as int);
          final average = (stats['average'] as double);
          if (total == 0) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sin datos de sensaciones en los últimos 7 días',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            );
          }

          final sections = [
            _pieSection(counts[5] ?? 0, AppTheme.accentColor, 'Con fuerza'),
            _pieSection(counts[3] ?? 0, AppTheme.warningColor, 'Poca fuerza'),
            _pieSection(counts[1] ?? 0, AppTheme.errorColor, 'Sin fuerza'),
          ].where((s) => s.value > 0).toList();

          return LayoutBuilder(builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 340;
            final radius = isNarrow
                ? (constraints.maxWidth * 0.35).clamp(50.0, 80.0)
                : 90.0;
            final centerSpace = isNarrow ? 24.0 : 36.0;

            final chart = SizedBox(
              height: radius * 2,
              width: radius * 2,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: centerSpace,
                  sections: sections,
                ),
              ),
            );

            final legend = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _legendItem(
                    AppTheme.accentColor, 'Con fuerza', counts[5] ?? 0, total),
                _legendItem(AppTheme.warningColor, 'Poca fuerza',
                    counts[3] ?? 0, total),
                _legendItem(
                    AppTheme.errorColor, 'Sin fuerza', counts[1] ?? 0, total),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.mood, color: AppTheme.primaryColor),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Promedio: ${average.toStringAsFixed(1)}  ·  ${interpretFeeling(average)}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: chart),
                  const SizedBox(height: 12),
                  legend,
                ],
              );
            }

            return Row(
              children: [
                chart,
                const SizedBox(width: 16),
                Expanded(child: legend),
              ],
            );
          });
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('Error: $e'),
      ),
    );
  }

  PieChartSectionData _pieSection(int value, Color color, String title) {
    final double v = value.toDouble();
    return PieChartSectionData(
      color: color,
      value: v,
      title: '',
      radius: 12 + (v > 0 ? 6 : 0),
      titleStyle: const TextStyle(fontSize: 0),
    );
  }

  Widget _legendItem(Color color, String label, int count, int total) {
    final pct = total == 0 ? 0 : ((count / total) * 100).round();
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade800),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '$pct%',
            style: TextStyle(color: Colors.grey.shade600),
          )
        ],
      ),
    );
  }

  String interpretFeeling(double avg) {
    if (avg >= 4.0) return 'Con fuerza';
    if (avg >= 2.0) return 'Poca fuerza';
    return 'Sin fuerza';
  }

  Widget _buildHidratacionSection(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<int> totalHoy,
    AsyncValue<double> progreso,
    AsyncValue<Map<int, int>> semanal,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hidratación',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AguaScreen()),
                );
              },
              child: const Text('Ver todo'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Card con progreso y estadísticas
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade50,
                Colors.cyan.shade50,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // Progreso de hoy
              Row(
                children: [
                  totalHoy.when(
                    data: (ml) {
                      const objetivo = 2000;
                      final progresoVal = progreso.maybeWhen(
                        data: (p) => p,
                        orElse: () => 0.0,
                      );
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.water_drop,
                                  color: Colors.blue.shade700,
                                  size: 28,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Hoy',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '$ml ml',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'de $objetivo ml',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Barra de progreso
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: progresoVal,
                                minHeight: 12,
                                backgroundColor: Colors.blue.shade100,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue.shade700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${(progresoVal * 100).toInt()}% completado',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    loading: () => const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (_, __) => const Expanded(
                      child: Text('Error al cargar datos'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 16),
              // Gráfico semanal
              Row(
                children: [
                  Icon(Icons.bar_chart, color: Colors.blue.shade700),
                  const SizedBox(width: 8),
                  Text(
                    'Últimos 7 días',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              semanal.when(
                data: (data) {
                  return SizedBox(
                    height: 120,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 3000,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const dias = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
                                final idx = value.toInt();
                                if (idx >= 0 && idx < dias.length) {
                                  return Text(
                                    dias[idx],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: List.generate(7, (i) {
                          final ml = data[i] ?? 0;
                          return BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: ml.toDouble(),
                                color: Colors.blue.shade400,
                                width: 16,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  );
                },
                loading: () => const SizedBox(
                  height: 120,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (_, __) => const SizedBox(
                  height: 120,
                  child: Center(child: Text('Error')),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
