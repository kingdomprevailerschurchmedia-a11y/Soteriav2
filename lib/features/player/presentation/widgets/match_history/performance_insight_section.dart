import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/features/player/domain/models/competitive_statistics.dart';
import 'package:soteria/features/player/presentation/providers/match_history_providers.dart';

class PerformanceInsightSection extends ConsumerWidget {
  const PerformanceInsightSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insightsAsync = ref.watch(matchHistoryInsightsProvider);

    return insightsAsync.when(
      data: (insights) {
        if (insights.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PERFORMANCE INSIGHTS',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.muted,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: SoteriaSpacing.md),
            ...insights
                .take(2)
                .map((insight) => _InsightCard(insight: insight)),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final PerformanceInsight insight;
  const _InsightCard({required this.insight});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            insight.isPositive
                ? Icons.trending_up_rounded
                : Icons.lightbulb_outline_rounded,
            color: insight.isPositive
                ? SoteriaColors.success
                : SoteriaColors.primary,
            size: 24.sp,
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight.title,
                  style: context.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SoteriaSpacing.xs),
                Text(
                  insight.description,
                  style: context.bodySmall.copyWith(color: Colors.white70),
                ),
                if (insight.recommendation != null) ...[
                  SizedBox(height: SoteriaSpacing.sm),
                  Text(
                    'TIP: ${insight.recommendation}',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.gold,
                      fontWeight: FontWeight.bold,
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
