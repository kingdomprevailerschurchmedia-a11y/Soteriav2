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
        Row(
          children: [
            Expanded(
              child: _DailyStreakCard(
                current: progression.dailyStreak,
                best: progression.longestStreak,
              ),
            ),
            if (winStreak != null) ...[
              SizedBox(width: SoteriaSpacing.md),
              Expanded(
                child: CompetitiveStreakCard(streak: winStreak!),
              ),
            ],
          ],
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
      padding: EdgeInsets.all(SoteriaSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                color: SoteriaColors.primary,
                size: 16.sp,
              ),
              SizedBox(width: SoteriaSpacing.xs),
              Text(
                'DAILY STREAK',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  fontSize: 8.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: SoteriaSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$current',
                style: context.headlineSmall.copyWith(
                  fontWeight: FontWeight.w900,
                  color: SoteriaColors.primary,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                'DAYS',
                style: context.labelSmall.copyWith(
                  color: SoteriaColors.muted,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            'BEST: $best',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.muted,
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }
}
