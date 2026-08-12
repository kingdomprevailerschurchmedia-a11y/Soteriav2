import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/components/soteria_card.dart';

class WinRateCard extends StatelessWidget {
  final double winRate;
  final int wins;
  final int losses;

  const WinRateCard({
    super.key,
    required this.winRate,
    required this.wins,
    required this.losses,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Career win rate: ${(winRate * 100).toStringAsFixed(1)} percent',
      value: '${(winRate * 100).toInt()}%',
      child: SoteriaCard(
        hasGlow: winRate >= 0.7,
        glowColor: SoteriaColors.success,
        child: Row(
          children: [
            _buildRadialProgress(context),
            SizedBox(width: SoteriaSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WIN RATE',
                    style: context.labelSmall.copyWith(
                      color: SoteriaColors.muted,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    '${(winRate * 100).toStringAsFixed(1)}%',
                    style: context.headlineMedium.copyWith(
                      color: winRate >= 0.5
                          ? SoteriaColors.success
                          : SoteriaColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SoteriaSpacing.xs),
                  Row(
                    children: [
                      _buildStatMini(
                        context,
                        'Wins',
                        wins,
                        SoteriaColors.success,
                      ),
                      SizedBox(width: SoteriaSpacing.md),
                      _buildStatMini(
                        context,
                        'Losses',
                        losses,
                        SoteriaColors.error,
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

  Widget _buildRadialProgress(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 80.w,
          height: 80.w,
          child: CircularProgressIndicator(
            value: winRate,
            strokeWidth: 8,
            backgroundColor: Colors.white.withValues(alpha: 0.05),
            valueColor: AlwaysStoppedAnimation<Color>(
              winRate >= 0.7
                  ? SoteriaColors.success
                  : winRate >= 0.5
                  ? SoteriaColors.primary
                  : SoteriaColors.error,
            ),
          ),
        ),
        Icon(
          Icons.emoji_events_rounded,
          color: winRate >= 0.7 ? SoteriaColors.gold : SoteriaColors.muted,
          size: 32.w,
        ),
      ],
    );
  }

  Widget _buildStatMini(
    BuildContext context,
    String label,
    int value,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value.toString(),
          style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          label.toUpperCase(),
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 8.sp,
          ),
        ),
      ],
    );
  }
}
