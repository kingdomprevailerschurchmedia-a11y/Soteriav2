import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_text.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/components/soteria_progress_bar.dart';
import 'package:soteria/features/player/domain/config/progression_config.dart';
import 'package:soteria/features/player/domain/models/leaderboard_entry.dart';

class RankProgressCard extends StatelessWidget {
  final LeaderboardEntry entry;

  const RankProgressCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final currentTier = ProgressionConfig.rankTiers.firstWhere(
      (t) => t.id.toLowerCase() == entry.rankTier.toLowerCase(),
      orElse: () => ProgressionConfig.rankTiers.first,
    );

    final nextTierIndex = ProgressionConfig.rankTiers.indexOf(currentTier) + 1;
    final nextTier = nextTierIndex < ProgressionConfig.rankTiers.length 
        ? ProgressionConfig.rankTiers[nextTierIndex] 
        : null;

    if (nextTier == null) return const SizedBox.shrink();

    final range = nextTier.promotionThreshold - currentTier.promotionThreshold;
    final currentProgressPoints = entry.rankPoints - currentTier.promotionThreshold;
    final progress = range > 0 ? (currentProgressPoints / range).clamp(0.0, 1.0) : 1.0;
    final remaining = nextTier.promotionThreshold - entry.rankPoints;

    return SoteriaCard(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SoteriaText.caption(
                'RANK PROGRESS',
                color: Colors.white.withValues(alpha: 0.4),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: SoteriaText.caption(
                  '$remaining RP to ${nextTier.name}',
                  color: SoteriaColors.gold,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SoteriaProgressBar(
            progress: progress,
            color: SoteriaColors.primary,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SoteriaText.caption(currentTier.name, color: SoteriaColors.muted),
              SoteriaText.caption(nextTier.name, color: SoteriaColors.muted),
            ],
          ),
        ],
      ),
    );
  }
}
