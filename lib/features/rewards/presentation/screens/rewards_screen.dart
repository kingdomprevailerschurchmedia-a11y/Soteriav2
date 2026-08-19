import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../core/design_system/components/soteria_back_button.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../providers/rewards_providers.dart';
import '../widgets/wallet_balance_header.dart';
import '../widgets/reward_card.dart';
import '../../domain/models/store_product.dart';
import '../../domain/models/reward_transaction.dart';
import '../../domain/models/reward.dart';

class RewardsScreen extends ConsumerStatefulWidget {
  const RewardsScreen({super.key});

  @override
  ConsumerState<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends ConsumerState<RewardsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1); // Default to Store
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SoteriaPage(
      useSafeArea: false,
      showBackground: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            _buildAppBar(context),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _EarnTab(),
                  _StoreTab(),
                  _HistoryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(200.h),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 4.h, bottom: 0.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SoteriaBackButton(),
                  _buildSmallCoinChip(),
                ],
              ),
              SizedBox(height: 2.h),
              // Decorative header icon
              Image.asset(
                'assets/icons/rewards_store.png',
                width: 220.r,
                height: 130.r,
                fit: BoxFit.contain,
              ),
              Text(
                'Rewards & Economy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallCoinChip() {
    return Consumer(
      builder: (context, ref, _) {
        final walletAsync = ref.watch(walletProvider);
        final coins = walletAsync.value?.coins ?? 0;
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: SoteriaColors.gold.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Image.asset('assets/icons/coin_icon.png', width: 14.w),
              SoteriaSpacing.gapXS,
              Text(
                coins.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SoteriaSpacing.gapXS,
              Container(
                decoration: const BoxDecoration(
                  color: SoteriaColors.primary,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(2.r),
                child: Icon(Icons.add, color: Colors.white, size: 10.sp),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: EdgeInsets.only(top: 0.h, bottom: 8.h),
      child: TabBar(
        controller: _tabController,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.h, color: SoteriaColors.secondary),
          insets: EdgeInsets.zero,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.4),
        labelStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Earn'),
          Tab(text: 'Store'),
          Tab(text: 'History'),
        ],
      ),
    );
  }
}

class _EarnTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rewardsAsync = ref.watch(availableRewardsProvider);

    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 100.h),
      children: [
        const WalletBalanceHeader(),
        SoteriaSpacing.gapLG,
        Text(
          'AVAILABLE REWARDS',
          style: TextStyle(
            color: SoteriaColors.gold,
            fontSize: 12.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        SoteriaSpacing.gapMD,
        rewardsAsync.when(
          data: (rewards) {
            if (rewards.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: Text(
                    'No rewards available yet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: SoteriaColors.textSecondary),
                  ),
                ),
              );
            }
            return Column(
              children: rewards.map((r) => _EarnItemCard(reward: r)).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error loading rewards')),
        ),
      ],
    );
  }
}

class _EarnItemCard extends ConsumerWidget {
  final Reward reward;

  const _EarnItemCard({required this.reward});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isClaimable = reward.status == RewardStatus.claimable;
    final isClaimed = reward.status == RewardStatus.claimed;
    final isLocked = reward.status == RewardStatus.locked;
    
