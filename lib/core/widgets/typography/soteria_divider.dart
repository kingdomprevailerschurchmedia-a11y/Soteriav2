import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';

class SoteriaDivider extends StatelessWidget {
  const SoteriaDivider({
    super.key,
    this.indent,
    this.endIndent,
    this.color = SoteriaColors.border,
    this.thickness = 1.0,
    this.isGradient = false,
  });

  final double? indent;
  final double? endIndent;
  final Color color;
  final double thickness;
  final bool isGradient;

  @override
  Widget build(BuildContext context) {
    if (isGradient) {
      return Container(
        margin: EdgeInsets.only(
          left: indent ?? 0,
          right: endIndent ?? 0,
          top: SoteriaSpacing.sm,
          bottom: SoteriaSpacing.sm,
        ),
        height: thickness,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.0),
              color,
              color.withValues(alpha: 0.0),
            ],
          ),
        ),
      );
    }

    return Divider(
      height: SoteriaSpacing.lg,
      thickness: thickness,
      color: color,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
