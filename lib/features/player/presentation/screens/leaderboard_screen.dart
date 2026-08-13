import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_text.dart';
import 'package:soteria/core/identity/providers/identity_providers.dart';
import '../../domain/models/leaderboard_entry.dart';
import '../providers/leaderboard_providers.dart';
import '../widgets/leaderboard_podium.dart';
import '../widgets/leaderboard_row.dart';
import '../widgets/leaderboard/player_leaderboard_position_card.dart';
import '../widgets/leaderboard/leaderboard_neighborhood.dart';
import '../widgets/leaderboard/leaderboard_insight_card.dart';
import '../widgets/leaderboard/rank_progress_card.dart';
import '../widgets/season_header.dart';

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final leaderboardState = ref.watch(leaderboardControllerProvider);
    final playerEntryAsync = ref.watch(playerLeaderboardEntryProvider);
    final totalPlayersAsync = ref.watch(leaderboardTotalPlayersProvider);
    final neighborhoodAsync = ref.watch(leaderboardNeighborhoodProvider);
    final insightsAsync = ref.watch(leaderboardInsightsProvider);
    final movementHistoryAsync = ref.watch(rankMovementHistoryProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'LEADERBOARD',
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: SoteriaColors.primary,
          labelColor: SoteriaColors.textPrimary,
          unselectedLabelColor: SoteriaColors.muted,
          tabs: const [
            Tab(text: 'SEASON'),
            Tab(text: 'GLOBAL'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: leaderboardState.when(
              data: (entries) {
                if (entries.isEmpty) {
                  return _buildEmptyState();
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(leaderboardControllerProvider.notifier).refresh();
                    ref.invalidate(playerLeaderboardEntryProvider);
                    ref.invalidate(leaderboardTotalPlayersProvider);
                  },
                  color: SoteriaColors.primary,
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: SoteriaSpacing.md,
                      right: SoteriaSpacing.md,
                      bottom: 100.h,
                    ),
                    itemCount: entries.length + 6,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 16),
                          child: SeasonHeader(),
                        );
                      }
                      
                      if (index == 1) {
                        return playerEntryAsync.when(
                          data: (entry) {
                            if (entry == null) return const SizedBox.shrink();
                            final movement = movementHistoryAsync.value?.firstOrNull;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: PlayerLeaderboardPositionCard(
                                entry: entry,
                                totalPlayers: totalPlayersAsync.value ?? 0,
                                delta: movement?.positionDelta ?? 0,
                              ),
                            );
                          },
                          loading: () => const SizedBox.shrink(),
                          error: (_, __) => const SizedBox.shrink(),
                        );
                      }

                      if (index == 2) {
                        return insightsAsync.when(
                          data: (insights) {
                            if (insights.isEmpty) return const SizedBox.shrink();
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                children: insights.map((i) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: LeaderboardInsightCard(insight: i),
                                )).toList(),
                              ),
                            );
                          },
                          loading: () => const SizedBox.shrink(),
                          error: (_, __) => const SizedBox.shrink(),
                        );
                      }

                      if (index == 3) {
                        return neighborhoodAsync.when(
                          data: (neighborhood) {
                            if (neighborhood.currentPlayer == null) return const SizedBox.shrink();
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: LeaderboardNeighborhood(
                                playerAbove: neighborhood.playerAbove,
                                currentPlayer: neighborhood.currentPlayer!,
                                playerBelow: neighborhood.playerBelow,
                              ),
                            );
                          },
                          loading: () => const SizedBox.shrink(),
                          error: (_, __) => const SizedBox.shrink(),
                        );
                      }

                      if (index == 4) {
                        return playerEntryAsync.when(
                          data: (entry) {
                            if (entry == null) return const SizedBox.shrink();
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: RankProgressCard(entry: entry),
                            );
                          },
                          loading: () => const SizedBox.shrink(),
                          error: (_, __) => const SizedBox.shrink(),
                        );
                      }

                      if (index == 5) {
                        return Column(
                          children: [
                            _buildSectionDivider('TOP PERFORMERS'),
                            const SizedBox(height: 16),
                            LeaderboardPodium(topEntries: entries.take(3).toList()),
                          ],
                        );
                      }

                      final entry = entries[index - 6];
                      return LeaderboardRow(
                        entry: entry,
                        isCurrentUser: entry.userId == session.uid,
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: playerEntryAsync.when(
        data: (entry) {
          if (entry == null) return null;
          // Only show floating entry if user is not in the visible list (placeholder logic)
          return _CurrentUserStickyRow(entry: entry);
        },
        loading: () => null,
        error: (_, __) => null,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.leaderboard_outlined,
            size: 64.sp,
            color: SoteriaColors.muted,
          ),
          SizedBox(height: SoteriaSpacing.md),
          Text('No data available', style: context.titleMedium),
          Text('Be the first to climb the ranks!', style: context.bodySmall),
        ],
      ),
    );
  }

  Widget _buildSectionDivider(String title) {
    return Row(
      children: [
        SoteriaText.caption(
          title,
          color: Colors.white.withValues(alpha: 0.4),
        ),
        const SizedBox(width: 12),
        const Expanded(child: Divider(color: Colors.white10)),
      ],
    );
  }
}

class _CurrentUserStickyRow extends StatelessWidget {
  final LeaderboardEntry entry;

  const _CurrentUserStickyRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.md),
      child: SoteriaCard(
        padding: EdgeInsets.zero,
        hasGlow: true,
        glowColor: SoteriaColors.primary,
        borderColor: SoteriaColors.primary,
        child: LeaderboardRow(entry: entry, isCurrentUser: true),
      ),
    );
  }
}
