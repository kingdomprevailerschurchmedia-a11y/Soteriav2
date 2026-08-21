import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../../core/design_system/components/soteria_card.dart';
import '../../../providers/pro_lobby_providers.dart';

class ProRewardCard extends ConsumerWidget {
  const ProRewardCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preview = ref.watch(rewardPreviewProvider);

    return SoteriaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ESTIMATED REWARDS',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: SoteriaColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${preview['multiplier']}X MULTIPLIER',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.lg),
          _RewardItem(
            label: 'Potential Coins',
            value: preview['potentialCoins'].toString(),
            icon: Icons.monetization_on_rounded,
            color: SoteriaColors.gold,
          ),
          SizedBox(height: SoteriaSpacing.md),
          _RewardItem(
            label: 'Potential XP',
            value: '+${preview['potentialXP']}',
            icon: Icons.bolt_rounded,
            color: SoteriaColors.primary,
          ),
        ],
      ),
    );
  }
}

class _RewardItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _RewardItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: SoteriaSpacing.md),
        Text(
          label,
          style: context.bodyMedium.copyWith(
            color: SoteriaColors.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ],
    );
  }
}
