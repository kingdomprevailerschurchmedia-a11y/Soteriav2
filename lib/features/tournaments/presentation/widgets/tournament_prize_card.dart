import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import '../../domain/models/tournament_reward.dart';

class TournamentPrizeCard extends StatelessWidget {
  final TournamentReward reward;

  const TournamentPrizeCard({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    if (reward.isEmpty) {
      return const SizedBox.shrink();
    }

    return SoteriaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TOURNAMENT PRIZES',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.gold,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: SoteriaSpacing.lg),
          if (reward.coins > 0)
            _PrizeItem(
              icon: Icons.monetization_on_rounded,
              color: SoteriaColors.gold,
              label: 'Coins',
              value: '+${reward.coins}',
            ),
          if (reward.xp > 0)
            _PrizeItem(
              icon: Icons.auto_awesome_rounded,
              color: SoteriaColors.primary,
              label: 'Experience',
              value: '+${reward.xp} XP',
            ),
          if (reward.badges.isNotEmpty)
            _PrizeItem(
              icon: Icons.verified_rounded,
              color: SoteriaColors.success,
              label: 'Badges',
              value: reward.badges.join(', '),
            ),
          if (reward.titles.isNotEmpty)
            _PrizeItem(
              icon: Icons.workspace_premium_rounded,
              color: SoteriaColors.secondary,
              label: 'Titles',
              value: reward.titles.join(', '),
            ),
        ],
      ),
    );
  }
}

class _PrizeItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _PrizeItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    fontSize: 10.sp,
                  ),
                ),
                Text(
                  value,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
