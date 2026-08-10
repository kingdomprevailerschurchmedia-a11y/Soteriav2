import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../domain/models/timer_state.dart';
import 'quiz_timer.dart';

class QuizStatsBar extends StatelessWidget {
  const QuizStatsBar({
    super.key,
    required this.streak,
    required this.xp,
    required this.timerState,
    this.powerUpTimerState,
  });

  final int streak;
  final int xp;
  final TimerState? timerState;
  final TimerState? powerUpTimerState;

  @override
  Widget build(BuildContext context) {
    final isPausedByPowerUp =
        powerUpTimerState != null && powerUpTimerState!.isRunning;

    return Semantics(
      label: 'Quiz Statistics: $streak streak, $xp experience points',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildStreakIndicator(context),
                SizedBox(width: 24.w),
                _buildXPIndicator(context),
              ],
            ),
            if (isPausedByPowerUp)
              _buildPausedIndicator(context)
            else if (timerState != null)
              QuizTimer(state: timerState!),
          ],
        ),
      ),
    );
  }

  Widget _buildPausedIndicator(BuildContext context) {
    final remainingSeconds = powerUpTimerState!.remainingTime.inSeconds;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: SoteriaColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SoteriaColors.primary.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: SoteriaColors.primary.withValues(alpha: 0.3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'PAUSED',
            style: context.labelSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            remainingSeconds.toString(),
            style: context.titleSmall.copyWith(
              color: SoteriaColors.secondary,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXPIndicator(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: SoteriaColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            xp.toString(),
            style: context.titleSmall.copyWith(
              color: SoteriaColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            'XP',
            style: context.labelSmall.copyWith(
              color: SoteriaColors.primary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakIndicator(BuildContext context) {
    final bool hasStreak = streak > 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '🔥',
          style: TextStyle(
            fontSize: 20.sp,
            color: hasStreak ? null : Colors.white24,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          streak.toString(),
          style: context.titleLarge.copyWith(
            color: hasStreak ? SoteriaColors.warning : SoteriaColors.muted,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          'STREAK',
          style: context.labelSmall.copyWith(
            color: hasStreak
                ? SoteriaColors.warning.withValues(alpha: 0.7)
                : SoteriaColors.muted,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}
