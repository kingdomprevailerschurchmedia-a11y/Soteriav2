import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';

class SoteriaGradients {
  static const LinearGradient primaryBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      SoteriaColors.backgroundTopLeft,
      SoteriaColors.backgroundMid1,
      SoteriaColors.backgroundMid2,
      SoteriaColors.backgroundBottomRight,
    ],
  );

  static const LinearGradient competition = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      SoteriaColors.primary,
      SoteriaColors.secondary,
    ],
  );

  static const LinearGradient reward = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      SoteriaColors.gold,
      Color(0xFFB8860B), // Darker gold
    ],
  );

  static LinearGradient card = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withValues(alpha: 0.08),
      Colors.white.withValues(alpha: 0.02),
    ],
  );

  static LinearGradient button = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      SoteriaColors.primary,
      SoteriaColors.secondary,
    ],
  );
}
