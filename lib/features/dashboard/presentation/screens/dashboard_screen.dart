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
import '../../../player/presentation/providers/milestone_providers.dart';
import '../../../player/presentation/screens/competitive_rank_overview_screen.dart';
import '../providers/dashboard_providers.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/hero_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../../../player/presentation/widgets/season_header.dart';
import '../widgets/daily_goals_section.dart';
import '../widgets/milestone_section.dart';
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
      useSafeArea: false,
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
              SliverToBoxAdapter(
                child: SizedBox(height: MediaQuery.paddingOf(context).top + 8.h),
              ),

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
                  error: (err, st) => DashboardHeader(
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

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),

              // Unified Profile & Rank Hero Card
              SliverToBoxAdapter(
                child: progressionAsync.when(
                  data: (progression) => ref.watch(rankProgressProvider).when(
                        data: (rankProgress) => HeroCard(
                          level: progression.currentLevel,
                          xpInCurrentLevel: progression.currentXp,
                          xpThreshold: progression.xpRequiredForNextLevel -
                              progression.xpRequiredForCurrentLevel,
                          streak: player?.currentStreak ?? 0,
                          rankProgress: rankProgress,
                          xpProgress: progression.xpProgress,
                          xpRemaining: progression.xpRequiredForNextLevel -
                              (progression.xpRequiredForCurrentLevel +
                                  progression.currentXp),
                          isDoubleXp: state.announcements.any(
                            (a) => a.toLowerCase().contains('double xp'),
                          ),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  const CompetitiveRankOverviewScreen(),
                            ),
                          ),
                        ),
                        loading: () => const HeroCardLoading(),
                        error: (err, st) => const HeroCardLoading(),
                      ),
                  loading: () => const HeroCardLoading(),
                  error: (err, st) => const HeroCardLoading(),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),

              // Season Status
              const SliverToBoxAdapter(child: SeasonHeader()),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),

              // Milestone Section
              SliverToBoxAdapter(
                child: ref.watch(nextCompetitiveMilestoneProvider).when(
                      data: (next) => next != null
                          ? MilestoneSection(progress: next)
                          : const SizedBox.shrink(),
                      loading: () => const SizedBox.shrink(),
                      error: (err, st) => const SizedBox.shrink(),
                    ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),

              // Quick Actions
              const SliverToBoxAdapter(child: QuickActionsGrid()),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),

              // Daily Goals
              const SliverToBoxAdapter(child: DailyGoalsSection()),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),

              // Continue Playing
              const SliverToBoxAdapter(child: ContinuePlayingSection()),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),

              // Recent Achievements
              const SliverToBoxAdapter(child: RecentAchievementsSection()),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),

              // Top Scholars
              const SliverToBoxAdapter(child: TopScholarsSection()),

              SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),

              // Performance
              const SliverToBoxAdapter(child: PerformanceSection()),

              // Announcements
              if (state.announcements.isNotEmpty) ...[
                SliverToBoxAdapter(child: SizedBox(height: SoteriaSpacing.lg)),
                SliverToBoxAdapter(
                  child: AnnouncementSection(
                    announcements: state.announcements,
                  ),
                ),
              ],

              SliverToBoxAdapter(
                child: SizedBox(
                  height: 80.h + MediaQuery.paddingOf(context).bottom,
                ),
              ),
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
