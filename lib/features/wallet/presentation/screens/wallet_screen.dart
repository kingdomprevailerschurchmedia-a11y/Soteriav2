import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../domain/models/coin_bundle.dart';
import '../../providers/wallet_providers.dart';

import 'package:soteria/features/rewards/domain/models/store_product.dart';
import 'package:soteria/features/rewards/presentation/providers/rewards_providers.dart';
import 'package:soteria/core/design_system/components/soteria_text_field.dart';
import 'package:soteria/core/design_system/components/soteria_button.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SoteriaPage(
      useSafeArea: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Coin Management',
            style: TextStyle(
              color: SoteriaColors.textPrimary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: SoteriaColors.secondary,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: context.labelSmall.copyWith(fontWeight: FontWeight.w900, letterSpacing: 1.2),
            unselectedLabelStyle: context.labelSmall.copyWith(fontWeight: FontWeight.w500),
            tabs: const [
              Tab(text: 'BUY COINS'),
              Tab(text: 'WITHDRAW'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildBuyTab(context),
            _buildWithdrawTab(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBuyTab(BuildContext context) {
    final productsAsync = ref.watch(storeProductsProvider);

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.containerPadding(context),
        vertical: 16.h,
      ),
      children: [
        _buildBalanceCard(context, ref),
        SoteriaSpacing.gapLG,
        productsAsync.when(
          data: (products) {
            final coins = products.where((p) => p.category == StoreProductCategory.coins).toList();
            final tokens = products.where((p) => p.category == StoreProductCategory.tokens).toList();
            final pro = products.where((p) => p.category == StoreProductCategory.pro).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (pro.isNotEmpty) ...[
                  _buildSectionHeader('SUBSCRIPTION'),
                  ...pro.map((product) => _buildProductCard(context, product)),
                  SoteriaSpacing.gapLG,
                ],
                if (coins.isNotEmpty) ...[
                  _buildSectionHeader('COIN BUNDLES'),
                  ...coins.map((product) => _buildProductCard(context, product)),
                  SoteriaSpacing.gapLG,
                ],
                if (tokens.isNotEmpty) ...[
                  _buildSectionHeader('TOKEN PACKS'),
                  ...tokens.map((product) => _buildProductCard(context, product)),
                ],
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error loading store')),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 4.w),
      child: Text(
        title,
        style: TextStyle(
          color: SoteriaColors.gold,
          fontSize: 12.sp,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildWithdrawTab(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.containerPadding(context),
        vertical: 16.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBalanceCard(context, ref),
          SoteriaSpacing.gapLG,
          Text(
            'WITHDRAWAL REQUEST',
            style: TextStyle(
              color: SoteriaColors.gold,
              fontSize: 12.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          SoteriaSpacing.gapMD,
          GlassSurface(
            padding: EdgeInsets.all(24.r),
            borderRadius: BorderRadius.circular(24.r),
            child: Column(
              children: [
                SoteriaTextField(
                  label: 'Amount to Withdraw (Coins)',
                  hintText: 'Minimum 5,000 Coins',
                  keyboardType: TextInputType.number,
                ),
                SoteriaSpacing.gapMD,
                SoteriaTextField(
                  label: 'Account Number',
                  hintText: 'Enter your NGN bank account',
                ),
                SoteriaSpacing.gapMD,
                SoteriaTextField(
                  label: 'Bank Name',
                  hintText: 'Select your bank',
                ),
                SoteriaSpacing.gapLG,
                SoteriaButton(
                  label: 'SUBMIT WITHDRAWAL',
                  onPressed: () {
                    // Logic for withdrawal
                  },
                ),
                SoteriaSpacing.gapMD,
                Text(
                  'Withdrawals are processed within 24-48 business hours. 10% processing fee applies.',
                  textAlign: TextAlign.center,
                  style: context.labelSmall.copyWith(
                    color: Colors.white24,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(currentWalletBalanceProvider);

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

  Widget _buildProductCard(BuildContext context, StoreProduct product) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: SoteriaCard(
        onTap: () {
          ref.read(rewardsNotifierProvider.notifier).initiatePurchase(product.id);
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
                child: product.id.contains('12000') 
                  ? Text('💎', style: TextStyle(fontSize: 28.sp))
                  : product.id.contains('5500')
                    ? Text('💰', style: TextStyle(fontSize: 28.sp))
                    : Text('🪙', style: TextStyle(fontSize: 28.sp)),
              ),
            ),
            SoteriaSpacing.gapMD,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      color: SoteriaColors.textPrimary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${product.quantity} Coins',
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
                product.displayPrice ?? '₦${product.price}',
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
