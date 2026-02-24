import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppFonts {
  static TextStyle heading({final double fontSize = 20, final Color? color}) =>
      GoogleFonts.pressStart2p(fontSize: fontSize, color: color);

  static TextStyle body({final double fontSize = 16, final Color? color}) =>
      GoogleFonts.spaceGrotesk(fontSize: fontSize, color: color);
}
