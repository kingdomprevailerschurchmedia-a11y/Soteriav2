import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/radius/soteria_radius.dart';
import '../../../../core/design_system/components/soteria_card.dart';

class DailyGoalsSection extends StatelessWidget {
  const DailyGoalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DAILY GOALS',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.textSecondary,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                'See All',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.secondary,
                  fontWeight: FontWeight.w900,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.xl),
          SoteriaCard(
            padding: EdgeInsets.all(SoteriaSpacing.lg),
            borderRadius: SoteriaRadius.xxl,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complete 3 goals to\nearn bonus XP!',
                        style: context.titleMedium.copyWith(
                          color: SoteriaColors.textPrimary,
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: SoteriaSpacing.md),
                Row(
                  children: [
                    _GoalProgressRing(
                      icon: Icons.menu_book_rounded,
                      progress: 0.0,
                      total: 1,
                      color: Colors.purpleAccent,
                    ),
                    SizedBox(width: 18.w),
                    _GoalProgressRing(
                      icon: Icons.bolt_rounded,
                      progress: 0.0,
                      total: 1,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(width: 18.w),
                    _GoalProgressRing(
                      icon: Icons.emoji_events_rounded,
                      progress: 0.0,
                      total: 1,
                      color: Colors.orangeAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalProgressRing extends StatelessWidget {
  const _GoalProgressRing({
    required this.icon,
    required this.progress,
    required this.total,
    required this.color,
  });

  final IconData icon;
  final double progress;
  final int total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 56.w,
              height: 56.w,
              child: CircularProgressIndicator(
                value: progress / total,
                strokeWidth: 4,
                backgroundColor: Colors.white.withValues(alpha: 0.05),
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: color.withValues(alpha: 0.2)),
              ),
              child: Icon(icon, size: 20.sp, color: color),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          '${progress.toInt()}/$total',
          style: context.labelSmall.copyWith(
            fontSize: 12.sp,
            color: SoteriaColors.textSecondary,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
