import 'package:flutter/material.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../../domain/models/season_result.dart';
import '../../../domain/models/player_profile.dart';

class CareerSummaryCard extends StatelessWidget {
  final CompetitiveHistory history;
  final PlayerProfile identity;
  final VoidCallback? onTap;

  const CareerSummaryCard({
    super.key,
    required this.history,
    required this.identity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final winRate = identity.gamesPlayed > 0
        ? (identity.gamesWon / identity.gamesPlayed * 100).toStringAsFixed(1)
        : '0.0';

    return SoteriaCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'COMPETITIVE CAREER',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: SoteriaSpacing.md),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 3.0,
            mainAxisSpacing: SoteriaSpacing.sm,
            crossAxisSpacing: SoteriaSpacing.md,
            children: [
              _SummaryItem(
                label: 'Seasons',
                value: history.results.length.toString(),
              ),
              _SummaryItem(label: 'Win Rate', value: '$winRate%'),
              _SummaryItem(
                label: 'Peak Rank',
                value: history.bestResult?.finalTier.toUpperCase() ?? 'N/A',
                isGold: true,
              ),
              _SummaryItem(
                label: 'Peak Pos',
                value: history.bestResult != null
                    ? '#${history.bestResult!.finalPosition} GLOBAL'
                    : 'N/A',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isGold;

  const _SummaryItem({
    required this.label,
    required this.value,
    this.isGold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: context.titleMedium.copyWith(
            color: isGold ? SoteriaColors.gold : SoteriaColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: context.bodySmall.copyWith(color: SoteriaColors.muted),
        ),
      ],
    );
  }
}
