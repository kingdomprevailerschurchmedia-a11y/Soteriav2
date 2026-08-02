import 'package:flutter/material.dart';

class SoteriaElevation {
  static const List<BoxShadow> low = [
    BoxShadow(color: Color(0x1A000000), offset: Offset(0, 2), blurRadius: 4),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(color: Color(0x33000000), offset: Offset(0, 4), blurRadius: 8),
  ];

  static const List<BoxShadow> high = [
    BoxShadow(color: Color(0x4D000000), offset: Offset(0, 8), blurRadius: 16),
  ];
}
