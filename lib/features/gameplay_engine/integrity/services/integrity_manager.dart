import 'package:flutter/widgets.dart';
import '../models/integrity_signal.dart';

/// Service responsible for collecting signals during a gameplay session.
class IntegrityManager with WidgetsBindingObserver {
  final List<IntegritySignal> _signals = [];
  final Function(IntegritySignal) onSignalCaptured;

  DateTime? _lastBackgroundedAt;
  int _backgroundSwitchCount = 0;
  bool _isMonitoring = false;

  IntegrityManager({required this.onSignalCaptured});

  void startMonitoring() {
    if (_isMonitoring) return;
    _isMonitoring = true;
    _signals.clear();
    _backgroundSwitchCount = 0;
    WidgetsBinding.instance.addObserver(this);
  }

  void stopMonitoring() {
    _isMonitoring = false;
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isMonitoring) return;

    if (state == AppLifecycleState.paused) {
      _lastBackgroundedAt = DateTime.now();
      _captureSignal(IntegritySignalType.appBackgrounded);
    } else if (state == AppLifecycleState.resumed) {
      if (_lastBackgroundedAt != null) {
        final duration = DateTime.now().difference(_lastBackgroundedAt!);
        _backgroundSwitchCount++;

        _captureSignal(
          IntegritySignalType.appResumed,
          metadata: {
            'durationMs': duration.inMilliseconds,
            'switchCount': _backgroundSwitchCount,
          },
        );

        if (_backgroundSwitchCount > 3) {
          _captureSignal(IntegritySignalType.repeatedBackgroundSwitch);
        }
      }
    }
  }

  /// Manually report a signal from other parts of the engine (e.g. TimerEngine)
  void reportSignal(
    IntegritySignalType type, {
    Map<String, dynamic> metadata = const {},
  }) {
    if (!_isMonitoring) return;
    _captureSignal(type, metadata: metadata);
  }

  void _captureSignal(
    IntegritySignalType type, {
    Map<String, dynamic> metadata = const {},
  }) {
    final signal = IntegritySignal(
      type: type,
      timestamp: DateTime.now(),
      metadata: metadata,
    );
    _signals.add(signal);
    onSignalCaptured(signal);
  }

  List<IntegritySignal> get signals => List.unmodifiable(_signals);
}
