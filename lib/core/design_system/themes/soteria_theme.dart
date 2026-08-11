import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/gradients/soteria_gradients.dart';
import 'package:soteria/core/design_system/blur/soteria_blur.dart';
import 'package:soteria/core/design_system/opacity/soteria_opacity.dart';
import 'package:soteria/core/design_system/themes/soteria_theme_extension.dart';

class SoteriaTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: SoteriaColors.primary,
      scaffoldBackgroundColor: SoteriaColors.backgroundBottomRight,
      colorScheme: const ColorScheme.dark(
        primary: SoteriaColors.primary,
        secondary: SoteriaColors.secondary,
        surface: SoteriaColors.surface,
        onSurface: SoteriaColors.textPrimary,
        error: SoteriaColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: SoteriaTypography.displayLarge,
        displayMedium: SoteriaTypography.displayMedium,
        displaySmall: SoteriaTypography.displaySmall,
        headlineLarge: SoteriaTypography.headlineLarge,
        headlineMedium: SoteriaTypography.headlineMedium,
        headlineSmall: SoteriaTypography.headlineSmall,
        titleLarge: SoteriaTypography.titleLarge,
        titleMedium: SoteriaTypography.titleMedium,
        titleSmall: SoteriaTypography.titleSmall,
        bodyLarge: SoteriaTypography.bodyLarge,
        bodyMedium: SoteriaTypography.bodyMedium,
        bodySmall: SoteriaTypography.bodySmall,
        labelLarge: SoteriaTypography.labelLarge,
        labelMedium: SoteriaTypography.labelMedium,
        labelSmall: SoteriaTypography.labelSmall,
      ),
      extensions: [
        SoteriaThemeExtension(
          primaryGradient: SoteriaGradients.primaryBackground,
          cardGradient: SoteriaGradients.card,
          buttonGradient: SoteriaGradients.button,
          glassBlur: SoteriaBlur.medium,
          glassOpacity: SoteriaOpacity.low,
        ),
      ],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
