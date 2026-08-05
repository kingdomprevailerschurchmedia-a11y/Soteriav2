import 'package:flutter/material.dart';

class SoteriaColors {
  // Background Gradient
  static const Color backgroundTopLeft = Color(0xFF17112F);
  static const Color backgroundMid1 = Color(0xFF120A2A);
  static const Color backgroundMid2 = Color(0xFF0D081E);
  static const Color backgroundBottomRight = Color(0xFF090514);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      backgroundTopLeft,
      backgroundMid1,
      backgroundMid2,
      backgroundBottomRight,
    ],
  );

  // Brand Colors
  static const Color background = Color(0xFF0B012A);
  static const Color primary = Color(0xFF5B3FD9);
  static const Color secondary = Color(0xFF7C4DFF);
  static const Color gold = Color(0xFFD8B24A);

  // Surface Colors
  static const Color surface = Color(0xFF17112F);
  static const Color elevatedSurface = Color(0xFF1E1638);
  static const Color navigation = Color(0xFF120A2A);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB9B6C9);
  static const Color muted = Color(0xFF77728A);
  static const Color hints = Color(0xFF5F5A73);

  // Border Colors
  static const Color border = Color(0x0FFFFFFF); // rgba(255,255,255,0.06)

  // Functional Colors
  static const Color error = Color(0xFFFF5252);
  static const Color success = Color(0xFF4CAF50);
}
