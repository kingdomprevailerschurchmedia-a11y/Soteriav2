import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SoteriaRadius {
  static double get xs => 4.0.r;
  static double get sm => 8.0.r;
  static double get md => 12.0.r;
  static double get lg => 16.0.r;
  static double get xl => 24.0.r;
  static const double full = 999.0;

  static BorderRadius get brXs => BorderRadius.circular(xs);
  static BorderRadius get brSm => BorderRadius.circular(sm);
  static BorderRadius get brMd => BorderRadius.circular(md);
  static BorderRadius get brLg => BorderRadius.circular(lg);
  static BorderRadius get brXl => BorderRadius.circular(xl);
  static BorderRadius get brFull => BorderRadius.circular(full);
}
