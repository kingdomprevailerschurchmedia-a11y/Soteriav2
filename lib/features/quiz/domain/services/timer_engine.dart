import '../../../../core/utils/clock.dart';
import '../models/timer_state.dart';
import '../models/quiz_enums.dart';

class TimerEngine {
  final Clock clock;
  static const int warningThresholdSeconds = 10;
  static const int criticalThresholdSeconds = 5;

  TimerEngine({required this.clock});

  TimerState createTimer(Duration totalDuration) {
    final now = clock.now();
    final deadline = now.add(totalDuration);
    return TimerState(
      totalDuration: totalDuration,
      remainingTime: totalDuration,
      deadline: deadline,
      status: TimerStatus.running,
      isRunning: true,
      progress: 1.0,
      isWarning: false,
      isCritical: false,
      hasExpired: false,
    );
  }

  TimerState tick(TimerState current) {
    if (!current.isRunning || current.deadline == null || current.hasExpired) {
      return current;
    }

    final now = clock.now();
    final remaining = current.deadline!.difference(now);

    if (remaining <= Duration.zero) {
      return current.copyWith(
        remainingTime: Duration.zero,
        progress: 0.0,
        status: TimerStatus.expired,
        hasExpired: true,
        isRunning: false,
        isWarning: false,
        isCritical: false,
      );
    }

    final progress =
        remaining.inMilliseconds / current.totalDuration.inMilliseconds;
    final remainingSeconds = remaining.inSeconds;

    TimerStatus status = TimerStatus.running;
    bool isWarning = false;
    bool isCritical = false;

    if (remainingSeconds <= criticalThresholdSeconds) {
      status = TimerStatus.critical;
      isCritical = true;
    } else if (remainingSeconds <= warningThresholdSeconds) {
      status = TimerStatus.warning;
      isWarning = true;
    }

    return current.copyWith(
      remainingTime: remaining,
      progress: progress.clamp(0.0, 1.0),
      status: status,
      isWarning: isWarning,
      isCritical: isCritical,
    );
  }

  TimerState pause(TimerState current) {
    if (!current.isRunning) return current;
    return current.copyWith(isRunning: false, status: TimerStatus.paused);
  }

  TimerState resume(TimerState current, Duration pausedDuration) {
    if (current.isRunning || current.deadline == null) return current;
    // Shift deadline forward by the paused duration so remaining time is preserved
    final newDeadline = current.deadline!.add(pausedDuration);
    return current.copyWith(
      isRunning: true,
      deadline: newDeadline,
      status: current.isCritical
          ? TimerStatus.critical
          : (current.isWarning ? TimerStatus.warning : TimerStatus.running),
    );
  }

  TimerState stop(TimerState current) {
    return current.copyWith(isRunning: false, status: TimerStatus.idle);
  }
}
