import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../../../player/providers/player_providers.dart';
import '../providers/dashboard_providers.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/hero_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/daily_goals_section.dart';
import '../widgets/dashboard_skeleton.dart';
import '../widgets/announcement_section.dart';
import '../widgets/continue_playing_section.dart';
import '../widgets/recent_achievements_section.dart';
import '../widgets/top_scholars_section.dart';
import '../widgets/performance_section.dart';
import '../../../quiz/presentation/widgets/session_recovery_dialog.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SessionRecoveryDialog.checkAndShow(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);
    final progression = ref.watch(playerProgressionProvider);
    final player = state.player;

    if (state.isLoading && player == null) {
      return const DashboardSkeleton();
    }

    return SoteriaPage(
      error: state.error,
      onRetry: () => ref.read(dashboardProvider.notifier).refresh(),
      child: Scaffold(
        backgroundColor: Colors.transparent, // SoteriaPage handles gradient/bg
        body: RefreshIndicator(
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
                  level: progression.level,
                  streak: player?.currentStreak ?? 0,
                  coins: player?.coins ?? 0,
                  profileCompletion: progression.profileCompletion,
                  avatarUrl: player?.photoUrl,
                  isOnline: true,
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

              // Hero Card
              SliverToBoxAdapter(
                child: HeroCard(
                  level: progression.level,
                  xpInCurrentLevel: progression.xpInCurrentLevel,
                  xpThreshold: progression.nextLevelXp,
                  coins: player?.coins ?? 0,
                  rank: player?.role ?? 'Student',
                  progress: progression.progressPercentage,
                  xpRemaining: progression.xpRemaining,
                  isDoubleXp: state.announcements.any(
                    (a) => a.toLowerCase().contains('double xp'),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xxl)),

              // Quick Actions
              const SliverToBoxAdapter(child: QuickActionsGrid()),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

              // Daily Goals
              const SliverToBoxAdapter(child: DailyGoalsSection()),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

              // Continue Playing
              const SliverToBoxAdapter(child: ContinuePlayingSection()),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

              // Recent Achievements
              const SliverToBoxAdapter(child: RecentAchievementsSection()),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

              // Top Scholars
              const SliverToBoxAdapter(child: TopScholarsSection()),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

              // Performance
              const SliverToBoxAdapter(child: PerformanceSection()),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.xl)),

              // Announcements
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
                sliver: SliverToBoxAdapter(
                  child: AnnouncementSection(
                    announcements: state.announcements,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: SoteriaSpacing.xxl * 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
