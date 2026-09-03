import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../../core/design_system/components/soteria_card.dart';
import '../../../domain/models/player_progression.dart';
import '../../../domain/models/competitive_streak.dart';
import '../streak/competitive_streak_card.dart';

class EngagementSummarySection extends StatelessWidget {
  final PlayerProgression progression;
  final CompetitiveStreak? winStreak;

  const EngagementSummarySection({
    super.key,
    required this.progression,
    this.winStreak,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ENGAGEMENT',
          style: context.labelSmall.copyWith(
            color: SoteriaColors.gold,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w800,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: SoteriaSpacing.md),
        _DailyStreakCard(
          current: progression.dailyStreak,
          best: progression.longestStreak,
        ),
      ],
    );
  }
}

class _DailyStreakCard extends StatelessWidget {
  final int current;
  final int best;

  const _DailyStreakCard({required this.current, required this.best});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      padding: EdgeInsets.all(20.r),
      child: Row(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: SoteriaColors.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: SoteriaColors.secondary.withValues(alpha: 0.2),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.calendar_month_rounded,
                color: SoteriaColors.secondary,
                size: 32.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DAILY STREAK',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    letterSpacing: 1.2,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '$current DAYS',
                  style: context.headlineSmall.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Best: $best',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF7C4DFF), Color(0xFFFF4DFF)],
                ).createShader(bounds),
                child: Icon(
                  Icons.local_fire_department_rounded,
                  size: 44.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      width: 6.w,
                      height: 6.w,
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == 0 ? SoteriaColors.secondary : Colors.white10,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
