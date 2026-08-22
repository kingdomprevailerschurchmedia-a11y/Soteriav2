import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/widgets/safe_gradient_scaffold.dart';
import '../../../auth/providers/auth_providers.dart';
import '../providers/season_providers.dart';
import '../providers/rank_providers.dart';
import '../providers/milestone_providers.dart';
import '../providers/reward_providers.dart';
import '../providers/leaderboard_providers.dart';
import '../widgets/competitive_rank_card.dart';
import '../widgets/milestone_card.dart';
import '../widgets/leaderboard_row.dart';
import '../widgets/season_header.dart';
import '../widgets/season/season_reward_card.dart';
import '../widgets/activity/competitive_activity_card.dart';
import '../providers/activity_providers.dart';
import '../../domain/models/competitive_season.dart';
import '../../domain/models/milestone.dart';
import '../../domain/models/season_reward_definition.dart';

class CompetitiveSeasonScreen extends ConsumerWidget {
  const CompetitiveSeasonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seasonAsync = ref.watch(currentSeasonProvider);

    return seasonAsync.when(
      data: (season) {
        if (season == null) return _buildNoActiveSeason(context);
        return _buildContent(context, ref, season);
      },
      loading: () => const SafeGradientScaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => SafeGradientScaffold(
        body: Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, CompetitiveSeason season) {
    final userId = ref.watch(authRepositoryProvider).currentUserId;
    final rankAsync = ref.watch(rankProgressProvider);
    final milestonesAsync = ref.watch(milestoneProgressProvider);
    final rewardsAsync = ref.watch(seasonRewardDefinitionsProvider(season.seasonId));
    final leaderboardAsync = ref.watch(leaderboardControllerProvider(season.seasonId));
    final activityAsync = userId != null ? ref.watch(activityFeedProvider(userId)) : null;

    return SafeGradientScaffold(
      appBar: AppBar(
        title: Text(season.name.toUpperCase()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(currentSeasonProvider);
          ref.invalidate(rankProgressProvider);
          ref.invalidate(milestoneProgressProvider);
          ref.invalidate(leaderboardControllerProvider(season.seasonId));
        },
        color: SoteriaColors.primary,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.md)),
            
            // Hero Section: Status and Countdown
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                child: const SeasonHeader(),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),

            // Rank Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(context, 'YOUR STANDING'),
                    SizedBox(height: SoteriaSpacing.sm),
                    rankAsync.when(
                      data: (rank) => CompetitiveRankCard(
                        rankProgress: rank,
                        onTap: () => GoRouter.of(context).push('/app/rank-overview'),
                      ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, st) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

            // Leaderboard Preview
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSectionHeader(context, 'TOP SCHOLARS'),
                        TextButton(
                          onPressed: () => GoRouter.of(context).push('/app/leaderboard'),
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                    leaderboardAsync.when(
                      data: (entries) => Column(
                        children: entries.take(3).map((e) => LeaderboardRow(entry: e)).toList(),
                      ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, st) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

            // Milestones Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(context, 'SEASON MILESTONES'),
                    SizedBox(height: SoteriaSpacing.md),
                    milestonesAsync.when(
                      data: (milestones) {
                        final seasonMilestones = milestones.where((m) => 
                          m.definition.type == MilestoneType.season || 
                          m.definition.metadata['seasonId'] == season.seasonId
                        ).toList();
                        
                        if (seasonMilestones.isEmpty) {
                          return Container(
                            padding: EdgeInsets.all(SoteriaSpacing.lg),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: const Center(child: Text('No milestones for this season.', style: TextStyle(color: Colors.white54))),
                          );
                        }

                        return Column(
                          children: seasonMilestones.take(3).map((m) => Padding(
                            padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
                            child: MilestoneCard(progress: m),
                          )).toList(),
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, st) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

            // Rewards Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(context, 'SEASON REWARDS'),
                    SizedBox(height: SoteriaSpacing.md),
                    rewardsAsync.when(
                      data: (definitions) {
                        if (definitions.isEmpty) return const Text('No rewards configured.', style: TextStyle(color: Colors.white54));
                        return Column(
                          children: definitions.map((def) => SeasonRewardCard(definition: def)).toList(),
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, st) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

            // Recent Activity Section
            if (activityAsync != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader(context, 'RECENT ACTIVITY'),
                      SizedBox(height: SoteriaSpacing.md),
                      activityAsync.when(
                        data: (events) {
                          final seasonEvents = events.where((e) => e.seasonId == season.seasonId).take(3).toList();
                          if (seasonEvents.isEmpty) return const Text('No activity this season yet.', style: TextStyle(color: Colors.white54));
                          return Column(
                            children: seasonEvents.map((e) => CompetitiveActivityCard(event: e)).toList(),
                          );
                        },
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (_, _) => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),

            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

            // Season History Link
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader(context, 'CAREER'),
                    SizedBox(height: SoteriaSpacing.md),
                    SoteriaCard(
                      onTap: () => GoRouter.of(context).push('/app/profile/history'),
                      child: Row(
                        children: [
                          const Icon(Icons.history_rounded, color: SoteriaColors.primary),
                          SizedBox(width: SoteriaSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Season History', style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                                Text('Review your performance in past seasons', style: context.labelSmall.copyWith(color: SoteriaColors.muted)),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, color: SoteriaColors.muted),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xxxl)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: context.labelSmall.copyWith(
        color: SoteriaColors.gold,
        letterSpacing: 2,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildNoActiveSeason(BuildContext context) {
    return const SafeGradientScaffold(
      body: Center(child: Text('No active season at the moment.')),
    );
  }
}

class _SeasonRewardItem extends StatelessWidget {
  final SeasonRewardDefinition definition;
  const _SeasonRewardItem({required this.definition});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(_getIcon(definition.type), color: SoteriaColors.primary),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(definition.name, style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                Text(definition.description, style: context.labelSmall.copyWith(color: SoteriaColors.muted)),
              ],
            ),
          ),
          Text('+${definition.amount}', style: context.titleMedium.copyWith(color: SoteriaColors.gold, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  IconData _getIcon(RewardType type) {
    switch (type) {
      case RewardType.xp: return Icons.bolt_rounded;
      case RewardType.coins: return Icons.monetization_on_rounded;
      case RewardType.badge: return Icons.verified_rounded;
      case RewardType.title: return Icons.title_rounded;
      default: return Icons.card_giftcard_rounded;
    }
  }
}
