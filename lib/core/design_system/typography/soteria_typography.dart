import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';

class SoteriaTypography {
  static final bool _isTest = Platform.environment.containsKey('FLUTTER_TEST');

  static TextStyle get _baseStyle {
    if (_isTest) {
      return const TextStyle(color: SoteriaColors.textPrimary, fontFamily: 'Roboto');
    }
    return GoogleFonts.inter(color: SoteriaColors.textPrimary);
  }

  static final TextStyle _displayLarge = _baseStyle.copyWith(
    fontSize: 64.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -2.0,
  );

  static final TextStyle _displayMedium = _baseStyle.copyWith(
    fontSize: 48.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.0,
  );

  static final TextStyle _headline = _baseStyle.copyWith(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static final TextStyle _title = _baseStyle.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle _body = _baseStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: SoteriaColors.textSecondary,
  );

  static final TextStyle _label = _baseStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static final TextStyle _caption = _baseStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: SoteriaColors.muted,
  );

  static TextStyle get displayLarge => _displayLarge;
  static TextStyle get displayMedium => _displayMedium;
  static TextStyle get display => _displayMedium;
  static TextStyle get headline => _headline;
  static TextStyle get title => _title;
  static TextStyle get body => _body;
  static TextStyle get label => _label;
  static TextStyle get caption => _caption;
}

extension SoteriaTypographyExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  
  TextStyle get displayLarge => textTheme.displayLarge!;
  TextStyle get displayMedium => textTheme.displayMedium!;
  TextStyle get headlineMedium => textTheme.headlineMedium!;
  TextStyle get titleLarge => textTheme.titleLarge!;
  TextStyle get bodyLarge => textTheme.bodyLarge!;
  TextStyle get labelLarge => textTheme.labelLarge!;
  TextStyle get bodySmall => textTheme.bodySmall!;

  /// Clamps the text scale factor to prevent extreme accessibility settings from breaking layouts.
  double get safeTextScale => MediaQuery.textScalerOf(this).scale(1.0).clamp(0.8, 1.4);
}
