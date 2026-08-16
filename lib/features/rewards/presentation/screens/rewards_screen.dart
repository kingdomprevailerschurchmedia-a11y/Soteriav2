import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../providers/rewards_providers.dart';
import '../widgets/wallet_balance_header.dart';
import '../widgets/reward_card.dart';
import '../../domain/models/coin_bundle.dart';
import '../../domain/models/reward_transaction.dart';

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
    _tabController = TabController(length: 3, vsync: this);
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: SoteriaColors.textPrimary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Rewards & Economy',
            style: TextStyle(
              color: SoteriaColors.textPrimary,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: SoteriaColors.primary,
            labelColor: SoteriaColors.textPrimary,
            unselectedLabelColor: SoteriaColors.textSecondary,
            tabs: const [
              Tab(text: 'Earn'),
              Tab(text: 'Store'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _EarnTab(),
            _StoreTab(),
            _HistoryTab(),
          ],
        ),
      ),
    );
  }
}

class _EarnTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rewardsAsync = ref.watch(availableRewardsProvider);

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.containerPadding(context)),
      children: [
        const WalletBalanceHeader(),
        SoteriaSpacing.gapLG,
        Text(
          'Available Rewards',
          style: TextStyle(
            color: SoteriaColors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
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
                    'No rewards available yet.\nKeep playing to unlock more!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: SoteriaColors.textSecondary),
                  ),
                ),
              );
            }
            return Column(
              children: rewards.map((r) => RewardCard(reward: r)).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error loading rewards')),
        ),
      ],
    );
  }
}

class _StoreTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bundlesAsync = ref.watch(coinBundlesProvider);

    return ListView(
      padding: EdgeInsets.all(SoteriaSpacing.containerPadding(context)),
      children: [
        Text(
          'Coin Bundles',
          style: TextStyle(
            color: SoteriaColors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SoteriaSpacing.gapMD,
        bundlesAsync.when(
          data: (bundles) => Column(
            children: bundles.map((b) => _buildBundleCard(context, ref, b)).toList(),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error loading store')),
        ),
      ],
    );
  }

  Widget _buildBundleCard(BuildContext context, WidgetRef ref, CoinBundle bundle) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: SoteriaCard(
        onTap: () => ref.read(rewardsControllerProvider.notifier).purchaseBundle(bundle.id),
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
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4.w,
                    children: [
                      Text(
                        '${bundle.coins} Coins',
                        style: TextStyle(
                          color: SoteriaColors.gold,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (bundle.bonusCoins > 0)
                        Text(
                          '+${bundle.bonusCoins} Bonus',
                          style: TextStyle(
                            color: SoteriaColors.success,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
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
                bundle.displayPrice ?? '\$${bundle.price}',
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
          padding: EdgeInsets.all(SoteriaSpacing.containerPadding(context)),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final tx = transactions[index];
            final isCredit = tx.direction == TransactionDirection.credit;
            
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: SoteriaCard(
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    Icon(
                      isCredit ? Icons.add_circle_outline : Icons.remove_circle_outline,
                      color: isCredit ? SoteriaColors.success : SoteriaColors.error,
                      size: 20.r,
                    ),
                    SoteriaSpacing.gapMD,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx.source.name.replaceAll(RegExp(r'(?=[A-Z])'), ' ').toUpperCase(),
                            style: TextStyle(
                              color: SoteriaColors.textPrimary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${tx.createdAt.day}/${tx.createdAt.month}/${tx.createdAt.year}',
                            style: TextStyle(
                              color: SoteriaColors.textSecondary,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${isCredit ? '+' : '-'}${tx.amount}',
                      style: TextStyle(
                        color: isCredit ? SoteriaColors.success : SoteriaColors.error,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error loading history')),
    );
  }
}
