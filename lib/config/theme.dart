import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colores principales modernos
  static const Color primaryColor = Color(0xFF6366F1); // Indigo moderno
  static const Color secondaryColor = Color(0xFF8B5CF6); // Púrpura
  static const Color accentColor = Color(0xFF10B981); // Verde éxito
  static const Color warningColor = Color(0xFFF59E0B); // Amarillo
  static const Color errorColor = Color(0xFFEF4444); // Rojo

  // Colores para tipos de ejercicio
  static const Color fuerzaColor = Color(0xFFEF4444);
  static const Color cardioColor = Color(0xFF3B82F6);
  static const Color flexibilidadColor = Color(0xFF8B5CF6);
  static const Color otroColor = Color(0xFF6B7280);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      surface: Colors.white,
    ),
    textTheme: GoogleFonts.interTextTheme(),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey.shade400,
      selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
      unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      surface: const Color(0xFF1E1E1E),
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardTheme: CardThemeData(
      elevation: 0,
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade800),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2C2C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade800),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade800),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF1E1E1E),
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey.shade600,
      selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
      unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
    ),
  );

  // Método helper para obtener color por tipo de ejercicio
  static Color getColorForTipo(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'fuerza':
        return fuerzaColor;
      case 'cardio':
        return cardioColor;
      case 'flexibilidad':
        return flexibilidadColor;
      default:
        return otroColor;
    }
  }
}
