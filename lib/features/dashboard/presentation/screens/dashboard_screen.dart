import 'dart:ui';
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
import '../../../../core/network/providers/connectivity_providers.dart';
import '../providers/dashboard_providers.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/hero_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../../../player/presentation/widgets/season_header.dart';
import '../widgets/daily_goals_section.dart';
import '../widgets/milestone_section.dart';
import '../widgets/daily_bonus_card.dart';
import '../widgets/announcement_section.dart';
import '../widgets/recent_achievements_section.dart';
import '../widgets/top_scholars_section.dart';
import '../widgets/performance_section.dart';
import '../../../player/presentation/widgets/presence/recent_opponents_section.dart';
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
    // Only rebuild if critical dashboard state changes
    final isLoading = ref.watch(dashboardProvider.select((s) => s.isLoading));
    final error = ref.watch(dashboardProvider.select((s) => s.error));
    final hasPlayer = ref.watch(dashboardProvider.select((s) => s.player != null));
    final announcementsCount = ref.watch(dashboardProvider.select((s) => s.announcements.length));

    if (kDebugMode) {
      LoggerService.d(
        'Building Dashboard: isLoading=$isLoading, hasPlayer=$hasPlayer',
        feature: 'Dashboard',
      );
    }

    return SoteriaPage(
      isLoading: isLoading && !hasPlayer,
      error: error,
      onRetry: () => ref.read(dashboardProvider.notifier).refresh(),
      useSafeArea: false,
      showBackground: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () async => ref.read(dashboardProvider.notifier).refresh(),
          color: SoteriaColors.primary,
          child: CustomScrollView(
                cacheExtent: 1000, // Pre-render some area to reduce jank during scroll
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height: MediaQuery.paddingOf(context).top + 8.h),
                  ),

                  // Header
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: Consumer(
                        builder: (context, ref, _) {
                          final progressionAsync = ref.watch(competitiveProgressionProvider);
                          final player = ref.watch(dashboardProvider.select((s) => s.player));
                          final greeting = ref.watch(dashboardProvider.select((s) => s.greeting));
                          final isOnline = ref.watch(isOnlineProvider);
                          
                          return progressionAsync.when(
                            data: (progression) => DashboardHeader(
                              greeting: greeting,
                              playerName: player?.displayName ?? 'Scholar',
                              level: progression.currentLevel,
                              streak: player?.currentStreak ?? 0,
                              coins: player?.coins ?? 0,
                              profileCompletion: 1.0,
                              avatarUrl: player?.photoUrl,
                              isOnline: isOnline,
                            ),
                            loading: () => DashboardHeader(
                              greeting: greeting,
                              playerName: player?.displayName ?? 'Scholar',
                              level: 1, // Fallback, could be improved with a secondary level provider
                              streak: player?.currentStreak ?? 0,
                              coins: player?.coins ?? 0,
                              profileCompletion: 1.0,
                              isOnline: isOnline,
                            ),
                            error: (err, st) => DashboardHeader(
                              greeting: 'Error loading level',
                              playerName: player?.displayName ?? 'Scholar',
                              level: 1,
                              streak: player?.currentStreak ?? 0,
                              coins: player?.coins ?? 0,
                              profileCompletion: 1.0,
                              isOnline: isOnline,
                            ),
                          );
                        }
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: 40.h)),

                  // Unified Profile & Rank Hero Card
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: Consumer(
                        builder: (context, ref, _) {
                          final progressionAsync = ref.watch(competitiveProgressionProvider);
                          final rankProgressAsync = ref.watch(rankProgressProvider);
                          final player = ref.watch(dashboardProvider.select((s) => s.player));
                          final hasDoubleXp = ref.watch(dashboardProvider.select((s) => 
                            s.announcements.any((a) => a.toLowerCase().contains('double xp'))
                          ));

                          return progressionAsync.when(
                            data: (progression) => rankProgressAsync.when(
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
                                isDoubleXp: hasDoubleXp,
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
                          );
                        }
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SoteriaSpacing.gapLG),

                  // Season Status
                  const SliverToBoxAdapter(child: RepaintBoundary(child: SeasonHeader())),

                  const SliverToBoxAdapter(child: SoteriaSpacing.gapLG),

                  // Daily Bonus
                  const SliverToBoxAdapter(
                    child: RepaintBoundary(child: DailyBonusCard()),
                  ),

                  const SliverToBoxAdapter(child: SoteriaSpacing.gapLG),

                  // Milestone Section
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: Consumer(
                        builder: (context, ref, _) {
                          return ref.watch(nextCompetitiveMilestoneProvider).when(
                            data: (next) => next != null
                                ? MilestoneSection(progress: next)
                                : const SizedBox.shrink(),
                            loading: () => const SizedBox.shrink(),
                            error: (err, st) => const SizedBox.shrink(),
                          );
                        }
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SoteriaSpacing.gapLG),

                  // Quick Actions
                  const SliverToBoxAdapter(child: RepaintBoundary(child: QuickActionsGrid())),

                  const SliverToBoxAdapter(child: SoteriaSpacing.gapLG),

                  // Daily Goals
                  const SliverToBoxAdapter(child: RepaintBoundary(child: DailyGoalsSection())),

                  const SliverToBoxAdapter(child: SoteriaSpacing.gapLG),

                  // Recent Achievements
                  const SliverToBoxAdapter(child: RepaintBoundary(child: RecentAchievementsSection())),

                  const SliverToBoxAdapter(child: SoteriaSpacing.gapLG),

                  // Top Scholars
                  const SliverToBoxAdapter(child: RepaintBoundary(child: TopScholarsSection())),

                  const SliverToBoxAdapter(child: SoteriaSpacing.gapLG),

                  // Recent Opponents
                  const SliverToBoxAdapter(child: RepaintBoundary(child: RecentOpponentsSection())),

                  const SliverToBoxAdapter(child: SoteriaSpacing.gapLG),

                  // Performance
                  const SliverToBoxAdapter(child: RepaintBoundary(child: PerformanceSection())),

                  // Announcements
                  if (announcementsCount > 0) ...[
                    const SliverToBoxAdapter(child: SoteriaSpacing.gapLG),
                    SliverToBoxAdapter(
                      child: Consumer(
                        builder: (context, ref, _) {
                          final announcements = ref.watch(dashboardProvider.select((s) => s.announcements));
                          return AnnouncementSection(
                            announcements: announcements,
                          );
                        }
                      ),
                    ),
                  ],

                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 40.h + MediaQuery.paddingOf(context).bottom,
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
