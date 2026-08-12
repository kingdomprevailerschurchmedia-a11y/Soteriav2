import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../../domain/models/reward_grant.dart';
import '../../../domain/models/season_reward_definition.dart';

class RewardSummarySection extends StatelessWidget {
  final List<RewardGrant> recentRewards;
  final int totalRewards;

  const RewardSummarySection({
    super.key,
    required this.recentRewards,
    required this.totalRewards,
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
              'EARNED REWARDS',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.muted,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              '$totalRewards TOTAL',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.md),
        if (recentRewards.isEmpty)
          SoteriaCard(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            child: Center(
              child: Text(
                'No rewards earned yet.',
                style: context.bodyMedium.copyWith(color: SoteriaColors.muted),
              ),
            ),
          )
        else
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recentRewards.length,
              separatorBuilder: (_, __) => SizedBox(width: SoteriaSpacing.md),
              itemBuilder: (context, index) {
                final reward = recentRewards[index];
                return _RewardItem(reward: reward);
              },
            ),
          ),
      ],
    );
  }
}

class _RewardItem extends StatelessWidget {
  final RewardGrant reward;

  const _RewardItem({required this.reward});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      padding: EdgeInsets.all(SoteriaSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          SizedBox(height: SoteriaSpacing.xs),
          Text(
            '+${reward.amount}',
            style: context.labelMedium.copyWith(
              color: _getTypeColor(reward.type),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    IconData icon;
    Color color = _getTypeColor(reward.type);

    switch (reward.type) {
      case RewardType.xp:
        icon = Icons.bolt;
        break;
      case RewardType.coins:
        icon = Icons.monetization_on;
        break;
      case RewardType.tokens:
        icon = Icons.token;
        break;
      case RewardType.badge:
        icon = Icons.verified;
        break;
      case RewardType.achievement:
        icon = Icons.emoji_events;
        break;
      default:
        icon = Icons.card_giftcard;
    }

    return Icon(icon, color: color, size: 24.sp);
  }

  Color _getTypeColor(RewardType type) {
    switch (type) {
      case RewardType.xp:
        return SoteriaColors.xpColor;
      case RewardType.coins:
        return SoteriaColors.coinColor;
      case RewardType.tokens:
        return SoteriaColors.secondary;
      case RewardType.badge:
      case RewardType.achievement:
        return SoteriaColors.gold;
      default:
        return SoteriaColors.primary;
    }
  }
}
