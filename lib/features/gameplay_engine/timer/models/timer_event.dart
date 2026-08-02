sealed class TimerEvent {}

class TimerStarted extends TimerEvent {
  final Duration duration;
  TimerStarted(this.duration);
}

class TimerPaused extends TimerEvent {
  final String reason; // 'manual', 'lifeline', 'background'
  TimerPaused(this.reason);
}

class TimerResumed extends TimerEvent {}

class TimerExpired extends TimerEvent {}

class TimerReset extends TimerEvent {}
