import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../../core/design_system/components/soteria_back_button.dart';
import '../../../../core/design_system/animations/soteria_animation_widgets.dart';
import '../providers/competitive_profile_provider.dart';
import '../../../analytics/presentation/providers/analytics_providers.dart';
import '../widgets/career/season_trend_chart.dart';
import '../widgets/career/season_comparison_card.dart';
import '../widgets/career/category_performance_card.dart';
import '../widgets/personal_record_card.dart';
import '../widgets/profile/career_summary_card.dart';
import '../../domain/models/competitive_profile.dart';
import 'season_history_screen.dart';

class CompetitiveCareerScreen extends ConsumerWidget {
  const CompetitiveCareerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(competitiveProfileProvider);
    final analyticsAsync = ref.watch(personalPerformanceAnalyticsProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('Competitive Career'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 60,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Center(child: SoteriaBackButton()),
        ),
      ),
      body: profileAsync.when(
        data: (profile) => _buildContent(context, profile, analyticsAsync.value),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    CompetitiveProfile profile,
    dynamic analytics,
  ) {
    final summary = profile.careerSummary;
    if (summary == null) return const Center(child: Text('No career data available.'));

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.containerPadding(context),
      ),
      children: [
        SizedBox(height: SoteriaSpacing.md),
        SoteriaFadeIn(
          child: CareerSummaryCard(
            history: profile.history,
            identity: profile.identity,
          ),
        ),
        SizedBox(height: SoteriaSpacing.xl),
        _buildSectionHeader(context, 'RANK PROGRESSION'),
        if (profile.history.results.length >= 2) ...[
          Container(
            height: 200.h,
            padding: EdgeInsets.all(SoteriaSpacing.md),
            decoration: BoxDecoration(
              color: SoteriaColors.surface.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: SoteriaColors.border),
            ),
            child: SeasonTrendChart(results: profile.history.results),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          SeasonComparisonCard(
            current: profile.history.results[0],
            previous: profile.history.results[1],
          ),
        ] else
          _buildEmptyChartState(context),
        
        SizedBox(height: SoteriaSpacing.xl),
        _buildSectionHeader(context, 'PERSONAL RECORDS'),
        ...summary.careerRecords.take(3).map(
          (record) => PersonalRecordCard(record: record),
        ),
        
        if (analytics != null && analytics.categoryPerformance.isNotEmpty) ...[
          SizedBox(height: SoteriaSpacing.xl),
          CategoryPerformanceCard(performance: analytics.categoryPerformance),
        ],

        SizedBox(height: SoteriaSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionHeader(context, 'SEASON HISTORY'),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SeasonHistoryScreen()),
              ),
              child: const Text('View All'),
            ),
          ],
        ),
        ...profile.history.results.take(3).map(
          (result) => Padding(
            padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
            child: ListTile(
              tileColor: SoteriaColors.surface.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              leading: Text(
                'S${result.seasonNumber}',
                style: SoteriaTypography.titleMedium.copyWith(color: SoteriaColors.primary),
              ),
              title: Text(result.seasonName),
              subtitle: Text(result.finalTier),
              trailing: Text(
                '#${result.finalPosition}',
                style: SoteriaTypography.titleMedium.copyWith(color: SoteriaColors.gold),
              ),
            ),
          ),
        ),
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

  Widget _buildEmptyChartState(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.xl),
      decoration: BoxDecoration(
        color: SoteriaColors.surface.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: SoteriaColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Icon(Icons.show_chart, size: 48.w, color: SoteriaColors.muted.withValues(alpha: 0.5)),
          SizedBox(height: SoteriaSpacing.md),
          Text(
            'Complete more seasons to see your career progression chart.',
            textAlign: TextAlign.center,
            style: SoteriaTypography.bodyMedium.copyWith(color: SoteriaColors.muted),
          ),
        ],
      ),
    );
  }
}
