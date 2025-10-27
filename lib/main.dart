import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'config/theme.dart';
import 'services/isar_service.dart';
import 'utils/seed_data.dart';
import 'package:flutter/foundation.dart';
import 'views/screens/dashboard_screen.dart';
import 'views/screens/rutinas_screen.dart';
import 'views/screens/cronometro_screen.dart';
import 'views/screens/calendario_screen.dart';
import 'views/screens/configuracion_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar localización en español
  await initializeDateFormatting('es_ES', null);
  
  // Inicializar base de datos Isar
  await IsarService().initialize();
  
  // Poblar datos de ejemplo opcionalmente (solo en entornos de desarrollo)
  const enableSeedData = bool.fromEnvironment('ENABLE_SAMPLE_DATA', defaultValue: false);
  if (!kReleaseMode && enableSeedData) {
    await SeedData.initialize();
  }
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salud Fitness',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    RutinasScreen(),
    CronometroScreen(),
    CalendarioScreen(),
    ConfiguracionScreen(),
  ];

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.dashboard_outlined),
      selectedIcon: Icon(Icons.dashboard),
      label: 'Inicio',
    ),
    NavigationDestination(
      icon: Icon(Icons.fitness_center_outlined),
      selectedIcon: Icon(Icons.fitness_center),
      label: 'Rutinas',
    ),
    NavigationDestination(
      icon: Icon(Icons.timer_outlined),
      selectedIcon: Icon(Icons.timer),
      label: 'Cronómetro',
    ),
    NavigationDestination(
      icon: Icon(Icons.calendar_today_outlined),
      selectedIcon: Icon(Icons.calendar_today),
      label: 'Calendario',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: 'Ejercicios',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: SafeArea(
        top: false,
        child: NavigationBarTheme(
          data: () {
            final width = MediaQuery.of(context).size.width;
            final isNarrow = width < 400;
            return NavigationBarThemeData(
              labelTextStyle: isNarrow
                  ? const MaterialStatePropertyAll(TextStyle(fontSize: 11, height: 1.1))
                  : null,
            );
          }(),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: _destinations,
            elevation: 0,
            height: MediaQuery.of(context).size.width < 400 ? 64 : 70,
            labelBehavior: MediaQuery.of(context).size.width < 400
                ? NavigationDestinationLabelBehavior.onlyShowSelected
                : NavigationDestinationLabelBehavior.alwaysShow,
          ),
        ),
      ),
    );
  }
}
