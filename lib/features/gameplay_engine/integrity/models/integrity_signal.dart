enum IntegritySignalType {
  // Lifecycle Signals
  appBackgrounded,
  appResumed,
  screenLocked,
  repeatedBackgroundSwitch,

  // Timing Signals
  tooFastAnswer,
  impossibleResponseTime,
  identicalAnswerTiming,
  clockDriftDetected,
  timerAnomaly,

  // Gameplay Signals
  unexpectedInterruption,
  repeatedInvalidSubmissions,
  abnormalStreakPattern,
  lifelineAbuse,

  // Future/Placeholder Signals
  rootDetected,
  emulatorDetected,
  vpnDetected,
}

/// A specific telemetry signal that might indicate a risk to gameplay integrity.
class IntegritySignal {
  final IntegritySignalType type;
  final DateTime timestamp;
  final Map<String, dynamic> metadata;

  const IntegritySignal({
    required this.type,
    required this.timestamp,
    this.metadata = const {},
  });

  @override
  String toString() => 'IntegritySignal(type: $type, time: $timestamp)';
}
