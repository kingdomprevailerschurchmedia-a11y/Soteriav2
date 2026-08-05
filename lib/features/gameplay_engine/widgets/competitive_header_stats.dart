import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/design_system/colors/soteria_colors.dart';
import '../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../core/design_system/typography/soteria_typography.dart';

class CompetitiveHeaderStats extends StatelessWidget {
  final int coinsAtRisk;
  final int potentialReward;
  final int streak;

  const CompetitiveHeaderStats({
    super.key,
    required this.coinsAtRisk,
    required this.potentialReward,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          'Competitive Stats: $coinsAtRisk coins at risk, $potentialReward potential reward, $streak current streak.',
      child: Container(
        padding: EdgeInsets.all(SoteriaSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _StatItem(
              label: 'AT RISK',
              value: coinsAtRisk.toString(),
              icon: Icons.monetization_on_rounded,
              color: SoteriaColors.error,
            ),
            _StatItem(
              label: 'REWARD',
              value: potentialReward.toString(),
              icon: Icons.emoji_events_rounded,
              color: SoteriaColors.gold,
            ),
            _StatItem(
              label: 'STREAK',
              value: streak.toString(),
              icon: Icons.bolt_rounded,
              color: SoteriaColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 14.sp),
            SizedBox(width: 4.w),
            Text(
              value,
              style: context.labelLarge.copyWith(
                fontWeight: FontWeight.w900,
                color: SoteriaColors.textPrimary,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: context.labelSmall.copyWith(
            color: SoteriaColors.muted,
            fontSize: 8.sp,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}
