import 'package:flutter/material.dart';
import 'package:pipes/presentation/theme/app_colors_theme.dart';
import 'package:pipes/presentation/theme/app_fonts.dart';

abstract final class AppTheme {
  static ThemeData get dark {
    const colors = AppColorsTheme.dark;

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.surface,
        onSurface: colors.onSurface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.primary,
        elevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.background,
          textStyle: AppFonts.heading(fontSize: 12),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: AppFonts.heading(fontSize: 20, color: colors.primary),
        headlineMedium: AppFonts.heading(fontSize: 16, color: colors.primary),
        bodyLarge: AppFonts.body(fontSize: 16, color: colors.onSurface),
      ),
      extensions: const [colors],
    );
  }
}
