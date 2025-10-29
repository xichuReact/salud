import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:salud_flutter/controllers/caminata_controller.dart';
import 'package:salud_flutter/controllers/ejercicio_controller.dart';
import 'package:salud_flutter/controllers/pasos_controller.dart';
import 'package:salud_flutter/controllers/registro_controller.dart';
import 'package:salud_flutter/models/ejercicio.dart';
import 'package:salud_flutter/models/registro_ejercicio.dart';
import 'package:salud_flutter/views/screens/dashboard_screen.dart';

void main() {
  testWidgets('Dashboard smoke test renders key sections', (tester) async {
    final fakePasosStats = PasosEstadisticas(
      ultimos7Dias: List.generate(
        7,
        (index) => PasosDia(
          fecha: DateTime.now().subtract(Duration(days: 6 - index)),
          pasos: 3000 + index * 250,
        ),
      ),
      promedioUltimos7: 3250,
      pasosHoy: 4100,
      promedioHistorico: 3100,
      promedioMesActual: 3300,
      promedioMesAnterior: 3000,
    );

    final overrides = <Override>[
      registrosHoyProvider
          .overrideWith((ref) => Stream.value(<RegistroEjercicio>[])),
      registrosSemanalesProvider.overrideWith((ref) async => {
            for (var i = 0; i < 7; i++) i: i,
          }),
      ejerciciosProvider.overrideWith((ref) => Stream.value(<Ejercicio>[])),
      sensacionUltimos7Provider.overrideWith((ref) async => {
            'counts': {1: 0, 3: 0, 5: 0},
            'average': 0.0,
            'total': 0,
          }),
      sensacionHoyProvider.overrideWith((ref) async => {
            'counts': {1: 0, 3: 0, 5: 0},
            'average': 0.0,
            'total': 0,
          }),
      estadisticasCaminatasProvider.overrideWith((ref) async => {
            'total': 0,
            'duracionTotal': 0,
          }),
      pasosEstadisticasProvider
          .overrideWith((ref) => AsyncValue.data(fakePasosStats)),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: const MaterialApp(
          home: DashboardScreen(),
        ),
      ),
    );

    // Permite que los Future/StreamProviders entreguen datos.
    await tester.pump();

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Progreso Semanal'), findsOneWidget);
    expect(find.text('Pasos'), findsWidgets);
  });
}
