import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/utils/responsive_layout_helper.dart';
import '../../../player/presentation/providers/progression_providers.dart';
import 'premium_statistic_card.dart';

class StatsGrid extends ConsumerWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(playerStatisticsProvider);
    final columns = ResponsiveLayoutHelper.getGridColumnCount(context);

    return Semantics(
      label: 'Player Performance Statistics',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PERFORMANCE',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.gold,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SoteriaSpacing.md),
            GridView.count(
              crossAxisCount: columns,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                PremiumStatisticCard(
                  title: 'Answered',
                  value: stats.totalQuestionsAnswered,
                  icon: Icons.quiz_rounded,
                  color: SoteriaColors.primary,
                ),
                PremiumStatisticCard(
                  title: 'Accuracy',
                  value: (stats.overallAccuracy * 100).toInt(),
                  unit: '%',
                  icon: Icons.track_changes_rounded,
                  color: SoteriaColors.success,
                  trend: 0.12,
                ),
                PremiumStatisticCard(
                  title: 'Study Time',
                  value: stats.totalStudyTime.inMinutes,
                  unit: 'm',
                  icon: Icons.timer_rounded,
                  color: SoteriaColors.secondary,
                ),
                PremiumStatisticCard(
                  title: 'Resp. Time',
                  value: (stats.averageResponseTimeMs / 1000).toInt(),
                  unit: 's',
                  icon: Icons.speed_rounded,
                  color: Colors.cyanAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
