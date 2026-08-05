import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/components/soteria_badge.dart';
import '../models/competitive_settlement.dart';

class SettlementCard extends StatelessWidget {
  final CompetitiveSettlement? settlement;
  final bool isProcessing;

  const SettlementCard({super.key, this.settlement, this.isProcessing = false});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'COMPETITIVE SETTLEMENT',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isProcessing)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else if (settlement != null)
                SoteriaBadge(
                  label: settlement!.status.name.toUpperCase(),
                  variant: _getStatusVariant(settlement!.status),
                ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.lg),
          _SettlementRow(
            label: 'Entry Fee (Wagered)',
            value: '${settlement?.coinsWagered ?? 0}',
            icon: Icons.remove_circle_outline_rounded,
            iconColor: SoteriaColors.error,
          ),
          _SettlementRow(
            label: 'Coins Returned',
            value: '${settlement?.coinsWon ?? 0}',
            icon: Icons.add_circle_outline_rounded,
            iconColor: SoteriaColors.success,
          ),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'NET PROFIT',
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              _buildNetProfit(context),
            ],
          ),
          if (settlement?.settlementId != null) ...[
            SizedBox(height: SoteriaSpacing.md),
            Text(
              'Receipt: ${settlement!.settlementId}',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.muted,
                fontSize: 8.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNetProfit(BuildContext context) {
    if (settlement == null) return const Text('--');
    final profit = settlement!.coinsWon - settlement!.coinsWagered;
    final isPositive = profit >= 0;

    return Row(
      children: [
        Icon(
          isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
          color: isPositive ? SoteriaColors.success : SoteriaColors.error,
          size: 20,
        ),
        SizedBox(width: 4.w),
        Text(
          '${isPositive ? '+' : ''}$profit',
          style: context.titleLarge.copyWith(
            color: isPositive ? SoteriaColors.success : SoteriaColors.error,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  SoteriaBadgeVariant _getStatusVariant(SettlementStatus status) {
    switch (status) {
      case SettlementStatus.completed:
        return SoteriaBadgeVariant.success;
      case SettlementStatus.pending:
        return SoteriaBadgeVariant.warning;
      case SettlementStatus.failed:
        return SoteriaBadgeVariant.error;
      case SettlementStatus.offline:
        return SoteriaBadgeVariant.info;
    }
  }
}

class _SettlementRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _SettlementRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.bodyMedium.copyWith(
              color: SoteriaColors.textSecondary,
            ),
          ),
          Row(
            children: [
              Icon(icon, color: iconColor, size: 16),
              SizedBox(width: 4.w),
              Text(
                value,
                style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
