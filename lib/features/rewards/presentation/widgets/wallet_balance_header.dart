import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../providers/rewards_providers.dart';

class WalletBalanceHeader extends ConsumerWidget {
  const WalletBalanceHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletAsync = ref.watch(walletProvider);

    return walletAsync.when(
      data: (wallet) => GlassSurface(
        padding: EdgeInsets.all(24.r),
        borderRadius: BorderRadius.circular(24.r),
        child: Column(
          children: [
            Text(
              'Your Wallet',
              style: TextStyle(
                color: SoteriaColors.textSecondary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SoteriaSpacing.gapXS,
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8.w,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: SoteriaColors.gold,
                      size: 36.r,
                    ),
                    SoteriaSpacing.gapXS,
                    Text(
                      wallet.coins.toString().replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},'),
                      style: TextStyle(
                        color: SoteriaColors.textPrimary,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Coins',
                  style: TextStyle(
                    color: SoteriaColors.gold,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (wallet.lifetimeCoinsEarned > 0) ...[
              SoteriaSpacing.gapSM,
              Text(
                '+${(wallet.lifetimeCoinsEarned - wallet.lifetimeCoinsSpent).toString()} earned this season',
                style: TextStyle(
                  color: SoteriaColors.success,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error loading wallet', style: TextStyle(color: SoteriaColors.error))),
    );
  }
}
