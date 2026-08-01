import 'dart:ui';
import 'package:flutter/material.dart';

@immutable
class SoteriaThemeExtension extends ThemeExtension<SoteriaThemeExtension> {
  const SoteriaThemeExtension({
    required this.primaryGradient,
    required this.cardGradient,
    required this.buttonGradient,
    required this.glassBlur,
    required this.glassOpacity,
  });

  final LinearGradient primaryGradient;
  final LinearGradient cardGradient;
  final LinearGradient buttonGradient;
  final double glassBlur;
  final double glassOpacity;

  @override
  SoteriaThemeExtension copyWith({
    LinearGradient? primaryGradient,
    LinearGradient? cardGradient,
    LinearGradient? buttonGradient,
    double? glassBlur,
    double? glassOpacity,
  }) {
    return SoteriaThemeExtension(
      primaryGradient: primaryGradient ?? this.primaryGradient,
      cardGradient: cardGradient ?? this.cardGradient,
      buttonGradient: buttonGradient ?? this.buttonGradient,
      glassBlur: glassBlur ?? this.glassBlur,
      glassOpacity: glassOpacity ?? this.glassOpacity,
    );
  }

  @override
  SoteriaThemeExtension lerp(ThemeExtension<SoteriaThemeExtension>? other, double t) {
    if (other is! SoteriaThemeExtension) {
      return this;
    }
    return SoteriaThemeExtension(
      primaryGradient: LinearGradient.lerp(primaryGradient, other.primaryGradient, t)!,
      cardGradient: LinearGradient.lerp(cardGradient, other.cardGradient, t)!,
      buttonGradient: LinearGradient.lerp(buttonGradient, other.buttonGradient, t)!,
      glassBlur: lerpDouble(glassBlur, other.glassBlur, t)!,
      glassOpacity: lerpDouble(glassOpacity, other.glassOpacity, t)!,
    );
  }
}

extension SoteriaThemeExtensionX on BuildContext {
  SoteriaThemeExtension get soteriaTheme => Theme.of(this).extension<SoteriaThemeExtension>()!;
}
