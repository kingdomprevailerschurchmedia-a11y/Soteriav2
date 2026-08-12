import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/identity/providers/identity_providers.dart';
import '../providers/leaderboard_providers.dart';
import '../widgets/leaderboard_podium.dart';
import '../widgets/leaderboard_row.dart';
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
                  onRefresh: () => ref
                      .read(leaderboardControllerProvider.notifier)
                      .refresh(),
                  color: SoteriaColors.primary,
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 10.h),
                    itemCount:
                        entries.length + 2, // +2 for SeasonHeader and Podium
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: SeasonHeader(),
                        );
                      }
                      if (index == 1) {
                        return LeaderboardPodium(
                          topEntries: entries.take(3).toList(),
                        );
                      }
                      final entry = entries[index - 2];
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
}

class _CurrentUserStickyRow extends StatelessWidget {
  final dynamic
  entry; // Using dynamic for now to avoid redundant imports if needed

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
