import 'integrity_signal.dart';

/// An immutable record of an integrity incident.
class IntegrityEvent {
  final String sessionId;
  final String? questionId;
  final DateTime timestamp;
  final IntegritySignalType signalType;
  final double riskWeight;
  final String lifecycleState;
  final String gameMode;
  final Map<String, dynamic> context;

  const IntegrityEvent({
    required this.sessionId,
    this.questionId,
    required this.timestamp,
    required this.signalType,
    required this.riskWeight,
    required this.lifecycleState,
    required this.gameMode,
    this.context = const {},
  });

  Map<String, dynamic> toJson() => {
    'sessionId': sessionId,
    'questionId': questionId,
    'timestamp': timestamp.toIso8601String(),
    'signalType': signalType.name,
    'riskWeight': riskWeight,
    'lifecycleState': lifecycleState,
    'gameMode': gameMode,
    'context': context,
  };
}
