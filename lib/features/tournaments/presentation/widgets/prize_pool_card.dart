import 'package:flutter/material.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/components/soteria_card.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class PrizePoolCard extends StatelessWidget {
  final double totalPrizePool;
  final List<PrizeDistribution> distribution;

  const PrizePoolCard({
    super.key,
    required this.totalPrizePool,
    required this.distribution,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Tournament prize pool distribution',
      child: SoteriaCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PRIZE POOL DISTRIBUTION',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.muted,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: SoteriaSpacing.md),
            Text(
              '₦${totalPrizePool.toStringAsFixed(0)}',
              style: context.displaySmall.copyWith(
                color: SoteriaColors.gold,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: SoteriaSpacing.lg),
            ...distribution.map((d) => _PrizeRow(prize: d)),
          ],
        ),
      ),
    );
  }
}

class PrizeDistribution {
  final String rank;
  final double amount;
  final double percentage;

  const PrizeDistribution({
    required this.rank,
    required this.amount,
    required this.percentage,
  });
}

class _PrizeRow extends StatelessWidget {
  final PrizeDistribution prize;
  const _PrizeRow({required this.prize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SoteriaSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            prize.rank,
            style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Text(
                '${prize.percentage.toStringAsFixed(0)}%',
                style: context.bodySmall,
              ),
              SizedBox(width: SoteriaSpacing.md),
              Text(
                '₦${prize.amount.toStringAsFixed(0)}',
                style: context.titleMedium.copyWith(color: SoteriaColors.gold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
