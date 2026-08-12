import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';
import '../providers/statistics_providers.dart';
import '../widgets/statistics/win_rate_card.dart';
import '../widgets/statistics/recent_form_widget.dart';
import '../widgets/statistics/performance_trend_widget.dart';
import '../widgets/statistics/performance_insight_widget.dart';
import '../widgets/profile/statistic_card.dart';
import '../../domain/models/competitive_statistics.dart';

class CompetitiveStatisticsScreen extends ConsumerWidget {
  const CompetitiveStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(competitiveStatisticsProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('Performance Center'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: statsAsync.when(
        data: (stats) => _buildContent(context, stats),
        loading: () => _buildLoading(),
        error: (error, stack) => _buildError(context, ref, error),
      ),
    );
  }

  Widget _buildContent(BuildContext context, CompetitiveStatistics stats) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.containerPadding(context),
      ),
      children: [
        SizedBox(height: SoteriaSpacing.md),
        _buildSectionHeader(context, 'CAREER OVERVIEW'),
        SoteriaFadeIn(
          duration: SoteriaAnimations.normal,
          child: WinRateCard(
            winRate: stats.career.winRate,
            wins: stats.career.gamesWon,
            losses: stats.career.gamesLost,
          ),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        _buildSectionHeader(context, 'PERFORMANCE METRICS'),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2.2,
          mainAxisSpacing: SoteriaSpacing.md,
          crossAxisSpacing: SoteriaSpacing.md,
          children: [
            StatisticCard(
              label: 'Avg Score',
              value: stats.career.gamesPlayed > 0
                  ? (stats.career.totalQuestionsAnswered /
                            stats.career.gamesPlayed)
                        .toStringAsFixed(0)
                  : '0',
              icon: Icons.analytics_rounded,
            ),
            StatisticCard(
              label: 'Accuracy',
              value: '${(stats.career.accuracy * 100).toInt()}%',
              icon: Icons.track_changes_rounded,
              color: SoteriaColors.secondary,
            ),
            StatisticCard(
              label: 'Peak Pos',
              value: stats.career.peakPosition > 0
                  ? '#${stats.career.peakPosition}'
                  : 'N/A',
              icon: Icons.leaderboard_rounded,
              color: SoteriaColors.gold,
            ),
            StatisticCard(
              label: 'Seasons',
              value: stats.career.seasonsPlayed.toString(),
              icon: Icons.calendar_today_rounded,
              color: SoteriaColors.primary,
            ),
          ],
        ),
        if (stats.recentForm.isNotEmpty) ...[
          SizedBox(height: SoteriaSpacing.xl),
          SoteriaSlideUp(
            delay: const Duration(milliseconds: 100),
            child: RecentFormWidget(results: stats.recentForm),
          ),
        ],
        if (stats.trends.isNotEmpty) ...[
          SizedBox(height: SoteriaSpacing.xl),
          _buildSectionHeader(context, 'PERFORMANCE TRENDS'),
          ...stats.trends.map(
            (trend) => Padding(
              padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
              child: PerformanceTrendWidget(trend: trend),
            ),
          ),
        ],
        if (stats.insights.isNotEmpty) ...[
          SizedBox(height: SoteriaSpacing.xl),
          _buildSectionHeader(context, 'INTELLIGENT INSIGHTS'),
          ...stats.insights.map(
            (insight) => Padding(
              padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
              child: PerformanceInsightWidget(insight: insight),
            ),
          ),
        ],
        SizedBox(height: SoteriaSpacing.xxxl),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Text(
        title.toUpperCase(),
        style: context.labelSmall.copyWith(
          color: SoteriaColors.muted,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(color: SoteriaColors.primary),
    );
  }

  Widget _buildError(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SoteriaSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: SoteriaColors.error,
              size: 64.w,
            ),
            SizedBox(height: SoteriaSpacing.lg),
            Text('Statistics Unavailable', style: context.headlineSmall),
            SizedBox(height: SoteriaSpacing.sm),
            Text(
              'We couldn\'t load your performance data right now.',
              textAlign: TextAlign.center,
              style: context.bodyMedium,
            ),
            SizedBox(height: SoteriaSpacing.xl),
            ElevatedButton(
              onPressed: () => ref.refresh(competitiveStatisticsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
