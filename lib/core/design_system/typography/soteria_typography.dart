import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';

class SoteriaTypography {
  static final bool _isTest = Platform.environment.containsKey('FLUTTER_TEST');

  static TextStyle get _baseStyle {
    if (_isTest) {
      return const TextStyle(
        color: SoteriaColors.textPrimary,
        fontFamily: 'Roboto',
      );
    }
    return GoogleFonts.inter(color: SoteriaColors.textPrimary);
  }

  static TextStyle get displayLarge => _baseStyle.copyWith(
    fontSize: 64.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -2.0,
  );

  static TextStyle get displayMedium => _baseStyle.copyWith(
    fontSize: 48.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.0,
  );

  static TextStyle get displaySmall =>
      _baseStyle.copyWith(fontSize: 36.sp, fontWeight: FontWeight.w800);

  static TextStyle get headlineLarge => _baseStyle.copyWith(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static TextStyle get headlineMedium =>
      _baseStyle.copyWith(fontSize: 28.sp, fontWeight: FontWeight.w700);

  static TextStyle get headlineSmall =>
      _baseStyle.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700);

  static TextStyle get titleLarge =>
      _baseStyle.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600);

  static TextStyle get titleMedium =>
      _baseStyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600);

  static TextStyle get titleSmall =>
      _baseStyle.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600);

  static TextStyle get bodyLarge => _baseStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: SoteriaColors.textSecondary,
  );

  static TextStyle get bodyMedium => _baseStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: SoteriaColors.textSecondary,
  );

  static TextStyle get bodySmall => _baseStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: SoteriaColors.muted,
  );

  static TextStyle get labelLarge => _baseStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => _baseStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => _baseStyle.copyWith(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // Legacy aliases
  static TextStyle get display => displayMedium;
  static TextStyle get headline => headlineLarge;
  static TextStyle get title => titleLarge;
  static TextStyle get body => bodyLarge;
  static TextStyle get label => labelLarge;
  static TextStyle get caption => bodySmall;
}

extension SoteriaTypographyExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get displayLarge => textTheme.displayLarge!;
  TextStyle get displayMedium => textTheme.displayMedium!;
  TextStyle get displaySmall => textTheme.displaySmall!;
  TextStyle get headlineLarge => textTheme.headlineLarge!;
  TextStyle get headlineMedium => textTheme.headlineMedium!;
  TextStyle get headlineSmall => textTheme.headlineSmall!;
  TextStyle get titleLarge => textTheme.titleLarge!;
  TextStyle get titleMedium => textTheme.titleMedium!;
  TextStyle get titleSmall => textTheme.titleSmall!;
  TextStyle get bodyLarge => textTheme.bodyLarge!;
  TextStyle get bodyMedium => textTheme.bodyMedium!;
  TextStyle get bodySmall => textTheme.bodySmall!;
  TextStyle get labelLarge => textTheme.labelLarge!;
  TextStyle get labelMedium => textTheme.labelMedium ?? textTheme.labelLarge!;
  TextStyle get labelSmall => textTheme.labelSmall!;

  /// Clamps the text scale factor to prevent extreme accessibility settings from breaking layouts.
  double get safeTextScale =>
      MediaQuery.textScalerOf(this).scale(1.0).clamp(0.8, 1.4);
}
