import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/design_system/colors/soteria_colors.dart';
import '../../core/design_system/typography/soteria_typography.dart';

class SoteriaDivider extends StatelessWidget {
  const SoteriaDivider({super.key, this.text = 'OR', this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? SoteriaColors.muted.withValues(alpha: 0.3);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: effectiveColor, thickness: 1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              text,
              style: context.labelSmall.copyWith(
                color: SoteriaColors.muted,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Expanded(child: Divider(color: effectiveColor, thickness: 1)),
        ],
      ),
    );
  }
}
