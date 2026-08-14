import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class EventRewardCard extends StatelessWidget {
  final int xp;
  final int coins;

  const EventRewardCard({super.key, required this.xp, required this.coins});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.md),
      decoration: BoxDecoration(
        color: SoteriaColors.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SoteriaColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'POTENTIAL REWARDS',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: SoteriaSpacing.sm),
          Row(
            children: [
              if (xp > 0) ...[
                _RewardItem(
                  icon: Icons.bolt,
                  value: '+$xp XP',
                  color: SoteriaColors.xpColor,
                ),
                SizedBox(width: SoteriaSpacing.md),
              ],
              if (coins > 0) ...[
                _RewardItem(
                  icon: Icons.monetization_on,
                  value: '+$coins Coins',
                  color: SoteriaColors.gold,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _RewardItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _RewardItem({
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 4),
        Text(
          value,
          style: context.titleSmall.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
