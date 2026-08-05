import 'package:flutter/material.dart';

class SoteriaAnimations {
  static const Duration fastest = Duration(milliseconds: 150);
  static const Duration fast = Duration(milliseconds: 250);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 600);

  static const Curve emphasize = Curves.easeOutCubic;
  static const Curve decelerate = Curves.decelerate;
  static const Curve standard = Curves.easeInOutCubic;
  static const Curve bounce = Curves.elasticOut;
}
