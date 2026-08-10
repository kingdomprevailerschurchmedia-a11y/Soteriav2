import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/radius/soteria_radius.dart';
import '../../../domain/usecases/history/get_performance_summary_use_case.dart';
import '../../../domain/usecases/history/get_category_performance_use_case.dart';

class PerformanceSummarySection extends StatelessWidget {
  const PerformanceSummarySection({super.key, required this.summary});

  final PerformanceSummary summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OVERALL PERFORMANCE',
          style: context.labelMedium.copyWith(
            color: Colors.white70,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SoteriaSpacing.lg),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: SoteriaSpacing.md,
          crossAxisSpacing: SoteriaSpacing.md,
          childAspectRatio: 1.8,
          children: [
            _SummaryStatCard(
              label: 'Total Quizzes',
              value: summary.totalQuizzes.toString(),
              icon: Icons.quiz_rounded,
              color: SoteriaColors.primary,
            ),
            _SummaryStatCard(
              label: 'Avg Accuracy',
              value: '${(summary.averageAccuracy * 100).round()}%',
              icon: Icons.track_changes_rounded,
              color: SoteriaColors.secondary,
            ),
            _SummaryStatCard(
              label: 'Best Score',
              value: summary.bestScore.toString(),
              icon: Icons.emoji_events_rounded,
              color: SoteriaColors.gold,
            ),
            _SummaryStatCard(
              label: 'Total XP',
              value: summary.totalXp.toString(),
              icon: Icons.bolt_rounded,
              color: SoteriaColors.primary,
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryStatCard extends StatelessWidget {
  const _SummaryStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(SoteriaRadius.lg),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20.sp),
          const Spacer(),
          Text(
            value,
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: context.labelSmall.copyWith(color: Colors.white38),
          ),
        ],
      ),
    );
  }
}

class CategoryPerformanceList extends StatelessWidget {
  const CategoryPerformanceList({super.key, required this.performances});

  final List<CategoryPerformance> performances;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STRENGTHS BY CATEGORY',
          style: context.labelMedium.copyWith(
            color: Colors.white70,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SoteriaSpacing.lg),
        ...performances
            .take(5)
            .map((p) => _CategoryPerformanceRow(performance: p)),
      ],
    );
  }
}

class _CategoryPerformanceRow extends StatelessWidget {
  const _CategoryPerformanceRow({required this.performance});
  final CategoryPerformance performance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                performance.category,
                style: context.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${(performance.averageAccuracy * 100).round()}%',
                style: context.bodyMedium.copyWith(
                  color: _getColor(performance.averageAccuracy),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: performance.averageAccuracy,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation(
                _getColor(performance.averageAccuracy),
              ),
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(double accuracy) {
    if (accuracy >= 0.85) return SoteriaColors.success;
    if (accuracy >= 0.70) return SoteriaColors.warning;
    return SoteriaColors.error;
  }
}
