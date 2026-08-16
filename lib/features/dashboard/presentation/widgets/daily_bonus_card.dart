import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
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
        horizontal: SoteriaSpacing.containerPadding(context),
      ),
      child: SoteriaCard(
        padding: EdgeInsets.all(20.r),
        child: Row(
          children: [
            Container(
              width: 48.r,
              height: 48.r,
              decoration: BoxDecoration(
                color: SoteriaColors.gold.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.card_giftcard,
                color: SoteriaColors.gold,
                size: 24.r,
              ),
            ),
            SoteriaSpacing.gapMD,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily Reward',
                    style: TextStyle(
                      color: SoteriaColors.textPrimary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    canClaim 
                      ? 'Claim your daily 100 coins!' 
                      : 'Next reward in ${_formatDuration(dailyBonus.nextClaimIn)}',
                    style: TextStyle(
                      color: SoteriaColors.textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: canClaim && !dailyBonus.isClaiming 
                ? () => ref.read(dailyBonusProvider.notifier).claim() 
                : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: SoteriaColors.gold,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                disabledBackgroundColor: SoteriaColors.muted.withValues(alpha: 0.2),
              ),
              child: dailyBonus.isClaiming
                ? SizedBox(
                    width: 16.r,
                    height: 16.r,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.black,
                    ),
                  )
                : Text(
                    canClaim ? 'Claim' : 'Claimed',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
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
