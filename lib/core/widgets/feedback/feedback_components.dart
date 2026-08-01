import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';

enum FeedbackType { success, warning, error, info }

class SoteriaFeedback {
  static void showSnackbar(
    BuildContext context, {
    required String message,
    FeedbackType type = FeedbackType.info,
    Duration duration = const Duration(seconds: 4),
  }) {
    final color = _getColorForType(type);
    final icon = _getIconForType(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: duration,
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md, vertical: SoteriaSpacing.sm),
          decoration: BoxDecoration(
            color: SoteriaColors.elevatedSurface,
            borderRadius: SoteriaRadius.brMd,
            border: Border.all(color: color.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 20.w),
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: Text(
                  message,
                  style: SoteriaTypography.body.copyWith(
                    color: SoteriaColors.textPrimary,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Color _getColorForType(FeedbackType type) {
    switch (type) {
      case FeedbackType.success:
        return SoteriaColors.success;
      case FeedbackType.warning:
        return SoteriaColors.gold;
      case FeedbackType.error:
        return SoteriaColors.error;
      case FeedbackType.info:
        return SoteriaColors.primary;
    }
  }

  static IconData _getIconForType(FeedbackType type) {
    switch (type) {
      case FeedbackType.success:
        return Icons.check_circle_outline_rounded;
      case FeedbackType.warning:
        return Icons.warning_amber_rounded;
      case FeedbackType.error:
        return Icons.error_outline_rounded;
      case FeedbackType.info:
        return Icons.info_outline_rounded;
    }
  }
}
