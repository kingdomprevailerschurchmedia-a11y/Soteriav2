import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/design_system/animations/soteria_animations.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/models/timer_state.dart';

class QuizTimer extends StatefulWidget {
  const QuizTimer({super.key, required this.state});

  final TimerState state;

  @override
  State<QuizTimer> createState() => _QuizTimerState();
}

class _QuizTimerState extends State<QuizTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void didUpdateWidget(QuizTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.state.status == TimerStatus.critical &&
        !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    } else if (widget.state.status != TimerStatus.critical &&
        _pulseController.isAnimating) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final status = widget.state.status;
    final Color color = _getColor(status);
    final String timeStr = _formatDuration(widget.state.remainingTime);

    return Semantics(
      label: 'Timer: $timeStr remaining',
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final scale = 1.0 + (_pulseController.value * 0.05);
          return Transform.scale(
            scale: status == TimerStatus.critical ? scale : 1.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withValues(alpha: 0.3)),
                boxShadow: [
                  if (status == TimerStatus.critical)
                    BoxShadow(
                      color: color.withValues(alpha: 0.2),
                      blurRadius: 10 * _pulseController.value,
                      spreadRadius: 2 * _pulseController.value,
                    ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 18.sp,
                    color: color.withValues(alpha: 0.7),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    timeStr,
                    style: context.titleSmall.copyWith(
                      color: color,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getColor(TimerStatus status) {
    switch (status) {
      case TimerStatus.warning:
        return SoteriaColors.warning;
      case TimerStatus.critical:
      case TimerStatus.expired:
        return SoteriaColors.error;
      case TimerStatus.paused:
        return SoteriaColors.muted;
      default:
        return Colors.white;
    }
  }

  String _formatDuration(Duration duration) {
    final seconds = duration.inSeconds;
    return seconds.toString().padLeft(2, '0');
  }
}
