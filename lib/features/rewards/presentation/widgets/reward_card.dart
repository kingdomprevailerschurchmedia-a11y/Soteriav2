import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../domain/models/reward.dart';
import '../providers/rewards_providers.dart';

class RewardCard extends ConsumerWidget {
  final Reward reward;

  const RewardCard({
    super.key,
    required this.reward,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLocked = reward.status == RewardStatus.locked;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: SoteriaCard(
        padding: EdgeInsets.all(16.r),
        child: Row(
          children: [
            _buildRewardIcon(),
            SoteriaSpacing.gapMD,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward.title,
                    style: TextStyle(
                      color: isLocked ? SoteriaColors.textSecondary : SoteriaColors.textPrimary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    reward.description,
                    style: TextStyle(
                      color: SoteriaColors.textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            _buildAction(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardIcon() {
    IconData iconData;
    Color iconColor;

    switch (reward.type) {
      case RewardType.coins:
        iconData = Icons.monetization_on;
        iconColor = SoteriaColors.gold;
        break;
      case RewardType.xp:
        iconData = Icons.trending_up;
        iconColor = SoteriaColors.primary;
        break;
      default:
        iconData = Icons.card_giftcard;
        iconColor = SoteriaColors.secondary;
    }

    return Container(
      width: 48.r,
      height: 48.r,
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 24.r,
      ),
    );
  }

  Widget _buildAction(BuildContext context, WidgetRef ref) {
    if (reward.status == RewardStatus.claimable) {
      return ElevatedButton(
        onPressed: () => ref.read(rewardsControllerProvider.notifier).claimReward(reward.id),
        style: ElevatedButton.styleFrom(
          backgroundColor: SoteriaColors.primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        child: Text('CLAIM', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
      );
    }

    if (reward.status == RewardStatus.claimed) {
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 4.w,
        children: [
          Icon(Icons.check_circle, color: SoteriaColors.success, size: 16.r),
          Text(
            'Claimed',
            style: TextStyle(
              color: SoteriaColors.success,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    if (reward.status == RewardStatus.locked) {
      return Icon(Icons.lock, color: SoteriaColors.textSecondary, size: 20.r);
    }

    return Text(
      '+${reward.amount} ${reward.type.name.toUpperCase()}',
      style: TextStyle(
        color: SoteriaColors.gold,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