    final color = isClaimable ? SoteriaColors.success : (isLocked ? SoteriaColors.muted : SoteriaColors.primary);
    
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: const Color(0xFF0D0628).withOpacity(0.6),
        border: Border.all(
          color: isClaimable ? color.withOpacity(0.4) : color.withOpacity(0.1),
          width: isClaimable ? 1.5 : 1,
        ),
        boxShadow: isClaimable ? [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ] : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            if (isClaimable)
              Positioned(
                right: -40,
                top: -40,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        color.withOpacity(0.1),
                        color.withOpacity(0),
                      ],
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(SoteriaSpacing.md),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(SoteriaSpacing.sm),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: reward.source == RewardSource.dailyLogin
                        ? Image.asset('assets/icons/rewards_icon.png', width: 20.sp, height: 20.sp)
                        : Icon(
                            _getIcon(reward.source),
                            color: color,
                            size: 20.sp,
                          ),
                  ),
                  SoteriaSpacing.gapMD,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reward.title.toUpperCase(),
                          style: TextStyle(
                            color: isLocked ? Colors.white.withOpacity(0.3) : Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          reward.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 10.sp,
                          ),
                        ),
                        if (isClaimed && reward.claimedAt != null) ...[
                          SizedBox(height: 4.h),
                          Text(
                            'CLAIMED ON ${reward.claimedAt!.day}/${reward.claimedAt!.month}/${reward.claimedAt!.year}',
                            style: TextStyle(
                              color: SoteriaColors.success.withOpacity(0.7),
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  _buildAction(context, ref),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(BuildContext context, WidgetRef ref) {
    final isClaiming = reward.metadata['isClaiming'] == true ||
        ref.watch(rewardsNotifierProvider).isLoading;

    if (isClaiming && reward.status != RewardStatus.claimed) {
      return SizedBox(
        width: 24.r,
        height: 24.r,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          color: SoteriaColors.primary,
        ),
      );
    }

    if (reward.status == RewardStatus.claimable) {
      return GestureDetector(
        onTap: () => ref.read(rewardsNotifierProvider.notifier).claimReward(reward.id),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF7C4DFF), Color(0xFF5B3FD9), Color(0xFF2E1A8A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C4DFF).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            'CLAIM',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ),
      );
    }

    if (reward.status == RewardStatus.claimed) {
      return Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: SoteriaColors.success.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.check_circle_rounded, color: SoteriaColors.success, size: 24.r),
      );
    }

    if (reward.status == RewardStatus.locked) {
      return Icon(Icons.lock_outline_rounded, color: Colors.white.withOpacity(0.2), size: 24.r);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '+${reward.amount}',
          style: TextStyle(
            color: reward.type == RewardType.coins ? SoteriaColors.gold : const Color(0xFF7C4DFF),
            fontSize: 16.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          reward.type.name.toUpperCase(),
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 7.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  IconData _getIcon(RewardSource source) {
    switch (source) {
      case RewardSource.achievement: return Icons.emoji_events_rounded;
      case RewardSource.streak: return Icons.local_fire_department_rounded;
      case RewardSource.dailyLogin: return Icons.calendar_today_rounded;
      case RewardSource.tournamentReward: return Icons.military_tech_rounded;
      case RewardSource.milestone: return Icons.flag_rounded;
      default: return Icons.stars_rounded;
    }
  }
}

class _StoreTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(storeProductsProvider);

    return productsAsync.when(
      data: (products) {
        final coinProducts = products.where((p) => p.category == StoreProductCategory.coins).toList();
        final tokenProducts = products.where((p) => p.category == StoreProductCategory.tokens).toList();
        
        return ListView(
          padding: EdgeInsets.fromLTRB(16.r, 16.r, 16.r, 100.h),
          children: [
            const WalletBalanceHeader(),
            SoteriaSpacing.gapMD,
            _buildProCard(context, ref),
            SoteriaSpacing.gapMD,
            if (coinProducts.isNotEmpty) ...[
              _buildCompactSectionHeader('COIN PACKS'),
              ...coinProducts.map((p) => _ProductCard(product: p)),
              SoteriaSpacing.gapMD,
            ],
            if (tokenProducts.isNotEmpty) ...[
              _buildCompactSectionHeader('TOKEN PACKS'),
              ...tokenProducts.map((p) => _ProductCard(product: p, isToken: true)),
            ],
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error loading store')),
    );
  }

  Widget _buildCompactSectionHeader(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          Row(
            children: [
              Icon(Icons.shield_rounded, color: const Color(0xFF7C4DFF), size: 14.sp),
              SizedBox(width: 4.w),
              Text(
                'SECURE PAYMENTS',
                style: TextStyle(
                  color: const Color(0xFF7C4DFF),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProCard(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1E1045).withOpacity(0.8),
            const Color(0xFF0D0628).withOpacity(0.9),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C4DFF).withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          Row(
            children: [
              // Product artwork (Diamond)
              Container(
                width: 64.r,
                height: 64.r,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.withOpacity(0.2),
                      Colors.purple.withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFFB9F2FF), Color(0xFF7C4DFF)],
                    ).createShader(bounds),
                    child: Icon(Icons.diamond_rounded, color: Colors.white, size: 40.r),
                  ),
                ),
              ),
              SoteriaSpacing.gapMD,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: SoteriaColors.gold, size: 10.sp),
                        SizedBox(width: 4.w),
                        Text(
                          'SOTERIA PRO',
                          style: TextStyle(
                            color: SoteriaColors.gold,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Soteria Pro Monthly',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Premium competitive learning experience',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 10.sp,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => ref.read(rewardsNotifierProvider.notifier).initiatePurchase('soteria.pro.monthly'),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7C4DFF), Color(0xFF5B3FD9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7C4DFF).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        '₦15,000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '/ month',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 9.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SoteriaSpacing.gapMD,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProTag(Icons.block, 'No Ads'),
              _buildProTag(Icons.insights, 'Advanced Stats'),
              _buildProTag(Icons.card_giftcard, 'Exclusive Rewards'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProTag(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF7C4DFF), size: 10.sp),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends ConsumerWidget {
  final StoreProduct product;
  final bool isToken;

  const _ProductCard({required this.product, this.isToken = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasBonus = product.metadata['bonusPercentage'] != null;
    
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.06),
                  Colors.white.withOpacity(0.02),
                ],
              ),
              border: Border.all(
                color: product.isPopular 
                  ? SoteriaColors.gold.withOpacity(0.5) 
                  : Colors.white.withOpacity(0.05),
                width: product.isPopular ? 1.5 : 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                // Product icon
                SizedBox(
                  width: 50.w,
                  height: 50.w,
                  child: isToken 
                    ? Icon(Icons.confirmation_number, color: const Color(0xFF7C4DFF), size: 32.r)
                    : Image.asset(
                        'assets/icons/sack_of_coins.png',
                        fit: BoxFit.contain,
                      ),
                ),
                SoteriaSpacing.gapMD,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 11.sp,
                        ),
                      ),
                      if (hasBonus) ...[
                        SizedBox(height: 2.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            '${product.metadata['bonusPercentage']}% BONUS',
                            style: TextStyle(
                              color: const Color(0xFF4CAF50),
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => ref.read(rewardsNotifierProvider.notifier).initiatePurchase(product.id),
                  child: Container(
                    width: 76.w,
                    height: 38.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7C4DFF), Color(0xFF5B3FD9)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7C4DFF).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      product.displayPrice ?? '₦${product.price}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (product.isPopular)
            Positioned(
              top: -6.h,
              left: 10.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C4DFF),
                  borderRadius: BorderRadius.circular(6.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'POPULAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _HistoryTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionHistoryProvider);

    return transactionsAsync.when(
      data: (transactions) {
        if (transactions.isEmpty) {
          return Center(
            child: Text(
              'No transactions yet.',
              style: TextStyle(color: SoteriaColors.textSecondary),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 100.h),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return _HistoryItemCard(tx: transactions[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error loading history')),
    );
  }
}

class _HistoryItemCard extends StatelessWidget {
  final WalletTransaction tx;

  const _HistoryItemCard({required this.tx});

  @override
  Widget build(BuildContext context) {
    final isCredit = tx.direction == TransactionDirection.credit;
    final color = isCredit ? const Color(0xFF4CAF50) : const Color(0xFFF44336);
    
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        color: const Color(0xFF0D0628).withOpacity(0.6),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      color.withOpacity(0.1),
                      color.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(SoteriaSpacing.md),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(SoteriaSpacing.sm),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: tx.source == RewardSource.dailyLogin
                        ? Image.asset('assets/icons/rewards_icon.png', width: 20.sp, height: 20.sp)
                        : Icon(
                            _getIcon(tx.source),
                            color: color,
                            size: 20.sp,
                          ),
                  ),
                  SoteriaSpacing.gapMD,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getTitle(tx.source).toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          _getDescription(tx),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 10.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(Icons.calendar_today_rounded, 
                                 color: Colors.white.withOpacity(0.3), size: 10.sp),
                            SizedBox(width: 4.w),
                            Text(
                              '${tx.createdAt.day}/${tx.createdAt.month}/${tx.createdAt.year}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.3),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${isCredit ? '+' : '-'}${tx.amount}',
                        style: TextStyle(
                          color: color,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        tx.currency.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 11.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          if (title == 'COIN PACKS')
            Row(
              children: [
                Icon(Icons.shield_outlined, color: const Color(0xFF7C4DFF), size: 12.sp),
                SizedBox(width: 4.w),
                Text(
                  'Secure',
                  style: TextStyle(
                    color: const Color(0xFF7C4DFF),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  IconData _getIcon(RewardSource source) {
    switch (source) {
      case RewardSource.achievement: return Icons.emoji_events_rounded;
      case RewardSource.streak: return Icons.local_fire_department_rounded;
      case RewardSource.tournament:
      case RewardSource.tournamentReward: return Icons.sports_esports_rounded;
      case RewardSource.dailyLogin: return Icons.calendar_today_rounded;
      case RewardSource.itemRedemption: return Icons.shopping_bag_rounded;
      case RewardSource.purchase: return Icons.monetization_on_rounded;
      default: return Icons.stars_rounded;
    }
  }

  String _getTitle(RewardSource source) {
    switch (source) {
      case RewardSource.achievement: return 'Achievement';
      case RewardSource.streak: return 'Streak';
      case RewardSource.tournament:
      case RewardSource.tournamentReward: return 'Tournament';
      case RewardSource.dailyLogin: return 'Daily Reward';
      case RewardSource.itemRedemption: return 'Shop Purchase';
      case RewardSource.purchase: return 'Store Purchase';
      default: return 'Reward';
    }
  }

  String _getDescription(WalletTransaction tx) {
    if (tx.metadata['description'] != null) return tx.metadata['description'];
    
    switch (tx.source) {
      case RewardSource.achievement: return 'Completed unique challenge';
      case RewardSource.streak: return 'Consecutive day bonus';
      case RewardSource.tournament: return 'Entry fee for event';
      case RewardSource.tournamentReward: return 'Prize from competition';
      case RewardSource.purchase: return 'Credits added from store';
      default: return 'Wallet transaction processed';
    }
  }
}
