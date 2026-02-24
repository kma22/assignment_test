import 'package:flutter/material.dart';

class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  const AppColorsTheme({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.onSurface,
    required this.highlight,
    required this.pipeActive,
    required this.pipeInactive,
    required this.starter,
    required this.terminatorActive,
    required this.terminatorInactive,
  });

  static const dark = AppColorsTheme(
    primary: Color(0xFF00E5FF),
    secondary: Color(0xFF76FF03),
    background: Color(0xFF0D1B2A),
    surface: Color(0xFF1B2838),
    onSurface: Color(0xFFE0E0E0),
    highlight: Color(0xFFFFFFFF),
    pipeActive: Color(0xFF00E5FF),
    pipeInactive: Color(0xFF3A4A5C),
    starter: Color(0xFF76FF03),
    terminatorActive: Color(0xFFFFD600),
    terminatorInactive: Color(0xFF5C5040),
  );

  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color onSurface;
  final Color highlight;
  final Color pipeActive;
  final Color pipeInactive;
  final Color starter;
  final Color terminatorActive;
  final Color terminatorInactive;

  @override
  AppColorsTheme copyWith({
    final Color? primary,
    final Color? secondary,
    final Color? background,
    final Color? surface,
    final Color? onSurface,
    final Color? highlight,
    final Color? pipeActive,
    final Color? pipeInactive,
    final Color? starter,
    final Color? terminatorActive,
    final Color? terminatorInactive,
  }) {
    return AppColorsTheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      highlight: highlight ?? this.highlight,
      pipeActive: pipeActive ?? this.pipeActive,
      pipeInactive: pipeInactive ?? this.pipeInactive,
      starter: starter ?? this.starter,
      terminatorActive: terminatorActive ?? this.terminatorActive,
      terminatorInactive: terminatorInactive ?? this.terminatorInactive,
    );
  }

  @override
  AppColorsTheme lerp(covariant final AppColorsTheme? other, final double t) {
    if (other == null) return this;
    return AppColorsTheme(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      highlight: Color.lerp(highlight, other.highlight, t)!,
      pipeActive: Color.lerp(pipeActive, other.pipeActive, t)!,
      pipeInactive: Color.lerp(pipeInactive, other.pipeInactive, t)!,
      starter: Color.lerp(starter, other.starter, t)!,
      terminatorActive: Color.lerp(terminatorActive, other.terminatorActive, t)!,
      terminatorInactive: Color.lerp(terminatorInactive, other.terminatorInactive, t)!,
    );
  }
}
