import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../domain/models/rank_progress.dart';
import 'competitive_rank_badge.dart';
import 'rank_progress_bar.dart';

class CompetitiveRankCard extends StatelessWidget {
  final RankProgress rankProgress;
  final VoidCallback? onTap;
  final bool showRP;

  const CompetitiveRankCard({
    super.key,
    required this.rankProgress,
    this.onTap,
    this.showRP = true,
  });

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      onTap: onTap,
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CompetitiveRankBadge(
                tierId: rankProgress.tier.id,
                rankName: rankProgress.currentRank,
                size: RankBadgeSize.medium,
                hasGlow: rankProgress.tier.displayOrder >= 3, // Gold and above
              ),
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rankProgress.currentRank.toUpperCase(),
                      style: context.titleMedium.copyWith(
                        color: SoteriaColors.textPrimary,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    if (showRP)
                      Text(
                        '${rankProgress.currentRP} RP',
                        style: context.labelMedium.copyWith(
                          color: SoteriaColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(
                  Icons.chevron_right_rounded,
                  color: SoteriaColors.textSecondary,
                ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.lg),
          RankProgressBar(
            progress: rankProgress,
            variant: RankProgressVariant.default_,
            showCurrentRP: showRP,
          ),
        ],
      ),
    );
  }
}
