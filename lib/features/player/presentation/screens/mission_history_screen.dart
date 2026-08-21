import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/features/player/domain/models/competitive_mission.dart';
import 'package:soteria/features/player/presentation/providers/mission_providers.dart';
import 'package:intl/intl.dart';

class MissionHistoryScreen extends ConsumerWidget {
  const MissionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(missionHistoryProvider);

    return Scaffold(
      backgroundColor: SoteriaColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'MISSION HISTORY',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ),
      body: historyAsync.when(
        data: (missions) {
          if (missions.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: missions.length,
            itemBuilder: (context, index) {
              final mission = missions[index];
              return _HistoryCard(mission: mission);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 64, color: SoteriaColors.muted.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          const Text(
            'No history yet',
            style: TextStyle(
              color: SoteriaColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Complete missions to see them here.',
            style: TextStyle(color: SoteriaColors.muted),
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final CompetitiveMission mission;

  const _HistoryCard({required this.mission});

  @override
  Widget build(BuildContext context) {
    final isExpired = mission.state.status == MissionStatus.expired;
    final date = mission.state.completedAt ?? mission.state.endAt;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SoteriaColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SoteriaColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (isExpired ? SoteriaColors.error : SoteriaColors.success).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isExpired ? Icons.history_toggle_off : Icons.check_circle,
              color: isExpired ? SoteriaColors.error : SoteriaColors.success,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mission.definition.title,
                  style: const TextStyle(
                    color: SoteriaColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${mission.definition.period.name.toUpperCase()} • ${DateFormat('MMM d, y').format(date)}',
                  style: const TextStyle(
                    color: SoteriaColors.muted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isExpired ? 'EXPIRED' : 'CLAIMED',
                style: TextStyle(
                  color: isExpired ? SoteriaColors.error : SoteriaColors.success,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              if (!isExpired) ...[
                const SizedBox(height: 4),
                Text(
                  '+${mission.definition.rewardAmount} XP',
                  style: const TextStyle(
                    color: SoteriaColors.xpColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
