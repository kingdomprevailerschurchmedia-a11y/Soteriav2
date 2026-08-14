import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/features/player/domain/models/season_reward_definition.dart';

class SeasonRewardCard extends StatelessWidget {
  final SeasonRewardDefinition definition;
  final bool isUnlocked;
  final bool isClaimed;
  final VoidCallback? onClaim;

  const SeasonRewardCard({
    super.key,
    required this.definition,
    this.isUnlocked = false,
    this.isClaimed = false,
    this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    final color = isUnlocked ? SoteriaColors.primary : SoteriaColors.muted;

    return SoteriaCard(
      margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
      padding: EdgeInsets.all(SoteriaSpacing.md),
      borderColor: isUnlocked ? SoteriaColors.primary.withValues(alpha: 0.3) : null,
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIcon(definition.type),
              color: color,
              size: 24.sp,
            ),
          ),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  definition.name,
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? Colors.white : Colors.white.withValues(alpha: 0.5),
                  ),
                ),
                Text(
                  definition.description,
                  style: context.labelSmall.copyWith(color: SoteriaColors.muted),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+${definition.amount}',
                style: context.titleMedium.copyWith(
                  color: isUnlocked ? SoteriaColors.gold : SoteriaColors.muted,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isUnlocked && !isClaimed)
                Text(
                  'READY',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.success,
                    fontWeight: FontWeight.bold,
                    fontSize: 8.sp,
                  ),
                )
              else if (isClaimed)
                Text(
                  'CLAIMED',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    fontSize: 8.sp,
                  ),
                )
              else
                Icon(Icons.lock_rounded, color: SoteriaColors.muted, size: 12.sp),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIcon(RewardType type) {
    switch (type) {
      case RewardType.xp: return Icons.bolt_rounded;
      case RewardType.coins: return Icons.monetization_on_rounded;
      case RewardType.badge: return Icons.verified_rounded;
      case RewardType.title: return Icons.title_rounded;
      default: return Icons.card_giftcard_rounded;
    }
  }
}
