import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/integrity_signal.dart';
import '../models/integrity_event.dart';
import '../models/integrity_policy.dart';
import '../models/risk_assessment.dart';
import '../services/integrity_engine.dart';
import '../services/integrity_manager.dart';
import '../../models/game_mode.dart';

/// Notifier for managing integrity state during a session.
class IntegrityNotifier extends StateNotifier<RiskAssessment> {
  late final IntegrityManager _manager;
  final List<IntegritySignal> _capturedSignals = [];
  final List<IntegrityEvent> _eventQueue = [];

  IntegrityPolicy _currentPolicy = ProIntegrityPolicy();
  String _currentSessionId = '';
  GameMode _currentMode = GameMode.pro;

  IntegrityNotifier() : super(RiskAssessment.initial()) {
    _manager = IntegrityManager(onSignalCaptured: _handleNewSignal);
  }

  void startSession(String sessionId, GameMode mode) {
    _currentSessionId = sessionId;
    _currentMode = mode;
    _currentPolicy = IntegrityPolicyResolver.resolve(mode);
    _capturedSignals.clear();
    _eventQueue.clear();
    state = RiskAssessment.initial();
    _manager.startMonitoring();
  }

  void endSession() {
    _manager.stopMonitoring();
  }

  void reportManualSignal(
    IntegritySignalType type, {
    Map<String, dynamic> metadata = const {},
  }) {
    _manager.reportSignal(type, metadata: metadata);
  }

  void _handleNewSignal(IntegritySignal signal) {
    _capturedSignals.add(signal);

    // Evaluate new risk level
    final newAssessment = IntegrityEngine.evaluate(
      signals: _capturedSignals,
      policy: _currentPolicy,
    );

    state = newAssessment;

    // Create and queue an event
    final event = IntegrityEvent(
      sessionId: _currentSessionId,
      timestamp: signal.timestamp,
      signalType: signal.type,
      riskWeight: _currentPolicy.signalWeights[signal.type] ?? 0.0,
      lifecycleState: 'active', // Placeholder
      gameMode: _currentMode.name,
      context: signal.metadata,
    );

    _eventQueue.add(event);

    // Future: Persistence/Offline Sync logic here
  }

  List<IntegritySignal> get allSignals => List.unmodifiable(_capturedSignals);
  List<IntegrityEvent> get eventLog => List.unmodifiable(_eventQueue);

  @override
  void dispose() {
    _manager.stopMonitoring();
    super.dispose();
  }
}

final integrityProvider =
    StateNotifierProvider<IntegrityNotifier, RiskAssessment>((ref) {
      return IntegrityNotifier();
    });

final riskScoreProvider = Provider<double>(
  (ref) => ref.watch(integrityProvider).score,
);
final riskLevelProvider = Provider<RiskLevel>(
  (ref) => ref.watch(integrityProvider).level,
);
