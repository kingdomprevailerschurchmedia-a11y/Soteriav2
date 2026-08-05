import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';

class QuestionExplanationView extends StatelessWidget {
  final Question question;
  final VoidCallback onContinue;

  const QuestionExplanationView({
    super.key,
    required this.question,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        color: SoteriaColors.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(color: SoteriaColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: SoteriaColors.primary,
                size: 20.sp,
              ),
              SizedBox(width: SoteriaSpacing.sm),
              Text(
                'EXPLANATION',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            question.explanation ??
                'No explanation provided for this question.',
            style: context.bodyMedium.copyWith(
              color: SoteriaColors.textPrimary,
            ),
          ),
          if (question.source.isNotEmpty) ...[
            SizedBox(height: SoteriaSpacing.md),
            Text(
              'Reference: ${question.source}',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          SizedBox(height: SoteriaSpacing.xl),
          ElevatedButton(
            onPressed: onContinue,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 56.h),
              backgroundColor: SoteriaColors.primary,
              foregroundColor: SoteriaColors.textPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Text(
              'CONTINUE',
              style: context.labelMedium.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
