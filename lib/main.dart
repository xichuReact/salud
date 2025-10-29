import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'config/theme.dart';
import 'services/isar_service.dart';
import 'services/notification_service.dart';
import 'utils/seed_data.dart';
import 'package:flutter/foundation.dart';
import 'views/screens/dashboard_screen.dart';
import 'views/screens/rutinas_screen.dart';
import 'views/screens/cronometro_screen.dart';
import 'views/screens/calendario_screen.dart';
import 'views/screens/configuracion_screen.dart';
import 'views/screens/nutricion_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar localización en español
  await initializeDateFormatting('es_ES', null);

  // Inicializar base de datos Isar
  await IsarService().initialize();

  // Inicializar servicio de notificaciones
  await NotificationService().initialize();

  // Poblar datos de ejemplo opcionalmente (solo en entornos de desarrollo)
  const enableSeedData =
      bool.fromEnvironment('ENABLE_SAMPLE_DATA', defaultValue: false);
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
    NutricionScreen(),
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
      label: 'Tiempo',
    ),
    NavigationDestination(
      icon: Icon(Icons.restaurant_outlined),
      selectedIcon: Icon(Icons.restaurant),
      label: 'Comida',
    ),
    NavigationDestination(
      icon: Icon(Icons.calendar_today_outlined),
      selectedIcon: Icon(Icons.calendar_today),
      label: 'Agenda',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: 'Config',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: SafeArea(
        top: false,
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              final width = MediaQuery.of(context).size.width;
              if (width < 380) {
                return const TextStyle(fontSize: 10, height: 1.2);
              } else if (width < 400) {
                return const TextStyle(fontSize: 11, height: 1.2);
              }
              return const TextStyle(fontSize: 12, height: 1.2);
            }),
          ),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: _destinations,
            elevation: 0,
            height: () {
              final width = MediaQuery.of(context).size.width;
              if (width < 360) return 60.0;
              if (width < 400) return 64.0;
              return 70.0;
            }(),
            labelBehavior: MediaQuery.of(context).size.width < 400
                ? NavigationDestinationLabelBehavior.onlyShowSelected
                : NavigationDestinationLabelBehavior.alwaysShow,
          ),
        ),
      ),
    );
  }
}
