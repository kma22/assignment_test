import 'dart:ui';

abstract final class AppColors {
  static const primary = Color(0xFF00E5FF);
  static const secondary = Color(0xFF76FF03);
  static const background = Color(0xFF0D1B2A);
  static const surface = Color(0xFF1B2838);
  static const onSurface = Color(0xFFE0E0E0);
  static const inactive = Color(0xFF3A4A5C);
  static const white = Color(0xFFFFFFFF);

  // Pipe colors
  static const pipeActive = primary;
  static const pipeInactive = inactive;
  static const starter = secondary;
  static const terminatorActive = Color(0xFFFFD600);
  static const terminatorInactive = Color(0xFF5C5040);
}
