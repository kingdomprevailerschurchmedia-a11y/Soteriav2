import 'package:soteria/features/gameplay_engine/timer/models/timer_status.dart';

class TimerState {
  final Duration remaining;
  final Duration total;
  final TimerStatus status;
  final bool isLifelinePaused;

  const TimerState({
    required this.remaining,
    required this.total,
    this.status = TimerStatus.idle,
    this.isLifelinePaused = false,
  });

  double get progress => total.inMilliseconds == 0
      ? 0.0
      : remaining.inMilliseconds / total.inMilliseconds;

  TimerState copyWith({
    Duration? remaining,
    Duration? total,
    TimerStatus? status,
    bool? isLifelinePaused,
  }) {
    return TimerState(
      remaining: remaining ?? this.remaining,
      total: total ?? this.total,
      status: status ?? this.status,
      isLifelinePaused: isLifelinePaused ?? this.isLifelinePaused,
    );
  }
}
