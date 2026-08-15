import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/radius/soteria_radius.dart';
import 'package:soteria/core/design_system/spacing/soteria_spacing.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';

class StreakCard extends StatelessWidget {
  final int currentStreak;
  final int longestStreak;
  final bool isEngagedToday;

  const StreakCard({
    super.key,
    required this.currentStreak,
    required this.longestStreak,
    required this.isEngagedToday,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SoteriaSpacing.lg),
      decoration: BoxDecoration(
        color: SoteriaColors.surface,
        borderRadius: SoteriaRadius.brMd,
        border: Border.all(
          color: SoteriaColors.textPrimary.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          // Fire Icon with Glow
          Container(
            padding: EdgeInsets.all(SoteriaSpacing.sm),
            decoration: BoxDecoration(
              color: isEngagedToday 
                  ? Colors.orange.withValues(alpha: 0.1)
                  : SoteriaColors.muted.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_fire_department_rounded,
              color: isEngagedToday ? Colors.orange : SoteriaColors.muted,
              size: 32.sp,
            ),
          ),
          SizedBox(width: SoteriaSpacing.md),
          // Streak Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$currentStreak Day Streak',
                  style: context.titleMedium.copyWith(
                    color: SoteriaColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isEngagedToday 
                      ? "Today's goal completed!"
                      : "Complete an activity to keep your streak!",
                  style: context.bodySmall.copyWith(
                    color: isEngagedToday ? SoteriaColors.success : SoteriaColors.muted,
                  ),
                ),
              ],
            ),
          ),
          // Longest Streak Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Personal Best',
                style: context.labelSmall.copyWith(color: SoteriaColors.muted),
              ),
              Text(
                '$longestStreak',
                style: context.titleSmall.copyWith(
                  color: SoteriaColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
