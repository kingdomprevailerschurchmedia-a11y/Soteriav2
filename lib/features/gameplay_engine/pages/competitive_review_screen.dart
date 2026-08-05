import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_badge.dart';
import 'package:soteria/core/design_system/components/soteria_page_wrapper.dart';
import '../models/competitive_review_item.dart';

class CompetitiveReviewScreen extends StatelessWidget {
  final List<CompetitiveReviewItem> items;

  const CompetitiveReviewScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SoteriaPageWrapper(
      title: 'Answer Review',
      showAppBar: true,
      body: ListView.separated(
        padding: EdgeInsets.all(SoteriaSpacing.xl),
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(height: SoteriaSpacing.lg),
        itemBuilder: (context, index) => _ReviewItemCard(item: items[index]),
      ),
    );
  }
}

class _ReviewItemCard extends StatelessWidget {
  final CompetitiveReviewItem item;

  const _ReviewItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SoteriaBadge(
                label: item.isCorrect ? 'CORRECT' : 'WRONG',
                variant: item.isCorrect
                    ? SoteriaBadgeVariant.success
                    : SoteriaBadgeVariant.error,
              ),
              Text(
                '${(item.timeTaken.inMilliseconds / 1000).toStringAsFixed(1)}s',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            item.questionText,
            style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          _AnswerRow(
            label: 'YOUR ANSWER',
            value: item.selectedAnswer,
            isCorrect: item.isCorrect,
            showIcon: true,
          ),
          if (!item.isCorrect) ...[
            SizedBox(height: SoteriaSpacing.sm),
            _AnswerRow(
              label: 'CORRECT ANSWER',
              value: item.correctAnswer,
              isCorrect: true,
              showIcon: false,
            ),
          ],
          SizedBox(height: SoteriaSpacing.lg),
          Container(
            padding: EdgeInsets.all(SoteriaSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EXPLANATION',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SoteriaSpacing.xs),
                Text(
                  item.explanation,
                  style: context.bodySmall.copyWith(
                    color: SoteriaColors.textSecondary,
                  ),
                ),
                if (item.reference != null) ...[
                  SizedBox(height: SoteriaSpacing.sm),
                  Text(
                    'Ref: ${item.reference}',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isCorrect;
  final bool showIcon;

  const _AnswerRow({
    required this.label,
    required this.value,
    required this.isCorrect,
    required this.showIcon,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCorrect ? SoteriaColors.success : SoteriaColors.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 10.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            if (showIcon) ...[
              Icon(
                isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: color,
                size: 16,
              ),
              SizedBox(width: 8.w),
            ],
            Expanded(
              child: Text(
                value,
                style: context.bodyMedium.copyWith(
                  color: showIcon ? color : SoteriaColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
