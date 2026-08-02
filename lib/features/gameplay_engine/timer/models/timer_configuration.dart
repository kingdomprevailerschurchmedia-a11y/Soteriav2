class TimerConfiguration {
  final Duration warningThreshold;
  final Duration criticalThreshold;
  final Duration defaultPauseDuration;

  const TimerConfiguration({
    this.warningThreshold = const Duration(seconds: 5),
    this.criticalThreshold = const Duration(seconds: 3),
    this.defaultPauseDuration = const Duration(seconds: 10),
  });
}
