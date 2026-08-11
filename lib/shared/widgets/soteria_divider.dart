import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/design_system/colors/soteria_colors.dart';
import '../../core/design_system/typography/soteria_typography.dart';

class SoteriaDivider extends StatelessWidget {
  const SoteriaDivider({super.key, this.text = 'or', this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Colors.white.withValues(alpha: 0.1);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: effectiveColor, thickness: 0.5)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              text,
              style: context.labelSmall.copyWith(
                color: Colors.white.withValues(alpha: 0.4),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(child: Divider(color: effectiveColor, thickness: 0.5)),
        ],
      ),
    );
  }
}
