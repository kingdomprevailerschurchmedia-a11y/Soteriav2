import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/logging/logger_service.dart';
import '../../../player/presentation/providers/progression_providers.dart';
import '../../../player/presentation/providers/rank_providers.dart';
import '../../../player/presentation/widgets/competitive_rank_card.dart';
import '../../../player/presentation/screens/competitive_rank_overview_screen.dart';
import '../providers/dashboard_providers.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/hero_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../../../player/presentation/widgets/season_header.dart';
import '../widgets/daily_goals_section.dart';
import '../widgets/announcement_section.dart';
import '../widgets/continue_playing_section.dart';
import '../widgets/recent_achievements_section.dart';
import '../widgets/top_scholars_section.dart';
import '../widgets/performance_section.dart';
import '../../../quiz/presentation/widgets/session_recovery_dialog.dart';
import '../../../../shared/widgets/soteria_page.dart';

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
    final progressionAsync = ref.watch(competitiveProgressionProvider);
    final player = state.player;

    if (kDebugMode) {
      LoggerService.d(
        'Building Dashboard: isLoading=${state.isLoading}, hasPlayer=${player != null}',
        feature: 'Dashboard',
      );
    }

    return SoteriaPage(
      isLoading: state.isLoading && player == null,
      error: state.error,
      onRetry: () => ref.read(dashboardProvider.notifier).refresh(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () async => ref.read(dashboardProvider.notifier).refresh(),
          color: SoteriaColors.primary,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 8.h)),

              // Header
              SliverToBoxAdapter(
                child: progressionAsync.when(
                  data: (progression) => DashboardHeader(
                    greeting: state.greeting,
                    playerName: player?.displayName ?? 'Scholar',
                    level: progression.currentLevel,
                    streak: player?.currentStreak ?? 0,
                    coins: player?.coins ?? 0,
                    profileCompletion: 1.0,
                    avatarUrl: player?.photoUrl,
                    isOnline: true,
                  ),
                  loading: () => DashboardHeader(
                    greeting: state.greeting,
                    playerName: player?.displayName ?? 'Scholar',
                    level: 1,
                    streak: 0,
                    coins: 0,
                    profileCompletion: 1.0,
                    isOnline: true,
                  ),
                  error: (err, _) => DashboardHeader(
                    greeting: 'Error loading level',
                    playerName: player?.displayName ?? 'Scholar',
                    level: 1,
                    streak: 0,
                    coins: 0,
                    profileCompletion: 1.0,
                    isOnline: true,
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 12.h)),

              // Hero Card
              SliverToBoxAdapter(
                child: progressionAsync.when(
                  data: (progression) => HeroCard(
                    level: progression.currentLevel,
                    xpInCurrentLevel: progression.currentXp,
                    xpThreshold:
                        progression.xpRequiredForNextLevel -
                        progression.xpRequiredForCurrentLevel,
                    streak: player?.currentStreak ?? 0,
                    rank: progression.currentRank,
                    rankPoints: progression.rankPoints,
                    progress: progression.xpProgress,
                    xpRemaining:
                        progression.xpRequiredForNextLevel -
                        (progression.xpRequiredForCurrentLevel +
                            progression.currentXp),
                    isDoubleXp: state.announcements.any(
                      (a) => a.toLowerCase().contains('double xp'),
                    ),
                  ),
                  loading: () => const HeroCardLoading(),
                  error: (_, __) => const HeroCardLoading(),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 12.h)),

              // Competitive Rank
              SliverToBoxAdapter(
                child: ref.watch(rankProgressProvider).when(
                      data: (progress) => CompetitiveRankCard(
                        rankProgress: progress,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                const CompetitiveRankOverviewScreen(),
                          ),
                        ),
                      ),
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 12.h)),

              // Season Status
              const SliverToBoxAdapter(child: SeasonHeader()),

              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              // Quick Actions
              const SliverToBoxAdapter(child: QuickActionsGrid()),

              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              // Daily Goals
              const SliverToBoxAdapter(child: DailyGoalsSection()),

              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              // Continue Playing
              const SliverToBoxAdapter(child: ContinuePlayingSection()),

              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              // Recent Achievements
              const SliverToBoxAdapter(child: RecentAchievementsSection()),

              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              // Top Scholars
              const SliverToBoxAdapter(child: TopScholarsSection()),

              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              // Performance
              const SliverToBoxAdapter(child: PerformanceSection()),

              // Announcements
              if (state.announcements.isNotEmpty)
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  sliver: SliverToBoxAdapter(
                    child: AnnouncementSection(
                      announcements: state.announcements,
                    ),
                  ),
                ),

              SliverToBoxAdapter(child: SizedBox(height: 10.h)),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroCardLoading extends StatelessWidget {
  const HeroCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.containerPadding(context),
      ),
      child: SoteriaCard(
        borderRadius: 24,
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: 180.h,
          child: const Center(
            child: CircularProgressIndicator(color: SoteriaColors.primary),
          ),
        ),
      ),
    );
  }
}
