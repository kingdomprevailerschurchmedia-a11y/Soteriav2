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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        borderRadius: BorderRadius.circular(28.r),
        opacity: 0.08,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _BalanceColumn(
                    label: 'COINS',
                    value: wallet.coins,
                    iconPath: 'assets/icons/coin_icon.png',
                    color: SoteriaColors.gold,
                  ),
                ),
                Container(
                  width: 1.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: _BalanceColumn(
                    label: 'TOKENS',
                    value: wallet.tokens,
                    iconData: Icons.confirmation_number, // Blue-ish token icon
                    color: const Color(0xFF7C4DFF),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      loading: () => SizedBox(height: 120.h, child: const Center(child: CircularProgressIndicator())),
      error: (e, _) => Center(child: Text('Error loading wallet', style: TextStyle(color: SoteriaColors.error))),
    );
  }
}

class _BalanceColumn extends StatelessWidget {
  final String label;
  final int value;
  final String? iconPath;
  final IconData? iconData;
  final Color color;

  const _BalanceColumn({
    required this.label,
    required this.value,
    this.iconPath,
    this.iconData,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: SoteriaColors.textSecondary,
            fontSize: 10.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
          ),
        ),
        SoteriaSpacing.gapXS,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null)
              Image.asset(iconPath!, width: 20.w, height: 20.w)
            else if (iconData != null)
              Icon(iconData, color: color, size: 20.w),
            SoteriaSpacing.gapSM,
            Text(
              value.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          'Balance',
          style: TextStyle(
            color: SoteriaColors.textSecondary.withOpacity(0.5),
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
