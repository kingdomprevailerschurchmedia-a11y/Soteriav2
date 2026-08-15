import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../domain/models/question_analytics.dart';

class QuestionAnalyticsCard extends StatelessWidget {
  final QuestionAnalytics analytics;

  const QuestionAnalyticsCard({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'QUESTION ID: ${analytics.questionId}',
                      style: context.labelSmall.copyWith(
                        color: Colors.white38,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'VERSION ${analytics.version}',
                      style: context.titleMedium.copyWith(
                        color: SoteriaColors.gold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _buildAccuracyBadge(context, analytics.accuracyRate),
            ],
          ),
          SizedBox(height: SoteriaSpacing.md),
          const Divider(color: Colors.white10),
          SizedBox(height: SoteriaSpacing.md),
          Row(
            children: [
              _buildStat(context, 'ATTEMPTS', '${analytics.totalAttempts}'),
              _buildStat(
                context,
                'AVG SPEED',
                '${(analytics.averageResponseTime.inMilliseconds / 1000).toStringAsFixed(1)}s',
              ),
              _buildStat(context, 'TIMEOUTS', '${analytics.timeoutCount}'),
            ],
          ),
          if (analytics.lastAttemptAt != null) ...[
            SizedBox(height: SoteriaSpacing.md),
            Text(
              'Last activity: ${analytics.lastAttemptAt!.toLocal()}',
              style: context.bodySmall.copyWith(color: Colors.white38),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAccuracyBadge(BuildContext context, double accuracy) {
    final color =
        accuracy >= 0.8
            ? SoteriaColors.success
            : (accuracy >= 0.5 ? SoteriaColors.warning : SoteriaColors.error);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        '${(accuracy * 100).toStringAsFixed(0)}%',
        style: context.labelMedium.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: Colors.white38,
              fontSize: 10.sp,
            ),
          ),
          Text(
            value,
            style: context.titleSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
