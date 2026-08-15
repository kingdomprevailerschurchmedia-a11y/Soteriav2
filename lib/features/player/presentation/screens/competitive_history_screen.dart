import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/design_system/animations/soteria_animation_widgets.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';
import '../providers/history_providers.dart';
import '../providers/progression_providers.dart';
import '../providers/season_providers.dart';
import '../widgets/season_result_card.dart';
import '../widgets/rank_badge.dart';
import '../../domain/models/season_result.dart';
import '../../domain/models/player_progression.dart';
import '../../domain/models/competitive_season.dart';

import '../widgets/season_result_details.dart';

class CompetitiveHistoryScreen extends ConsumerWidget {
  const CompetitiveHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(competitiveHistorySummaryProvider);
    final currentSeasonAsync = ref.watch(currentSeasonProvider);
    final progressionAsync = ref.watch(competitiveProgressionProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('Competitive Career'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: historyAsync.when(
        data: (history) => _buildContent(
          context,
          history,
          currentSeasonAsync.value,
          progressionAsync.value,
        ),
        loading: () => _buildLoading(),
        error: (error, stack) => _buildError(context, ref),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    CompetitiveHistory history,
    CompetitiveSeason? currentSeason,
    PlayerProgression? progression,
  ) {
    if (history.results.isEmpty && currentSeason == null) {
      return _buildEmptyState(context);
    }

    return ListView(
      cacheExtent: 500,
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      children: [
        if (currentSeason != null && progression != null) ...[
          _buildSectionHeader('Current Season'),
          SoteriaFadeIn(
            duration: SoteriaAnimations.normal,
            child: RepaintBoundary(child: _buildCurrentSeasonCard(context, currentSeason, progression)),
          ),
          SizedBox(height: SoteriaSpacing.xlStatic),
        ],
        if (history.results.isNotEmpty) ...[
          SoteriaSlideUp(
            duration: SoteriaAnimations.normal,
            child: RepaintBoundary(child: _buildCareerSummary(context, history)),
          ),
          SizedBox(height: SoteriaSpacing.xlStatic),
          if (history.latestResult != null) ...[
            _buildSectionHeader('Latest Completed'),
            SoteriaScaleIn(
              duration: SoteriaAnimations.normal,
              child: RepaintBoundary(child: _buildLatestResultCard(context, history.latestResult!)),
            ),
            SizedBox(height: SoteriaSpacing.xlStatic),
          ],
          _buildSectionHeader('Season History'),
          ...history.results.asMap().entries.map((entry) {
            final index = entry.key;
            final result = entry.value;
            return RepaintBoundary(
              child: SoteriaSlideUp(
                delay: Duration(milliseconds: 50 * index),
                child: SeasonResultCard(
                  result: result,
                  onTap: () => _showResultDetails(context, result),
                ),
              ),
            );
          }),
        ],
        const SizedBox(height: SoteriaSpacing.xxlStatic),
      ],
    );
  }

  Widget _buildCareerSummary(BuildContext context, CompetitiveHistory history) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryMetric('Seasons', history.results.length.toString()),
              _buildSummaryMetric(
                'Best Rank',
                history.bestResult?.finalTier ?? 'N/A',
                isGold: true,
              ),
              _buildSummaryMetric(
                'Peak Pos',
                history.bestResult != null
                    ? '#${history.bestResult!.finalPosition}'
                    : 'N/A',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryMetric(
    String label,
    String value, {
    bool isGold = false,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: SoteriaTypography.headlineSmall.copyWith(
            color: isGold ? SoteriaColors.gold : SoteriaColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: SoteriaTypography.labelSmall.copyWith(
            color: SoteriaColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentSeasonCard(
    BuildContext context,
    CompetitiveSeason season,
    PlayerProgression progression,
  ) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            SoteriaColors.secondary.withValues(alpha: 0.1),
            SoteriaColors.elevatedSurface,
          ],
        ),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(
          color: SoteriaColors.secondary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              RankBadge(
                rankName: progression.currentRank,
                tierId: progression.currentRankTier,
              ),
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(season.name, style: SoteriaTypography.titleLarge),
                    Text(
                      'Live Performance',
                      style: SoteriaTypography.bodySmall.copyWith(
                        color: SoteriaColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${progression.rankPoints} RP',
                style: SoteriaTypography.titleMedium.copyWith(
                  color: SoteriaColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Text(
        title.toUpperCase(),
        style: SoteriaTypography.labelSmall.copyWith(
          color: SoteriaColors.textSecondary,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildLatestResultCard(BuildContext context, SeasonResult result) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            SoteriaColors.primary.withValues(alpha: 0.2),
            SoteriaColors.elevatedSurface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(color: SoteriaColors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          RankBadge(rankName: result.finalTier, tierId: result.finalTier),
          SizedBox(width: SoteriaSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.seasonName,
                  style: SoteriaTypography.titleLarge.copyWith(fontSize: 20.sp),
                ),
                Text(
                  'Season ${result.seasonNumber}',
                  style: SoteriaTypography.bodyMedium.copyWith(
                    color: SoteriaColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '#${result.finalPosition}',
                style: SoteriaTypography.headlineSmall.copyWith(
                  color: SoteriaColors.gold,
                  fontSize: 24.sp,
                ),
              ),
              Text(
                '${result.finalRankPoints} RP',
                style: SoteriaTypography.bodyMedium.copyWith(
                  color: SoteriaColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history_toggle_off_rounded,
              size: 80.w,
              color: SoteriaColors.textSecondary.withValues(alpha: 0.2),
            ),
            SizedBox(height: SoteriaSpacing.lg),
            Text(
              'Your competitive journey starts here.',
              style: SoteriaTypography.titleLarge.copyWith(
                color: SoteriaColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              'Complete your first season to see your achievements here.',
              style: SoteriaTypography.bodyMedium.copyWith(
                color: SoteriaColors.textSecondary.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: SoteriaColors.error,
            size: 48,
          ),
          SizedBox(height: SoteriaSpacing.md),
          const Text('Failed to load history'),
          TextButton(
            onPressed: () => ref.refresh(competitiveHistorySummaryProvider),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _showResultDetails(BuildContext context, SeasonResult result) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => SeasonResultDetailsView(result: result),
    );
  }
}
