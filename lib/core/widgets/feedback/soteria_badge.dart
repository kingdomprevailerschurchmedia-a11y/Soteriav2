import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

enum SoteriaBadgeVariant { primary, gold, success, error, info }

class SoteriaBadge extends StatelessWidget {
  const SoteriaBadge({
    super.key,
    required this.label,
    this.variant = SoteriaBadgeVariant.primary,
    this.isSmall = false,
  });

  final String label;
  final SoteriaBadgeVariant variant;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 120.0.w,
      ), // Added constraint for safety
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? SoteriaSpacing.sm : SoteriaSpacing.md,
        vertical: isSmall ? 2.0 : 4.0,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor().withValues(alpha: 0.1),
        borderRadius: SoteriaRadius.brFull,
        border: Border.all(color: _getBackgroundColor().withValues(alpha: 0.2)),
      ),
      child: Text(
        label.toUpperCase(),
        style: context.bodySmall.copyWith(
          color: _getBackgroundColor(),
          fontWeight: FontWeight.w700,
          fontSize: (isSmall ? 10.0 : 12.0).sp, // Using ScreenUtil sp
          letterSpacing: 0.5,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (variant) {
      case SoteriaBadgeVariant.primary:
        return SoteriaColors.primary;
      case SoteriaBadgeVariant.gold:
        return SoteriaColors.gold;
      case SoteriaBadgeVariant.success:
        return SoteriaColors.success;
      case SoteriaBadgeVariant.error:
        return SoteriaColors.error;
      case SoteriaBadgeVariant.info:
        return SoteriaColors.secondary;
    }
  }
}
