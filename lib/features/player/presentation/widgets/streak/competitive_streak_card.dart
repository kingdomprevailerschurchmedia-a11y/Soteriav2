import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../../domain/models/competitive_streak.dart';

class CompetitiveStreakCard extends StatelessWidget {
  final CompetitiveStreak streak;

  const CompetitiveStreakCard({super.key, required this.streak});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      child: Row(
        children: [
          _buildFireIcon(context),
          SizedBox(width: SoteriaSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WIN STREAK',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  '${streak.current} GAMES',
                  style: context.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildStats(context),
        ],
      ),
    );
  }

  Widget _buildFireIcon(BuildContext context) {
    final intensity = (streak.current / 10).clamp(0.0, 1.0);
    final color =
        Color.lerp(SoteriaColors.gold, Colors.orange, intensity) ??
        SoteriaColors.gold;

    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.local_fire_department_rounded,
        color: color,
        size: 24.sp,
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'BEST: ${streak.best}',
          style: context.labelSmall.copyWith(color: SoteriaColors.muted),
        ),
        Text(
          'SEASON: ${streak.seasonBest}',
          style: context.labelSmall.copyWith(color: SoteriaColors.muted),
        ),
      ],
    );
  }
}
