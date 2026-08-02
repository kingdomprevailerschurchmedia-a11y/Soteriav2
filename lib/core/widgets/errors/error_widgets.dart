import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';

class InlineErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const InlineErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: SoteriaColors.error.withValues(alpha: 0.05),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(color: SoteriaColors.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: SoteriaColors.error,
            size: 24.w,
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Text(
              message,
              style: SoteriaTypography.body.copyWith(
                color: SoteriaColors.error.withValues(alpha: 0.8),
                fontSize: 14.sp,
              ),
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(width: SoteriaSpacing.sm),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'RETRY',
                style: SoteriaTypography.label.copyWith(
                  color: SoteriaColors.gold,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
