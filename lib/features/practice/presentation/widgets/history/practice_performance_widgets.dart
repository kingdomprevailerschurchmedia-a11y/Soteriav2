import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/features/practice/domain/models/practice_history.dart';

class PracticeSummaryHeader extends StatelessWidget {
  final PracticeHistory history;

  const PracticeSummaryHeader({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat(context, 'Sessions', '${history.totalSessions}'),
              _buildStat(context, 'Questions', '${history.totalQuestions}'),
              _buildStat(
                context, 
                'Accuracy', 
                '${(history.averageAccuracy * 100).toStringAsFixed(0)}%',
                color: SoteriaColors.gold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value, {Color? color}) {
    return Column(
      children: [
        Text(
          value,
          style: context.headlineSmall.copyWith(
            color: color ?? Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label.toUpperCase(),
          style: context.labelSmall.copyWith(
            color: Colors.white38,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class CategoryPerformanceList extends StatelessWidget {
  final PracticeHistory history;

  const CategoryPerformanceList({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final sortedCategories = history.categoryPerformance.values.toList()
      ..sort((a, b) => b.accuracy.compareTo(a.accuracy));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.md),
          child: Text(
            'CATEGORY PERFORMANCE',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        ...sortedCategories.map((p) => _buildCategoryRow(context, p)),
      ],
    );
  }

  Widget _buildCategoryRow(BuildContext context, dynamic p) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                p.categoryId.toUpperCase(),
                style: context.labelMedium.copyWith(color: Colors.white70),
              ),
              Text(
                '${(p.accuracy * 100).toStringAsFixed(0)}%',
                style: context.labelSmall.copyWith(
                  color: _getAccuracyColor(p.accuracy),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: p.accuracy,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(_getAccuracyColor(p.accuracy)),
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }

  Color _getAccuracyColor(double accuracy) {
    if (accuracy >= 0.8) return SoteriaColors.success;
    if (accuracy >= 0.6) return SoteriaColors.warning;
    return SoteriaColors.error;
  }
}

class PracticeTrendChart extends StatelessWidget {
  final List<PracticeTrendPoint> trends;

  const PracticeTrendChart({super.key, required this.trends});

  @override
  Widget build(BuildContext context) {
    if (trends.length < 2) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.md),
          child: Text(
            'ACCURACY TREND',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SoteriaCard(
          opacity: 0.05,
          child: SizedBox(
            height: 120.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: trends.take(10).toList().reversed.map((p) => _buildBar(context, p)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBar(BuildContext context, PracticeTrendPoint point) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20.w,
          height: (point.accuracy * 80.h).clamp(4.h, 80.h),
          decoration: BoxDecoration(
            color: _getTrendColor(point.accuracy),
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '${(point.accuracy * 100).toInt()}',
          style: TextStyle(color: Colors.white38, fontSize: 8.sp),
        ),
      ],
    );
  }

  Color _getTrendColor(double accuracy) {
    if (accuracy >= 0.8) return SoteriaColors.success.withValues(alpha: 0.6);
    if (accuracy >= 0.6) return SoteriaColors.warning.withValues(alpha: 0.6);
    return SoteriaColors.error.withValues(alpha: 0.6);
  }
}
