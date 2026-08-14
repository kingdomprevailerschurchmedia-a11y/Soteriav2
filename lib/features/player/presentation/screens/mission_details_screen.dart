import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/components/soteria_progress_bar.dart';
import 'package:soteria/features/player/domain/models/competitive_mission.dart';
import 'package:soteria/features/player/presentation/providers/mission_providers.dart';

class MissionDetailsScreen extends ConsumerWidget {
  final String missionId;

  const MissionDetailsScreen({super.key, required this.missionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In a real app, we'd have a specific provider for one mission.
    // For now, we'll find it in the active missions list.
    final missionsAsync = ref.watch(activeMissionsProvider);

    return missionsAsync.when(
      data: (missions) {
        final mission = missions.firstWhere(
          (m) => m.state.missionId == missionId,
          orElse: () => throw Exception('Mission not found'),
        );

        return Scaffold(
          backgroundColor: SoteriaColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('MISSION DETAILS'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(mission),
                const SizedBox(height: 32),
                _buildInfoSection(mission),
                const SizedBox(height: 32),
                _buildProgressSection(mission),
                const SizedBox(height: 32),
                _buildRewardSection(mission),
                const SizedBox(height: 48),
                _buildActionButtons(context, mission),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, s) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildHeader(CompetitiveMission mission) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: SoteriaColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            mission.definition.period.name.toUpperCase(),
            style: const TextStyle(
              color: SoteriaColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          mission.definition.title,
          style: const TextStyle(
            color: SoteriaColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          mission.definition.description,
          style: const TextStyle(
            color: SoteriaColors.textSecondary,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(CompetitiveMission mission) {
    return Row(
      children: [
        _buildInfoItem(
          Icons.speed,
          mission.definition.difficulty.name.toUpperCase(),
          'Difficulty',
        ),
        const SizedBox(width: 24),
        _buildInfoItem(
          Icons.schedule,
          _getTimeRemainingText(mission),
          'Time Left',
        ),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: SoteriaColors.muted, size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: SoteriaColors.muted,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: SoteriaColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _getTimeRemainingText(CompetitiveMission mission) {
    final duration = mission.timeRemaining;
    if (duration.inDays > 0) return '${duration.inDays} Days';
    if (duration.inHours > 0) return '${duration.inHours} Hours';
    return '${duration.inMinutes} Minutes';
  }

  Widget _buildProgressSection(CompetitiveMission mission) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'PROGRESS',
              style: TextStyle(
                color: SoteriaColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            Text(
              '${mission.state.progress.toInt()} / ${mission.definition.target.toInt()}',
              style: const TextStyle(
                color: SoteriaColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SoteriaProgressBar(
          progress: mission.progressPercentage,
          height: 12,
          color: SoteriaColors.primary,
        ),
        const SizedBox(height: 12),
        Text(
          '${(mission.progressPercentage * 100).toInt()}% towards completion',
          style: const TextStyle(
            color: SoteriaColors.muted,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildRewardSection(CompetitiveMission mission) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: SoteriaColors.elevatedSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: SoteriaColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: SoteriaColors.xpColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bolt,
              color: SoteriaColors.xpColor,
              size: 32,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'REWARD',
                style: TextStyle(
                  color: SoteriaColors.muted,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${mission.definition.rewardAmount} XP',
                style: const TextStyle(
                  color: SoteriaColors.xpColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, CompetitiveMission mission) {
    if (mission.state.status == MissionStatus.completed) {
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            // Claim logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: SoteriaColors.success,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'CLAIM REWARD',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // Deep link to gameplay
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: SoteriaColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'START MISSION',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
