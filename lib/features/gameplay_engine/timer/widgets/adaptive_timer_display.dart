import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/core/design_system/colors/soteria_colors.dart';
import 'package:soteria/core/design_system/typography/soteria_typography.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_state.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_status.dart';
import 'package:soteria/features/gameplay_engine/timer/services/timer_formatter.dart';

class AdaptiveTimerDisplay extends StatelessWidget {
  const AdaptiveTimerDisplay({super.key, required this.state, this.size = 64});

  final TimerState state;
  final double size;

  @override
  Widget build(BuildContext context) {
    Color color = SoteriaColors.primary;
    bool shouldPulse = false;

    switch (state.status) {
      case TimerStatus.warning:
        color = SoteriaColors.gold;
        break;
      case TimerStatus.critical:
        color = SoteriaColors.error;
        shouldPulse = true;
        break;
      case TimerStatus.expired:
        color = SoteriaColors.muted;
        break;
      case TimerStatus.paused:
        color = SoteriaColors.secondary;
        break;
      default:
        color = SoteriaColors.primary;
    }

    return Semantics(
      label: 'Time remaining: ${state.remaining.inSeconds} seconds',
      liveRegion: true,
      child: SizedBox(
        width: size.w,
        height: size.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _CircularProgress(
              progress: state.progress,
              color: color,
              isPaused: state.status == TimerStatus.paused,
            ),
            if (shouldPulse)
              _PulseAnimation(
                color: color,
                child: _TimerText(state: state, color: color),
              )
            else
              _TimerText(state: state, color: color),
          ],
        ),
      ),
    );
  }
}

class _CircularProgress extends StatelessWidget {
  const _CircularProgress({
    required this.progress,
    required this.color,
    required this.isPaused,
  });

  final double progress;
  final Color color;
  final bool isPaused;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: progress,
      strokeWidth: 4.w,
      backgroundColor: Colors.white.withValues(alpha: 0.1),
      color: color,
    );
  }
}

class _TimerText extends StatelessWidget {
  const _TimerText({required this.state, required this.color});

  final TimerState state;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      TimerFormatter.format(state.remaining),
      style: context.labelSmall.copyWith(
        color: color,
        fontWeight: FontWeight.w900,
        fontSize: state.remaining.inSeconds < 10 ? 16.sp : 14.sp,
      ),
    );
  }
}

class _PulseAnimation extends StatefulWidget {
  const _PulseAnimation({required this.child, required this.color});
  final Widget child;
  final Color color;

  @override
  State<_PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<_PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.6, end: 1.0).animate(_controller),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.95, end: 1.05).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: widget.child,
      ),
    );
  }
}
