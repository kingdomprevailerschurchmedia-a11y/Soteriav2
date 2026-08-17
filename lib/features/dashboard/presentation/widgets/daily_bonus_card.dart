import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../providers/daily_bonus_provider.dart';

class DailyBonusCard extends ConsumerWidget {
  const DailyBonusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyBonus = ref.watch(dailyBonusProvider);
    final canClaim = dailyBonus.canClaim;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.lg,
      ),
      child: SoteriaCard(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(SoteriaSpacing.sm),
              decoration: BoxDecoration(
                color: SoteriaColors.gold.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/icons/rewards_icon.png',
                width: 20.sp,
                height: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'DAILY REWARD',
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    canClaim 
                      ? 'Claim your daily 100 coins!' 
                      : 'Next reward in ${_formatDuration(dailyBonus.nextClaimIn)}',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      fontSize: 10.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            SizedBox(
              height: 32.h,
              child: ElevatedButton(
                onPressed: canClaim && !dailyBonus.isClaiming 
                  ? () => ref.read(dailyBonusProvider.notifier).claim() 
                  : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: SoteriaColors.gold,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  disabledBackgroundColor: SoteriaColors.muted.withValues(alpha: 0.2),
                ),
                child: dailyBonus.isClaiming
                  ? SizedBox(
                      width: 14.r,
                      height: 14.r,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    )
                  : Text(
                      canClaim ? 'Claim' : 'Claimed',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}h ${twoDigitMinutes}m";
  }
}
