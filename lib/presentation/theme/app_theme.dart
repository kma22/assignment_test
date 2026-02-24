import 'package:flutter/material.dart';
import 'package:pipes/presentation/theme/app_colors.dart';
import 'package:pipes/presentation/theme/app_fonts.dart';

abstract final class AppTheme {
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.primary,
      elevation: 0,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        textStyle: AppFonts.heading(fontSize: 12),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: AppFonts.heading(fontSize: 20, color: AppColors.primary),
      headlineMedium: AppFonts.heading(fontSize: 16, color: AppColors.primary),
      bodyLarge: AppFonts.body(fontSize: 16, color: AppColors.onSurface),
    ),
  );
}
