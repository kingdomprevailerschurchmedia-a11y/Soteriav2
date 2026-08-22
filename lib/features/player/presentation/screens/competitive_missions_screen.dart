import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/features/player/presentation/providers/mission_providers.dart';
import 'package:soteria/features/player/presentation/widgets/missions/competitive_mission_card.dart';
import 'package:soteria/features/player/domain/models/competitive_mission.dart';

class CompetitiveMissionsScreen extends ConsumerStatefulWidget {
  const CompetitiveMissionsScreen({super.key});

  @override
  ConsumerState<CompetitiveMissionsScreen> createState() => _CompetitiveMissionsScreenState();
}

class _CompetitiveMissionsScreenState extends ConsumerState<CompetitiveMissionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'MISSIONS',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 18,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: SoteriaColors.primary,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: SoteriaColors.muted,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1,
          ),
          tabs: const [
            Tab(text: 'DAILY'),
            Tab(text: 'WEEKLY'),
            Tab(text: 'SEASON'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MissionList(period: MissionPeriod.daily),
          _MissionList(period: MissionPeriod.weekly),
          _MissionList(period: MissionPeriod.seasonal),
        ],
      ),
    );
  }
}

class _MissionList extends ConsumerWidget {
  final MissionPeriod period;

  const _MissionList({required this.period});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final missionsAsync = _getProviderForPeriod(ref);

    return missionsAsync.when(
      data: (missions) {
        if (missions.isEmpty) {
          return _buildEmptyState();
        }

        return RefreshIndicator(
          onRefresh: () => ref.read(missionRepositoryProvider).refreshMissions('current_user'), // TODO: Use actual user ID
          color: SoteriaColors.primary,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: missions.length,
            itemBuilder: (context, index) {
              final mission = missions[index];
              return CompetitiveMissionCard(
                mission: mission,
                onClaim: () => ref.read(missionRepositoryProvider).claimReward(
                  mission.state.userId,
                  mission.state.missionId,
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: SoteriaColors.primary),
      ),
      error: (error, stack) => Center(
        child: Text(
          'Failed to load missions',
          style: TextStyle(color: SoteriaColors.error),
        ),
      ),
    );
  }

  AsyncValue<List<CompetitiveMission>> _getProviderForPeriod(WidgetRef ref) {
    switch (period) {
      case MissionPeriod.daily:
        return ref.watch(dailyMissionsProvider);
      case MissionPeriod.weekly:
        return ref.watch(weeklyMissionsProvider);
      case MissionPeriod.seasonal:
        return ref.watch(seasonalMissionsProvider);
      case MissionPeriod.career:
        return const AsyncValue.data([]);
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 64,
            color: SoteriaColors.muted.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            "You're all caught up.",
            style: TextStyle(
              color: SoteriaColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'New missions will appear when the next period begins.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: SoteriaColors.muted,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
