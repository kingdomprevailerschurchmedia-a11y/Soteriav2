import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import '../models/answer_review.dart';

class AnswerReviewCard extends StatelessWidget {
  final AnswerReview review;

  const AnswerReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      borderColor: review.isCorrect
          ? SoteriaColors.success.withValues(alpha: 0.1)
          : SoteriaColors.error.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                review.isCorrect
                    ? Icons.check_circle_rounded
                    : Icons.cancel_rounded,
                color: review.isCorrect
                    ? SoteriaColors.success
                    : SoteriaColors.error,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                review.isCorrect ? 'CORRECT' : 'INCORRECT',
                style: context.labelSmall.copyWith(
                  color: review.isCorrect
                      ? SoteriaColors.success
                      : SoteriaColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '${review.responseTime.inSeconds}s',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            review.question.text,
            style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          _ReviewOption(
            label: 'Your Answer',
            text: review.isSkipped ? 'Skipped' : _getSelectedOptionText(),
            status: review.isCorrect
                ? _OptionStatus.correct
                : _OptionStatus.wrong,
          ),
          if (!review.isCorrect)
            _ReviewOption(
              label: 'Correct Answer',
              text: _getCorrectOptionText(),
              status: _OptionStatus.correct,
            ),
          if (review.question.explanation != null) ...[
            SizedBox(height: SoteriaSpacing.md),
            Container(
              padding: EdgeInsets.all(SoteriaSpacing.md),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.02),
                borderRadius: SoteriaRadius.brMd,
              ),
              child: Text(
                review.question.explanation!,
                style: context.bodySmall.copyWith(
                  color: SoteriaColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getSelectedOptionText() {
    if (review.selectedOptionIds.isEmpty) return 'None';
    return review.question.options
        .firstWhere((o) => o.id == review.selectedOptionIds.first)
        .text;
  }

  String _getCorrectOptionText() {
    return review.question.options
        .firstWhere((o) => o.id == review.question.correctAnswers.first)
        .text;
  }
}

enum _OptionStatus { correct, wrong, neutral }

class _ReviewOption extends StatelessWidget {
  final String label;
  final String text;
  final _OptionStatus status;

  const _ReviewOption({
    required this.label,
    required this.text,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case _OptionStatus.correct:
        color = SoteriaColors.success;
        break;
      case _OptionStatus.wrong:
        color = SoteriaColors.error;
        break;
      case _OptionStatus.neutral:
        color = SoteriaColors.muted;
        break;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              fontSize: 9.sp,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            text,
            style: context.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
