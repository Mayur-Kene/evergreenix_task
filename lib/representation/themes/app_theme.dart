import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextStyle textStyle({
    double size = 16,
    Color color = Colors.white,
    FontWeight weight = FontWeight.normal,
    TextDecoration strike = TextDecoration.none,
  }) {
    return GoogleFonts.poppins(
        fontSize: size, color: color, fontWeight: weight, decoration: strike);
  }
}
