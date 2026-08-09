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
    required this.timerState,
  });

  final int streak;
  final TimerState? timerState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SoteriaSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStreakIndicator(context),
          if (timerState != null) QuizTimer(state: timerState!),
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

  Widget _buildTimerIndicator(BuildContext context) {
    final remainingSeconds = timerState!.remainingTime.inSeconds;
    final bool isWarning = remainingSeconds <= 5;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isWarning
            ? SoteriaColors.error.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isWarning
              ? SoteriaColors.error.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_outlined,
            size: 18.sp,
            color: isWarning ? SoteriaColors.error : Colors.white70,
          ),
          SizedBox(width: 8.w),
          Text(
            _formatDuration(timerState!.remainingTime),
            style: context.titleSmall.copyWith(
              color: isWarning ? SoteriaColors.error : Colors.white,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final seconds = duration.inSeconds;
    return seconds.toString().padLeft(2, '0');
  }
}
