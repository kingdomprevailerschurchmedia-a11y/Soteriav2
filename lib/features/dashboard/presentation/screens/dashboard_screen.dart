import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../providers/dashboard_providers.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/hero_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/stats_grid.dart';
import '../widgets/daily_challenge_card.dart';
import '../widgets/dashboard_skeleton.dart';
import '../widgets/announcement_card.dart';
import '../widgets/achievement_carousel.dart';
import '../widgets/leaderboard_preview.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);

    if (state.isLoading && state.player == null) {
      return const DashboardSkeleton();
    }

    final player = state.player;

    return RefreshIndicator(
      onRefresh: () async => ref.read(dashboardProvider.notifier).refresh(),
      color: SoteriaColors.primary,
      backgroundColor: SoteriaColors.surface,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xxl)),

          // Header
          SliverToBoxAdapter(
            child: DashboardHeader(
              greeting: state.greeting,
              playerName: player?.displayName ?? 'Scholar',
              level: player?.level ?? 1,
              streak: player?.currentStreak ?? 0,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

          // Hero Card
          SliverToBoxAdapter(
            child: HeroCard(
              level: player?.level ?? 1,
              xp: player?.xp ?? 0,
              totalXpRequired: (player?.level ?? 1) * 1000,
              coins: player?.coins ?? 0,
              rank: player?.role ?? 'Student',
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xxl)),

          // Quick Actions
          const SliverToBoxAdapter(child: QuickActionsGrid()),

          SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

          // Daily Challenge
          if (state.dailyChallenge != null)
            SliverToBoxAdapter(
              child: DailyChallengeCard(
                title: state.dailyChallenge!.title,
                description: state.dailyChallenge!.description,
                xpReward: state.dailyChallenge!.xpReward,
                progress: state.dailyChallenge!.completionPercentage,
              ),
            ),

          SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

          // Announcements
          if (state.announcements.isNotEmpty)
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      AnnouncementCard(message: state.announcements[index]),
                  childCount: state.announcements.length,
                ),
              ),
            ),

          SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

          // Achievements
          const SliverToBoxAdapter(child: AchievementCarousel()),

          SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

          // Leaderboard
          const SliverToBoxAdapter(child: LeaderboardPreview()),

          SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

          // Stats
          SliverToBoxAdapter(
            child: StatsGrid(
              questionsAnswered: player?.totalQuestionsAnswered ?? 0,
              accuracy: player?.accuracy ?? 0.0,
              gamesPlayed: player?.gamesPlayed ?? 0,
              highestStreak: player?.highestStreak ?? 0,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xxl * 2)),
        ],
      ),
    );
  }
}
