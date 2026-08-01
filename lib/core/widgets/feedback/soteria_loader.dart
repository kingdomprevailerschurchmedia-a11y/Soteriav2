import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';

class SoteriaLoader extends StatelessWidget {
  const SoteriaLoader({
    super.key,
    this.size = 40,
    this.strokeWidth = 4,
    this.color = SoteriaColors.gold,
  });

  final double size;
  final double strokeWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
