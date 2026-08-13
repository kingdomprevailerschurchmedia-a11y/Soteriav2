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
    colors: [SoteriaColors.primary, SoteriaColors.secondary],
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

  static const LinearGradient settingsCardBorder = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white24,
      Colors.transparent,
      Colors.white10,
    ],
    stops: [0.0, 0.5, 1.0],
  );

  static const SweepGradient avatarRingGradient = SweepGradient(
    colors: [
      Color(0xFF7C4DFF),
      Color(0xFFFFD700),
      Color(0xFF00E5FF),
      Color(0xFF7C4DFF),
    ],
  );

  static LinearGradient logoutCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      SoteriaColors.error.withValues(alpha: 0.2),
      SoteriaColors.error.withValues(alpha: 0.05),
    ],
  );

  static const LinearGradient logoutBorder = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      SoteriaColors.error,
      Color(0xFFE91E63), // Accent pink for the logout gradient
      Colors.transparent,
    ],
    stops: [0.0, 0.5, 1.0],
  );

  static LinearGradient button = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [SoteriaColors.primary, SoteriaColors.secondary],
  );

  static const LinearGradient premiumButton = LinearGradient(
    colors: [Color(0xFF2E1A8A), Color(0xFF5B3FD9), Color(0xFF7C4DFF)],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
