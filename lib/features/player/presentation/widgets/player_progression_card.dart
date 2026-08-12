import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_progress_bar.dart';
import '../../../../core/avatar/presentation/widgets/soteria_avatar.dart';
import '../../domain/models/player_progression.dart';
import 'rank_badge.dart';

class PlayerProgressionCard extends StatelessWidget {
  final PlayerProgression progression;
  final String? avatarUrl;
  final String displayName;

  const PlayerProgressionCard({
    super.key,
    required this.progression,
    this.avatarUrl,
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      hasGlow: true,
      glowColor: SoteriaColors.primary,
      padding: EdgeInsets.all(SoteriaSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SoteriaAvatar(size: 48),
              SizedBox(width: SoteriaSpacing.md.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: context.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Level ${progression.currentLevel}',
                      style: context.bodySmall.copyWith(
                        color: SoteriaColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              RankBadge(
                rankName: progression.currentRank,
                tierId: progression.currentRankTier,
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.lg),
          _ProgressBarSection(
            label: 'XP PROGRESS',
            value:
                '${progression.currentXp} / ${progression.xpRequiredForNextLevel - progression.xpRequiredForCurrentLevel} XP',
            progress: progression.xpProgress,
            color: SoteriaColors.xpColor,
          ),
          SizedBox(height: SoteriaSpacing.md),
          _ProgressBarSection(
            label: 'RANK PROGRESS',
            value: '${(progression.rankProgress * 100).toInt()}%',
            progress: progression.rankProgress,
            color: SoteriaColors.gold,
          ),
        ],
      ),
    );
  }
}

class _ProgressBarSection extends StatelessWidget {
  final String label;
  final String value;
  final double progress;
  final Color color;

  const _ProgressBarSection({
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 6,
          hasGlow: true,
        ),
      ],
    );
  }
}
