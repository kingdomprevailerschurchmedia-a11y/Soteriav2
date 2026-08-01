import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';

class SoteriaBorders {
  static const double none = 0.0;
  static const double thin = 0.5;
  static const double normal = 1.0;
  static const double thick = 2.0;

  static const Color defaultColor = SoteriaColors.border;

  static BorderSide get defaultSide => const BorderSide(
        color: defaultColor,
        width: normal,
      );

  static Border get glassBorder => Border.all(
        color: Colors.white.withValues(alpha: 0.1),
        width: thin,
      );
}
