import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/soteria_responsive.dart';

class SoteriaSpacing {
  static double get xs => 4.0.w;
  static double get sm => 8.0.w;
  static double get md => 16.0.w;
  static double get lg => 24.0.w;
  static double get xl => 32.0.w;
  static double get xxl => 48.0.w;
  static double get xxxl => 64.0.w;

  // Static constants for cases where ScreenUtil is not yet initialized or for specific non-scaling needs
  static const double xsStatic = 4.0;
  static const double smStatic = 8.0;
  static const double mdStatic = 16.0;
  static const double lgStatic = 24.0;
  static const double xlStatic = 32.0;
  static const double xxlStatic = 48.0;
  static const double xxxlStatic = 64.0;

  /// Returns a spacing value that adapts to the screen size.
  /// It reduces spacing on small phones and short screens to prevent unnecessary scrolling.
  static double adaptive(BuildContext context, double baseValue) {
    if (SoteriaResponsive.isSmallPhone(context) ||
        SoteriaResponsive.isShortScreen(context)) {
      return baseValue * 0.75;
    }
    if (SoteriaResponsive.isTablet(context)) {
      return baseValue * 1.2;
    }
    return baseValue;
  }

  // Adaptive presets
  static double sectionGap(BuildContext context) => adaptive(context, xl);
  static double itemGap(BuildContext context) => adaptive(context, md);
  static double containerPadding(BuildContext context) => adaptive(context, lg);
  static double smallGap(BuildContext context) => adaptive(context, sm);

  // Constant heights for performance-critical layouts (avoiding ScreenUtil in lists)
  static const gapXS = SizedBox(height: 4.0, width: 4.0);
  static const gapSM = SizedBox(height: 8.0, width: 8.0);
  static const gapMD = SizedBox(height: 16.0, width: 16.0);
  static const gapLG = SizedBox(height: 24.0, width: 24.0);
  static const gapXL = SizedBox(height: 32.0, width: 32.0);
}
