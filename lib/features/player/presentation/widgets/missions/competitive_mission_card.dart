import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/components/soteria_progress_bar.dart';
import 'package:soteria/features/player/domain/models/competitive_mission.dart';
// import 'package:intl/intl.dart'; // Removed unused import

class CompetitiveMissionCard extends StatelessWidget {
  final CompetitiveMission mission;
  final VoidCallback? onTap;
  final VoidCallback? onClaim;

  const CompetitiveMissionCard({
    super.key,
    required this.mission,
    this.onTap,
    this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: SoteriaColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: mission.isCompleted 
              ? SoteriaColors.success.withValues(alpha: 0.3) 
              : SoteriaColors.border,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 12),
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
                  mission.definition.description,
                  style: const TextStyle(
                    color: SoteriaColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                _buildProgress(context),
                if (mission.state.status == MissionStatus.completed) ...[
                  const SizedBox(height: 16),
                  _buildClaimButton(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildPeriodBadge(),
            const SizedBox(width: 8),
            _buildRewardIndicator(),
          ],
        ),
        _buildTimeRemaining(),
      ],
    );
  }

  Widget _buildPeriodBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getPeriodColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        mission.definition.period.name.toUpperCase(),
        style: TextStyle(
          color: _getPeriodColor(),
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Color _getPeriodColor() {
    switch (mission.definition.period) {
      case MissionPeriod.daily:
        return SoteriaColors.info;
      case MissionPeriod.weekly:
        return SoteriaColors.primary;
      case MissionPeriod.seasonal:
        return SoteriaColors.gold;
      case MissionPeriod.career:
        return SoteriaColors.secondary;
    }
  }

  Widget _buildRewardIndicator() {
    return Row(
      children: [
        const Icon(
          Icons.bolt,
          color: SoteriaColors.xpColor,
          size: 14,
        ),
        const SizedBox(width: 2),
        Text(
          '+${mission.definition.rewardAmount} XP',
          style: const TextStyle(
            color: SoteriaColors.xpColor,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeRemaining() {
    if (mission.isCompleted || mission.isClaimed) {
      return Row(
        children: const [
          Icon(Icons.check_circle, color: SoteriaColors.success, size: 14),
          SizedBox(width: 4),
          Text(
            'COMPLETED',
            style: TextStyle(
              color: SoteriaColors.success,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    final duration = mission.timeRemaining;
    String text;
    if (duration.inDays > 0) {
      text = '${duration.inDays}d left';
    } else if (duration.inHours > 0) {
      text = '${duration.inHours}h left';
    } else {
      text = '${duration.inMinutes}m left';
    }

    return Text(
      text,
      style: TextStyle(
        color: mission.isExpiringSoon ? SoteriaColors.error : SoteriaColors.muted,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildProgress(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${mission.state.progress.toInt()} / ${mission.definition.target.toInt()}',
              style: const TextStyle(
                color: SoteriaColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${(mission.progressPercentage * 100).toInt()}%',
              style: const TextStyle(
                color: SoteriaColors.muted,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SoteriaProgressBar(
          progress: mission.progressPercentage,
          height: 6,
          color: mission.isCompleted ? SoteriaColors.success : SoteriaColors.primary,
        ),
      ],
    );
  }

  Widget _buildClaimButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onClaim,
        style: ElevatedButton.styleFrom(
          backgroundColor: SoteriaColors.success,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'CLAIM REWARD',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
