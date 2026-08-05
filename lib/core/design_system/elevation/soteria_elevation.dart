import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';

class SoteriaElevation {
  static List<BoxShadow> get soft => [
    const BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: -2,
    ),
  ];

  static List<BoxShadow> get medium => [
    const BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: -4,
    ),
  ];

  static List<BoxShadow> get primaryGlow => [
    BoxShadow(
      color: SoteriaColors.primary.withValues(alpha: 0.25),
      offset: const Offset(0, 0),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> get goldGlow => [
    BoxShadow(
      color: SoteriaColors.gold.withValues(alpha: 0.25),
      offset: const Offset(0, 0),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];
}
