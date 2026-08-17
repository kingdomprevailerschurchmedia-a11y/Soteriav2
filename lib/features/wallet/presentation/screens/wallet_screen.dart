import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../../domain/models/coin_bundle.dart';
import '../../../player/providers/player_providers.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  static const List<CoinBundle> bundles = [
    CoinBundle(
      id: 'bundle_starter',
      name: 'Starter',
      coins: 500,
      price: 7500.00,
      icon: '🪙',
    ),
    CoinBundle(
      id: 'bundle_pro',
      name: 'Pro',
      coins: 2000,
      price: 30000.00,
      icon: '💰',
    ),
    CoinBundle(
      id: 'bundle_elite',
      name: 'Elite',
      coins: 5000,
      price: 75000.00,
      icon: '💎',
    ),
    CoinBundle(
      id: 'bundle_whale',
      name: 'Whale',
      coins: 15000,
      price: 225000.00,
      icon: '🐳',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SoteriaPage(
      useSafeArea: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Coin Store',
            style: TextStyle(
              color: SoteriaColors.textPrimary,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: SoteriaSpacing.containerPadding(context),
            vertical: 16.h,
          ),
          children: [
            _buildBalanceCard(context, ref),
            SoteriaSpacing.gapLG,
            Text(
              'Select a Bundle',
              style: TextStyle(
                color: SoteriaColors.textSecondary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SoteriaSpacing.gapMD,
            ...bundles.map((bundle) => _buildBundleCard(context, bundle)),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, WidgetRef ref) {
    final player = ref.watch(currentPlayerProvider);
    final balance = player?.coins ?? 0;

    return GlassSurface(
      padding: EdgeInsets.all(24.r),
      borderRadius: BorderRadius.circular(24.r),
      child: Column(
        children: [
          Text(
            'Your Balance',
            style: TextStyle(
              color: SoteriaColors.textSecondary,
              fontSize: 14.sp,
            ),
          ),
          SoteriaSpacing.gapXS,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.monetization_on,
                color: SoteriaColors.gold,
                size: 32.r,
              ),
              SoteriaSpacing.gapXS,
              Text(
                balance.toString().replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},'),
                style: TextStyle(
                  color: SoteriaColors.textPrimary,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBundleCard(BuildContext context, CoinBundle bundle) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: SoteriaCard(
        onTap: () {
          // TODO: Implement purchase logic
        },
        padding: EdgeInsets.all(20.r),
        child: Row(
          children: [
            Container(
              width: 56.r,
              height: 56.r,
              decoration: BoxDecoration(
                color: SoteriaColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Text(
                  bundle.icon,
                  style: TextStyle(fontSize: 28.sp),
                ),
              ),
            ),
            SoteriaSpacing.gapMD,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bundle.name,
                    style: TextStyle(
                      color: SoteriaColors.textPrimary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${bundle.coins} Coins',
                    style: TextStyle(
                      color: SoteriaColors.gold,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: SoteriaColors.primary,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: SoteriaColors.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                '₦${bundle.price}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
