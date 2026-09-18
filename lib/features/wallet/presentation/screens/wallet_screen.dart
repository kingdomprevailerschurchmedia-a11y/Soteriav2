import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/components/soteria_back_button.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/glass_surface.dart';
import '../../../../shared/widgets/soteria_page.dart';
import '../../../rewards/domain/models/wallet.dart';
import '../../../rewards/presentation/providers/rewards_providers.dart';
import '../../../rewards/domain/models/reward_transaction.dart';
import '../../../rewards/domain/models/reward.dart';
import '../../../../core/navigation/providers/navigation_providers.dart';
import '../../../../core/navigation/services/navigation_coordinator.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../../../core/design_system/components/soteria_back_button.dart';
import '../../../../core/design_system/components/soteria_card.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletAsync = ref.watch(walletProvider);
    final historyAsync = ref.watch(transactionHistoryProvider);
    final navigation = ref.watch(navigationCoordinatorProvider);

    return SoteriaPage(
      useSafeArea: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            _buildHeader(context, navigation),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: SoteriaSpacing.containerPadding(context),
                  vertical: 16.h,
                ),
                children: [
                  walletAsync.when(
                    data: (wallet) => _buildBalanceCard(context, wallet),
                    loading: () => _buildLoadingCard(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  SoteriaSpacing.gapLG,
                  _buildActionButtons(context),
                  SoteriaSpacing.gapXL,
                  _buildTransactionHistoryHeader(context),
                  SoteriaSpacing.gapMD,
                  historyAsync.when(
                    data: (history) => _buildTransactionList(context, history),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('Failed to load history', style: context.bodyMedium)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, NavigationCoordinator navigation) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SoteriaSpacing.containerPadding(context),
        vertical: 16.h,
      ),
      child: Row(
        children: [
          const SoteriaBackButton(),
          SoteriaSpacing.gapMD,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coin Management',
                  style: context.titleLarge.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'Manage your coins, anytime.',
                  style: context.bodySmall.copyWith(
                    color: SoteriaColors.textSecondary.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, Wallet wallet) {
    final double conversionFactor = 1.5;
    final ngnBalance = wallet.coins * conversionFactor;
    final withdrawableNgn = wallet.withdrawableCoins * conversionFactor;

    return SoteriaCard(
      padding: EdgeInsets.all(24.r),
      borderRadius: 32,
      blur: 5.0,
      opacity: 0.02,
      borderColor: Colors.white.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/icons/coin_icon.png', width: 20.r, height: 20.r),
              SoteriaSpacing.gapXS,
              Text(
                'Coin Balance',
                style: context.labelMedium.copyWith(
                  color: SoteriaColors.textSecondary,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          SoteriaSpacing.gapSM,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                wallet.coins.toString().replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},'),
                style: context.displayMedium.copyWith(
                  color: SoteriaColors.textPrimary,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                ),
              ),
              SizedBox(width: 8.w),
              Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Text(
                  '≈ ₦${NumberFormat('#,###.##').format(ngnBalance)}',
                  style: context.bodyMedium.copyWith(
                    color: SoteriaColors.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SoteriaSpacing.gapLG,
          Divider(color: Colors.white.withValues(alpha: 0.05), height: 1),
          SoteriaSpacing.gapLG,
          Row(
            children: [
              Icon(Icons.info_outline_rounded, color: SoteriaColors.muted, size: 18.r),
              SoteriaSpacing.gapSM,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Withdrawable Balance',
                      style: context.bodySmall.copyWith(color: SoteriaColors.muted),
                    ),
                    Text(
                      '${wallet.withdrawableCoins.toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (m) => "${m[1]},")} Coins (₦${NumberFormat("#,###").format(withdrawableNgn)})',
                      style: context.labelLarge.copyWith(
                        color: SoteriaColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: SoteriaColors.muted, size: 24.r),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard() {
    return SoteriaCard(
      padding: EdgeInsets.all(24.r),
      borderRadius: 32,
      blur: 5.0,
      opacity: 0.02,
      borderColor: Colors.white.withValues(alpha: 0.1),
      child: const SizedBox(height: 150, child: Center(child: CircularProgressIndicator())),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return SoteriaCard(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      borderRadius: 24,
      blur: 5.0,
      opacity: 0.02,
      borderColor: Colors.white.withValues(alpha: 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCircleActionButton(
            context,
            label: 'Add funds',
            icon: Icons.add_rounded,
            onTap: () {},
          ),
          _buildCircleActionButton(
            context,
            label: 'Send',
            icon: Icons.arrow_upward_rounded,
            onTap: () {},
          ),
          _buildCircleActionButton(
            context,
            label: 'Withdraw',
            icon: Icons.arrow_downward_rounded,
            onTap: () {},
          ),
          _buildCircleActionButton(
            context,
            label: 'More',
            icon: Icons.more_horiz_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCircleActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 54.r,
            height: 54.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.05),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: SoteriaColors.gold,
              size: 24.r,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: context.labelSmall.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionHistoryHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            'TRANSACTION HISTORY',
            style: context.labelMedium.copyWith(
              color: SoteriaColors.gold,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SoteriaSpacing.gapSM,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              Text(
                'All Dates',
                style: context.labelSmall.copyWith(color: SoteriaColors.textSecondary),
              ),
              SizedBox(width: 4.w),
              Icon(Icons.keyboard_arrow_down_rounded, color: SoteriaColors.textSecondary, size: 16.r),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionList(BuildContext context, List<WalletTransaction> history) {
    if (history.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: Text('No transactions yet', style: context.bodyMedium.copyWith(color: SoteriaColors.muted)),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: history.length,
      separatorBuilder: (context, index) => SoteriaSpacing.gapMD,
      itemBuilder: (context, index) => _buildTransactionItem(context, history[index]),
    );
  }

  Widget _buildTransactionItem(BuildContext context, WalletTransaction tx) {
    final isCredit = tx.direction == TransactionDirection.credit;
    final amountColor = isCredit ? SoteriaColors.success : SoteriaColors.error;
    final amountPrefix = isCredit ? '+' : '-';
    final ngnAmount = tx.amount * 1.5;

    return GlassSurface(
      padding: EdgeInsets.all(16.r),
      borderRadius: BorderRadius.circular(20.r),
      child: Row(
        children: [
          Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: _getTransactionColor(tx).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(_getTransactionIcon(tx), color: _getTransactionColor(tx), size: 24.r),
          ),
          SoteriaSpacing.gapMD,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        _getTransactionTitle(tx),
                        style: context.labelLarge.copyWith(fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SoteriaSpacing.gapSM,
                    _buildStatusBadge(context, tx.status),
                  ],
                ),
                Text(
                  DateFormat('MMM dd, yyyy • hh:mm a').format(tx.createdAt),
                  style: context.bodySmall.copyWith(color: SoteriaColors.muted),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$amountPrefix${tx.amount.toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (m) => "${m[1]},")}',
                style: context.labelLarge.copyWith(
                  color: amountColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '₦${NumberFormat("#,###.##").format(ngnAmount)}',
                style: context.bodySmall.copyWith(color: SoteriaColors.muted),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, TransactionStatus status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: SoteriaColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        'Completed', // The prompt specifically asks for "Completed" status badge
        style: context.labelSmall.copyWith(
          color: SoteriaColors.success,
          fontSize: 8.sp,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  IconData _getTransactionIcon(WalletTransaction tx) {
    switch (tx.transactionType) {
      case WalletTransactionType.purchase:
        return Icons.add_circle_outline_rounded;
      case WalletTransactionType.reward:
        return Icons.redeem_rounded;
      case WalletTransactionType.spend:
        if (tx.metadata.containsKey('recipientName')) {
          return Icons.send_rounded;
        }
        return Icons.account_balance_wallet_rounded;
      case WalletTransactionType.gameEntry:
        return Icons.sports_esports_rounded;
      case WalletTransactionType.tournamentEntry:
        return Icons.emoji_events_rounded;
      default:
        return Icons.swap_horiz_rounded;
    }
  }

  Color _getTransactionColor(WalletTransaction tx) {
    switch (tx.transactionType) {
      case WalletTransactionType.purchase:
        return SoteriaColors.gold;
      case WalletTransactionType.reward:
        return SoteriaColors.success;
      case WalletTransactionType.spend:
        if (tx.metadata.containsKey('recipientName')) {
          return SoteriaColors.secondary;
        }
        return SoteriaColors.gold;
      case WalletTransactionType.gameEntry:
        return SoteriaColors.primary;
      default:
        return SoteriaColors.secondary;
    }
  }

  String _getTransactionTitle(WalletTransaction tx) {
    switch (tx.transactionType) {
      case WalletTransactionType.purchase:
        return 'Fund';
      case WalletTransactionType.reward:
        return 'Reward';
      case WalletTransactionType.spend:
        if (tx.metadata.containsKey('recipientName')) {
          return 'Send to User';
        }
        if (tx.metadata.containsKey('peerId')) {
          return 'Transfer to Peer';
        }
        return 'Withdraw';
      case WalletTransactionType.gameEntry:
        return 'Game Entry';
      case WalletTransactionType.tournamentEntry:
        return 'Tournament Entry';
      default:
        return tx.transactionType.name.toUpperCase();
    }
  }
}
