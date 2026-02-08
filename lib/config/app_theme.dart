import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static bool isDark = true;

  // Theme-independent (same in both modes)
  static const Color accent = Color(0xFF00BCD4);
  static const Color accentLight = Color(0xFF4DD0E1);
  static const Color inProgressBadge = Color(0xFFFFA726);

  // Theme-dependent
  static Color get background =>
      isDark ? const Color(0xFF0a0a0a) : const Color(0xFFF5F5F5);
  static Color get surface =>
      isDark ? const Color(0xFF111111) : Colors.white;
  static Color get card =>
      isDark ? const Color(0xFF1a1a1a) : Colors.white;
  static Color get cardBorder =>
      isDark ? const Color(0xFF2a2a2a) : const Color(0xFFE0E0E0);
  static Color get textPrimary =>
      isDark ? Colors.white : const Color(0xFF1a1a1a);
  static Color get textSecondary =>
      isDark ? const Color(0xFFB0B0B0) : const Color(0xFF555555);
  static Color get textMuted =>
      isDark ? const Color(0xFF707070) : const Color(0xFF999999);
  static Color get navBackground =>
      isDark ? const Color(0xCC0a0a0a) : const Color(0xE6F5F5F5);
  static Color get divider =>
      isDark ? const Color(0xFF2a2a2a) : const Color(0xFFE0E0E0);
  static Color get tagBackground =>
      isDark ? const Color(0xFF1E3A3D) : const Color(0xFFE0F7FA);
}

class AppTheme {
  static TextTheme _buildTextTheme(Brightness brightness) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;
    final textPrimary =
        brightness == Brightness.dark ? Colors.white : const Color(0xFF1a1a1a);
    final textSecondary = brightness == Brightness.dark
        ? const Color(0xFFB0B0B0)
        : const Color(0xFF555555);

    return GoogleFonts.interTextTheme(base).copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        color: textPrimary,
        letterSpacing: -1.5,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        letterSpacing: -0.5,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textSecondary,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        height: 1.7,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        height: 1.6,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.accent,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0a0a0a),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.accentLight,
        surface: Color(0xFF111111),
      ),
      textTheme: _buildTextTheme(Brightness.dark),
      cardTheme: CardTheme(
        color: const Color(0xFF1a1a1a),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF2a2a2a), width: 1),
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.accent,
        size: 24,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        secondary: AppColors.accentLight,
        surface: Colors.white,
      ),
      textTheme: _buildTextTheme(Brightness.light),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.accent,
        size: 24,
      ),
      useMaterial3: true,
    );
  }
}
