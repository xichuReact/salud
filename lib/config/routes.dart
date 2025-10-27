import 'package:flutter/material.dart';
import '../views/screens/dashboard_screen.dart';
import '../views/screens/rutinas_screen.dart';
import '../views/screens/cronometro_screen.dart';
import '../views/screens/calendario_screen.dart';
import '../views/screens/configuracion_screen.dart';

class AppRoutes {
  static const String dashboard = '/';
  static const String rutinas = '/rutinas';
  static const String cronometro = '/cronometro';
  static const String calendario = '/calendario';
  static const String configuracion = '/configuracion';

  static Map<String, WidgetBuilder> routes = {
    dashboard: (context) => const DashboardScreen(),
    rutinas: (context) => const RutinasScreen(),
    cronometro: (context) => const CronometroScreen(),
    calendario: (context) => const CalendarioScreen(),
    configuracion: (context) => const ConfiguracionScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // Aquí puedes agregar rutas dinámicas si es necesario
    return null;
  }
}
