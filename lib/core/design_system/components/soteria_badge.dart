import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

enum SoteriaBadgeVariant { success, error, warning, info, gold, primary, muted }

class SoteriaBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final SoteriaBadgeVariant variant;
  final bool isOutline;

  const SoteriaBadge({
    super.key,
    required this.label,
    this.icon,
    this.variant = SoteriaBadgeVariant.info,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isOutline
            ? Colors.transparent
            : _getColor().withValues(alpha: 0.15),
        borderRadius: SoteriaRadius.brFull,
        border: Border.all(
          color: _getColor().withValues(alpha: isOutline ? 0.5 : 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12.sp, color: _getColor()),
            SizedBox(width: 4.w),
          ],
          Text(
            label.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: _getColor(),
              fontWeight: FontWeight.w900,
              fontSize: 10.sp,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    switch (variant) {
      case SoteriaBadgeVariant.success:
        return SoteriaColors.success;
      case SoteriaBadgeVariant.error:
        return SoteriaColors.error;
      case SoteriaBadgeVariant.warning:
        return SoteriaColors.warning;
      case SoteriaBadgeVariant.info:
        return SoteriaColors.info;
      case SoteriaBadgeVariant.gold:
        return SoteriaColors.gold;
      case SoteriaBadgeVariant.primary:
        return SoteriaColors.primary;
      case SoteriaBadgeVariant.muted:
        return SoteriaColors.muted;
    }
  }
}
