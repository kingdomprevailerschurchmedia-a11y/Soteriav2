import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/core/design_system/animations/soteria_animation_widgets.dart';
import 'package:soteria/core/design_system/animations/soteria_animations.dart';
import 'package:soteria/features/player/domain/models/competitive_profile.dart';
import 'package:soteria/features/player/domain/models/season_result.dart';
import 'package:soteria/features/player/presentation/providers/competitive_profile_provider.dart';
import 'package:soteria/features/player/presentation/providers/rank_providers.dart';
import 'package:soteria/features/player/presentation/providers/goal_providers.dart';
import 'package:soteria/features/player/presentation/providers/streak_providers.dart';
import 'package:soteria/features/player/presentation/screens/competitive_goals_screen.dart';
import 'package:soteria/features/player/presentation/screens/milestones_screen.dart';
import 'package:soteria/features/player/presentation/screens/competitive_match_history_screen.dart';
import 'package:soteria/features/player/presentation/screens/competitive_rank_overview_screen.dart';
import 'package:soteria/features/player/presentation/widgets/competitive_rank_card.dart';
import 'package:soteria/features/player/presentation/widgets/profile/achievement_summary_section.dart';
import 'package:soteria/features/player/presentation/widgets/profile/match_history_summary_section.dart';
import 'package:soteria/features/player/presentation/widgets/profile/career_summary_card.dart';
import 'package:soteria/features/player/presentation/widgets/profile/competitive_profile_header.dart';
import 'package:soteria/features/player/presentation/widgets/profile/goal_summary_card.dart';
import 'package:soteria/features/player/presentation/widgets/streak/competitive_streak_card.dart';
import 'package:soteria/features/player/presentation/widgets/profile/reward_summary_section.dart';
import 'package:soteria/features/player/presentation/widgets/profile/statistic_card.dart';
import 'package:soteria/features/player/presentation/widgets/season_result_card.dart';
import 'package:soteria/features/player/presentation/widgets/season_result_details.dart';

class CompetitiveProfileScreen extends ConsumerWidget {
  const CompetitiveProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(competitiveProfileProvider);

    return SafeGradientScaffold(
      appBar: AppBar(
        title: const Text('Competitive Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: profileAsync.when(
        data: (profile) => _buildContent(context, ref, profile),
        loading: () => _buildLoading(),
        error: (error, stack) => _buildError(context, ref, error),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    CompetitiveProfile profile,
  ) {
    final goalsAsync = ref.watch(playerGoalsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(goalRefreshProvider.future);
      },
      color: SoteriaColors.primary,
      backgroundColor: SoteriaColors.background,
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: SoteriaSpacing.containerPadding(context),
        ),
        children: [
          SizedBox(height: SoteriaSpacing.md),
          SoteriaFadeIn(
            duration: SoteriaAnimations.normal,
            child: CompetitiveProfileHeader(
              identity: profile.identity,
              progression: profile.progression,
              globalPosition: profile.globalPosition,
            ),
          ),
          SizedBox(height: SoteriaSpacing.xl),
          ref.watch(rankProgressProvider).when(
                data: (rankProgress) => SoteriaSlideUp(
                  duration: SoteriaAnimations.normal,
                  child: CompetitiveRankCard(
                    rankProgress: rankProgress,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const CompetitiveRankOverviewScreen(),
                      ),
                    ),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, _) => const SizedBox.shrink(),
              ),
          SizedBox(height: SoteriaSpacing.xxl),
          goalsAsync.when(
            data: (goals) => SoteriaSlideUp(
              delay: const Duration(milliseconds: 50),
              child: GoalSummaryCard(
                activeGoals: goals,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CompetitiveGoalsScreen(),
                  ),
                ),
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          SizedBox(height: SoteriaSpacing.xxl),
          ref
              .watch(currentWinStreakProvider)
              .when(
                data: (streak) => streak != null
                    ? SoteriaSlideUp(
                        delay: const Duration(milliseconds: 75),
                        child: CompetitiveStreakCard(streak: streak),
                      )
                    : const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),
          SizedBox(height: SoteriaSpacing.xxl),
          SoteriaSlideUp(
            delay: const Duration(milliseconds: 100),
            child: CareerSummaryCard(
              history: profile.history,
              identity: profile.identity,
            ),
          ),
          SizedBox(height: SoteriaSpacing.xl),
          _buildSectionHeader(context, 'PERFORMANCE'),
          SoteriaFadeIn(
            delay: const Duration(milliseconds: 200),
            child: _buildStatsGrid(context, profile),
          ),
          SizedBox(height: SoteriaSpacing.xxl),
          SoteriaSlideUp(
            delay: const Duration(milliseconds: 300),
            child: RewardSummarySection(
              recentRewards: profile.recentRewards,
              totalRewards: profile.totalRewards,
            ),
          ),
          SizedBox(height: SoteriaSpacing.xxl),
          SoteriaSlideUp(
            delay: const Duration(milliseconds: 350),
            child: AchievementSummarySection(
              completed: profile.completedMilestones,
              total: profile.totalMilestones,
              onViewAll: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MilestonesScreen()),
              ),
            ),
          ),
          SizedBox(height: SoteriaSpacing.xxl),
          SoteriaSlideUp(
            delay: const Duration(milliseconds: 375),
            child: MatchHistorySummarySection(
              onViewAll: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const CompetitiveMatchHistoryScreen(),
                ),
              ),
            ),
          ),
          SizedBox(height: SoteriaSpacing.xxl),
          if (profile.history.results.isNotEmpty) ...[
            _buildSectionHeader(context, 'CAREER HISTORY'),
            ...profile.history.results.asMap().entries.map((entry) {
              final index = entry.key;
              final result = entry.value;
              return SoteriaSlideUp(
                delay: Duration(milliseconds: 400 + (50 * index)),
                child: Padding(
                  padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
                  child: SeasonResultCard(
                    result: result,
                    onTap: () => _showResultDetails(context, result),
                  ),
                ),
              );
            }),
          ],
          SizedBox(height: SoteriaSpacing.xxxl),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, CompetitiveProfile profile) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.2,
      mainAxisSpacing: SoteriaSpacing.md,
      crossAxisSpacing: SoteriaSpacing.md,
      children: [
        StatisticCard(
          label: 'Games',
          value: profile.identity.gamesPlayed.toString(),
          icon: Icons.sports_esports_rounded,
        ),
        StatisticCard(
          label: 'Wins',
          value: profile.identity.gamesWon.toString(),
          icon: Icons.emoji_events_rounded,
          color: SoteriaColors.success,
        ),
        StatisticCard(
          label: 'Questions',
          value: profile.identity.totalQuestionsAnswered.toString(),
          icon: Icons.quiz_rounded,
          color: SoteriaColors.secondary,
        ),
        StatisticCard(
          label: 'Accuracy',
          value: '${(profile.identity.accuracy * 100).toInt()}%',
          icon: Icons.track_changes_rounded,
          color: SoteriaColors.warning,
        ),
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
            Text('Profile Unavailable', style: context.headlineSmall),
            SizedBox(height: SoteriaSpacing.sm),
            Text(
              'We couldn\'t load your competitive profile right now.',
              textAlign: TextAlign.center,
              style: context.bodyMedium,
            ),
            SizedBox(height: SoteriaSpacing.xl),
            ElevatedButton(
              onPressed: () => ref.refresh(competitiveProfileProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
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
