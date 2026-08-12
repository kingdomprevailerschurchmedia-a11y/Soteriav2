import 'package:flutter/material.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/components/soteria_progress_bar.dart';
import '../../../domain/models/player_progression.dart';

class RankProgressSection extends StatelessWidget {
  final PlayerProgression progression;

  const RankProgressSection({super.key, required this.progression});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProgressRow(
          context,
          label: 'XP PROGRESS',
          value:
              '${progression.currentXp} / ${progression.xpRequiredForNextLevel - progression.xpRequiredForCurrentLevel} XP',
          progress: progression.xpProgress,
          color: SoteriaColors.xpColor,
        ),
        SizedBox(height: SoteriaSpacing.lg),
        _buildProgressRow(
          context,
          label: 'RANK PROGRESS',
          value: '${(progression.rankProgress * 100).toInt()}%',
          progress: progression.rankProgress,
          color: SoteriaColors.gold,
          showGoal: true,
        ),
      ],
    );
  }

  Widget _buildProgressRow(
    BuildContext context, {
    required String label,
    required String value,
    required double progress,
    required Color color,
    bool showGoal = false,
  }) {
    return Semantics(
      label: '$label: $value',
      value: '${(progress * 100).toInt()}%',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                value,
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.xs),
          SoteriaProgressBar(
            progress: progress,
            color: color,
            height: 8,
            hasGlow: true,
          ),
        ],
      ),
    );
  }
}
