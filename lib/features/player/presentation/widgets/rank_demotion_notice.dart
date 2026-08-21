import 'package:flutter/material.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/components/soteria_card.dart';
import '../../../../core/design_system/components/soteria_button.dart';
import '../../domain/models/rank_change.dart';
import 'rank_badge.dart';

class RankDemotionNotice extends StatelessWidget {
  final RankChange rankChange;
  final VoidCallback onContinue;

  const RankDemotionNotice({
    super.key,
    required this.rankChange,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SoteriaCard(
        margin: EdgeInsets.all(SoteriaSpacing.xl),
        padding: EdgeInsets.symmetric(
          vertical: SoteriaSpacing.xxl,
          horizontal: SoteriaSpacing.xl,
        ),
        hasGlow: true,
        glowColor: SoteriaColors.error,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'RANK CHANGE',
              style: context.headlineMedium.copyWith(
                color: SoteriaColors.textPrimary,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: SoteriaSpacing.xl),
            RankBadge(
              rankName: rankChange.newRank,
              tierId: rankChange.newRank.split(' ')[0].toLowerCase(),
            ),
            SizedBox(height: SoteriaSpacing.xxl),
            Text(
              rankChange.newRank.toUpperCase(),
              style: context.titleLarge.copyWith(
                color: SoteriaColors.textPrimary,
              ),
            ),
            SizedBox(height: SoteriaSpacing.sm),
            Text(
              '${rankChange.changeAmount} RANK POINTS',
              style: context.labelSmall.copyWith(
                color: SoteriaColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SoteriaSpacing.xxl),
            Text(
              'Competition is tough. Take a breath, analyze your games, and rise again.',
              textAlign: TextAlign.center,
              style: context.bodyMedium,
            ),
            SizedBox(height: SoteriaSpacing.xxl),
            SoteriaButton.secondary(
              label: 'UNDERSTOOD',
              onPressed: onContinue,
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}
