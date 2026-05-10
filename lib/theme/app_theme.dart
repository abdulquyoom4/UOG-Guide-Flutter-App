import 'package:flutter/material.dart';

class AppColors {
  // Light mode colors
  static const Color primary = Color(0xFF1A3A6B);
  static const Color primaryLight = Color(0xFF2952A3);
  static const Color accent = Color(0xFF4ADE80);
  static const Color background = Color(0xFFF8F7F4);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color border = Color(0xFFE5E7EB);

  // Dark mode colors
  static const Color darkBackground = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);
  static const Color darkCard = Color(0xFF374151);
  static const Color darkBorder = Color(0xFF374151);
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);

  // Department colors (same for both modes)
  static const Color cs = Color(0xFF1E40AF);
  static const Color bba = Color(0xFF065F46);
  static const Color english = Color(0xFF7C2D92);
  static const Color ee = Color(0xFF92400E);
  static const Color math = Color(0xFF9F1239);
}

class AppTheme {
  static ThemeData get theme => ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      surface: AppColors.surface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      selectedLabelStyle:
      TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
      unselectedLabelStyle: TextStyle(fontSize: 11),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border, width: 0.5),
      ),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryLight,
      surface: AppColors.darkSurface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.darkTextSecondary,
      selectedLabelStyle:
      TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
      unselectedLabelStyle: TextStyle(fontSize: 11),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.darkBorder, width: 0.5),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(color: AppColors.darkTextPrimary),
      bodySmall: TextStyle(color: AppColors.darkTextSecondary),
      titleLarge: TextStyle(color: AppColors.darkTextPrimary),
      titleMedium: TextStyle(color: AppColors.darkTextPrimary),
      titleSmall: TextStyle(color: AppColors.darkTextSecondary),
    ),
  );
}