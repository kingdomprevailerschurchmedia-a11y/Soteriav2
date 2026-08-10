import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../providers/analytics_providers.dart';
import '../widgets/metric_card.dart';
import '../widgets/insight_card.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/category_performance_item.dart';
import '../widgets/period_selector.dart';
import '../charts/soteria_line_chart.dart';
import '../charts/soteria_progress_chart.dart';
import '../../domain/models/performance_analytics.dart';
import '../../domain/models/analytics_enums.dart';

class PersonalPerformanceScreen extends ConsumerWidget {
  const PersonalPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(personalPerformanceAnalyticsProvider);
    final selectedPeriod = ref.watch(selectedTimePeriodProvider);

    return Scaffold(
      backgroundColor: SoteriaColors.background,
      body: Container(
        decoration: const BoxDecoration(gradient: SoteriaColors.backgroundGradient),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildAppBar(context, ref),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      PeriodSelector(
                        selectedPeriod: selectedPeriod,
                        onPeriodChanged: (period) => ref.read(selectedTimePeriodProvider.notifier).state = period,
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
              analyticsAsync.when(
                data: (analytics) => _buildAnalyticsContent(context, analytics),
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator(color: SoteriaColors.primary)),
                ),
                error: (error, stack) => SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Performance insights are temporarily unavailable.',
                      style: SoteriaTypography.bodyMedium.copyWith(color: SoteriaColors.error),
                    ),
                  ),
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(bottom: 100.h)), // Space for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      centerTitle: false,
      title: Text(
        'Your Performance',
        style: SoteriaTypography.headlineMedium.copyWith(color: SoteriaColors.textPrimary),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: SoteriaColors.textPrimary),
          onPressed: () => ref.refresh(personalPerformanceAnalyticsProvider),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }

  Widget _buildAnalyticsContent(BuildContext context, PersonalPerformanceAnalytics analytics) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          _buildOverviewSection(analytics),
          SizedBox(height: 32.h),
          _buildTrendSection(analytics),
          SizedBox(height: 32.h),
          _buildInsightsSection(analytics),
          SizedBox(height: 32.h),
          _buildCategorySection(analytics),
          SizedBox(height: 32.h),
          _buildDifficultySection(analytics),
          SizedBox(height: 32.h),
          _buildConsistencySection(analytics),
        ]),
      ),
    );
  }

  Widget _buildOverviewSection(PersonalPerformanceAnalytics analytics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: SoteriaTypography.titleMedium.copyWith(color: SoteriaColors.textPrimary),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: SoteriaProgressChart(
                value: analytics.averageAccuracy,
                label: '${(analytics.averageAccuracy * 100).toInt()}%',
                subLabel: 'Avg Accuracy',
                color: SoteriaColors.primary,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                children: [
                  MetricCard(
                    title: 'Total Quizzes',
                    value: '${analytics.totalQuizzes}',
                    icon: Icons.quiz,
                    color: SoteriaColors.secondary,
                  ),
                  SizedBox(height: 16.h),
                  MetricCard(
                    title: 'Total XP',
                    value: '${analytics.totalXp}',
                    icon: Icons.bolt,
                    color: SoteriaColors.xpColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                title: 'Best Score',
                value: '${analytics.bestScore}',
                icon: Icons.emoji_events,
                color: SoteriaColors.gold,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: MetricCard(
                title: 'Best Streak',
                value: '${analytics.bestStreak}',
                icon: Icons.local_fire_department,
                color: SoteriaColors.warning,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendSection(PersonalPerformanceAnalytics analytics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Accuracy Trend',
          style: SoteriaTypography.titleMedium.copyWith(color: SoteriaColors.textPrimary),
        ),
        SizedBox(height: 16.h),
        Container(
          height: 200.h,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: SoteriaColors.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: SoteriaColors.border),
          ),
          child: SoteriaLineChart(trend: analytics.accuracyTrend),
        ),
      ],
    );
  }

  Widget _buildInsightsSection(PersonalPerformanceAnalytics analytics) {
    if (analytics.insights.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Insights',
          style: SoteriaTypography.titleMedium.copyWith(color: SoteriaColors.textPrimary),
        ),
        SizedBox(height: 16.h),
        ...analytics.insights.map((insight) => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: InsightCard(insight: insight),
        )),
      ],
    );
  }

  Widget _buildCategorySection(PersonalPerformanceAnalytics analytics) {
    if (analytics.categoryPerformance.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category Performance',
          style: SoteriaTypography.titleMedium.copyWith(color: SoteriaColors.textPrimary),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: SoteriaColors.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: SoteriaColors.border),
          ),
          child: Column(
            children: analytics.categoryPerformance.take(5).map((cp) => 
              CategoryPerformanceItem(performance: cp)
            ).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDifficultySection(PersonalPerformanceAnalytics analytics) {
    if (analytics.difficultyPerformance.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Difficulty Breakdown',
          style: SoteriaTypography.titleMedium.copyWith(color: SoteriaColors.textPrimary),
        ),
        SizedBox(height: 16.h),
        Row(
          children: analytics.difficultyPerformance.where((d) => d.totalQuizzes > 0).map((dp) => 
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: MetricCard(
                  title: dp.difficulty.name.toUpperCase(),
                  value: '${(dp.accuracy * 100).toInt()}%',
                  subValue: '${dp.totalQuizzes} Quizzes',
                  color: _getDifficultyColor(dp.difficulty),
                ),
              ),
            )
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildConsistencySection(PersonalPerformanceAnalytics analytics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Consistency',
          style: SoteriaTypography.titleMedium.copyWith(color: SoteriaColors.textPrimary),
        ),
        SizedBox(height: 16.h),
        RecommendationCard(
          title: 'Your Performance is ${analytics.consistency.consistencyLevel}',
          description: analytics.consistency.consistencyScore > 0.7 
            ? 'You are maintaining a steady performance level. Consider trying harder challenges to push your limits.'
            : 'Your performance varies between sessions. Try focused practice on your weaker categories to stabilize your accuracy.',
          actionLabel: 'Practice Weakest Category',
          onAction: () {
            // Navigate to practice or filtered quiz
          },
        ),
      ],
    );
  }

  Color _getDifficultyColor(dynamic difficulty) {
    switch (difficulty.name) {
      case 'easy': return SoteriaColors.success;
      case 'medium': return SoteriaColors.info;
      case 'hard': return SoteriaColors.warning;
      case 'expert': return SoteriaColors.error;
      default: return SoteriaColors.primary;
    }
  }
}
