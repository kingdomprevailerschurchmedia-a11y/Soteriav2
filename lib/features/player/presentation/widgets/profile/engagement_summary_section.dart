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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.local_fire_department_rounded, color: SoteriaColors.gold, size: 20.r),
                SizedBox(width: 12.w),
                Text(
                  'Engagement',
                  style: context.titleSmall.copyWith(
                    color: SoteriaColors.gold,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Text(
                    '${progression.dailyStreak} DAYS STREAK',
                    style: context.labelSmall.copyWith(
                      color: const Color(0xFF7C4DFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.chevron_right_rounded, color: const Color(0xFF7C4DFF), size: 18.r),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: SoteriaSpacing.md),
        _EngagementCard(
          current: progression.dailyStreak,
          best: progression.longestStreak,
        ),
      ],
    );
  }
}

class _EngagementCard extends StatelessWidget {
  final int current;
  final int best;

  const _EngagementCard({required this.current, required this.best});

  @override
  Widget build(BuildContext context) {
    return SoteriaCard(
      padding: EdgeInsets.all(16.r),
      borderRadius: 24,
      blur: 5.0,
      opacity: 0.02,
      borderColor: Colors.white.withValues(alpha: 0.1),
      child: Row(
        children: [
          Container(
            width: 72.r,
            height: 72.r,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Center(
              child: Icon(
                Icons.calendar_month_rounded,
                color: const Color(0xFF7C4DFF),
                size: 32.sp,
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Streak',
                  style: context.labelSmall.copyWith(
                    color: SoteriaColors.muted,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '$current DAYS',
                  style: context.headlineSmall.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 24.sp,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Best: $best',
                  style: context.labelSmall.copyWith(
                    color: Colors.white30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFB456FF), Color(0xFF7C4DFF)],
                ).createShader(bounds),
                child: Icon(
                  Icons.local_fire_department_rounded,
                  size: 48.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      width: 6.r,
                      height: 6.r,
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i < (current % 5 == 0 && current > 0 ? 5 : current % 5) 
                            ? const Color(0xFFB456FF) 
                            : Colors.white12,
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
