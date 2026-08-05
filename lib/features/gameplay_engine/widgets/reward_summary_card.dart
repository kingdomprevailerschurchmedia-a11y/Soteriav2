import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_badge.dart';
import '../progression/models/reward_summary.dart';

class RewardSummaryCard extends StatelessWidget {
  final RewardSummary rewards;

  const RewardSummaryCard({super.key, required this.rewards});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REWARDS EARNED',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          _RewardRow(
            label: 'Base XP',
            value: '+${rewards.baseXP}',
            color: SoteriaColors.primary,
          ),
          if (rewards.streakBonus > 0)
            _RewardRow(
              label: 'Streak Bonus',
              value: '+${rewards.streakBonus}',
              color: Colors.orange,
              isBonus: true,
            ),
          if (rewards.perfectScoreBonus > 0)
            _RewardRow(
              label: 'Perfect Score',
              value: '+${rewards.perfectScoreBonus}',
              color: SoteriaColors.gold,
              isBonus: true,
            ),
          const Divider(color: Colors.white10),
          Padding(
            padding: EdgeInsets.symmetric(vertical: SoteriaSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL XP',
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '+${rewards.totalXP}',
                  style: context.titleLarge.copyWith(
                    color: SoteriaColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'COINS EARNED',
                style: context.bodyMedium.copyWith(color: SoteriaColors.muted),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.monetization_on_rounded,
                    color: SoteriaColors.gold,
                    size: 20,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    rewards.totalCoins.toString(),
                    style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RewardRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isBonus;

  const _RewardRow({
    required this.label,
    required this.value,
    required this.color,
    this.isBonus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                label,
                style: context.bodyMedium.copyWith(
                  color: SoteriaColors.textSecondary,
                ),
              ),
              if (isBonus) ...[
                SizedBox(width: SoteriaSpacing.sm),
                const SoteriaBadge(
                  label: 'BONUS',
                  variant: SoteriaBadgeVariant.info,
                ),
              ],
            ],
          ),
          Text(
            value,
            style: context.bodyLarge.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
