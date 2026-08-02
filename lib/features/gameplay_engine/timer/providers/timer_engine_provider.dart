import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_state.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_status.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_configuration.dart';

import 'package:soteria/features/gameplay_engine/integrity/providers/integrity_providers.dart';
import 'package:soteria/features/gameplay_engine/integrity/models/integrity_signal.dart';

class TimerEngine extends StateNotifier<TimerState> {
  Timer? _ticker;
  final TimerConfiguration config;
  DateTime? _lastTickTime;

  // Callbacks for Story 3.8 Anti-Cheat & Story 3.10 Analytics
  void Function(String, {Map<String, dynamic> metadata})? onEventEmitted;

  TimerEngine({this.config = const TimerConfiguration(), this.onEventEmitted})
    : super(const TimerState(remaining: Duration.zero, total: Duration.zero));

  /// Helper for testing to access protected state.
  @override
  TimerState get debugState => state;

  void start(Duration duration) {
    _ticker?.cancel();
    _lastTickTime = DateTime.now();
    state = TimerState(
      remaining: duration,
      total: duration,
      status: TimerStatus.running,
    );
    onEventEmitted?.call('Timer Started');
    _resumeTicker();
  }

  void pause({String reason = 'manual'}) {
    if (state.status == TimerStatus.running ||
        state.status == TimerStatus.warning ||
        state.status == TimerStatus.critical) {
      _ticker?.cancel();
      state = state.copyWith(status: TimerStatus.paused);
      onEventEmitted?.call('Timer Paused: $reason');
    }
  }

  void resume() {
    if (state.status == TimerStatus.paused) {
      state = state.copyWith(status: _evaluateStatus(state.remaining));
      onEventEmitted?.call('Timer Resumed');
      _resumeTicker();
    }
  }

  /// Implements the Pause Timer lifeline logic (Story 3.6 placeholder)
  Future<void> triggerPauseLifeline(Duration? overrideDuration) async {
    if (state.isLifelinePaused) return;

    final pauseDuration = overrideDuration ?? config.defaultPauseDuration;

    _ticker?.cancel();
    state = state.copyWith(status: TimerStatus.paused, isLifelinePaused: true);
    onEventEmitted?.call('Lifeline: Pause Timer Used');

    await Future.delayed(pauseDuration);

    if (mounted) {
      state = state.copyWith(
        status: _evaluateStatus(state.remaining),
        isLifelinePaused: false,
      );
      _resumeTicker();
      onEventEmitted?.call('Lifeline: Pause Timer Expired');
    }
  }

  void reset() {
    _ticker?.cancel();
    state = const TimerState(
      remaining: Duration.zero,
      total: Duration.zero,
      status: TimerStatus.idle,
    );
    onEventEmitted?.call('Timer Reset');
  }

  void _resumeTicker() {
    _lastTickTime = DateTime.now();
    _ticker = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final now = DateTime.now();
      final elapsedWallClock = now.difference(_lastTickTime!).inMilliseconds;
      _lastTickTime = now;

      // Wall-clock drift detection: if more than 500ms passed in a 100ms interval
      if (elapsedWallClock > 500) {
        onEventEmitted?.call(
          'Clock Drift Detected',
          metadata: {'driftMs': elapsedWallClock},
        );
      }

      final newRemaining = state.remaining - const Duration(milliseconds: 100);

      if (newRemaining <= Duration.zero) {
        timer.cancel();
        state = state.copyWith(
          remaining: Duration.zero,
          status: TimerStatus.expired,
        );
        onEventEmitted?.call('Timer Expired');
      } else {
        state = state.copyWith(
          remaining: newRemaining,
          status: _evaluateStatus(newRemaining),
        );
      }
    });
  }

  TimerStatus _evaluateStatus(Duration remaining) {
    if (remaining <= config.criticalThreshold) return TimerStatus.critical;
    if (remaining <= config.warningThreshold) return TimerStatus.warning;
    return TimerStatus.running;
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}

final timerEngineProvider =
    StateNotifierProvider.autoDispose<TimerEngine, TimerState>((ref) {
      final integrity = ref.watch(integrityProvider.notifier);

      return TimerEngine(
        onEventEmitted: (name, {metadata = const {}}) {
          if (name == 'Clock Drift Detected') {
            integrity.reportManualSignal(
              IntegritySignalType.clockDriftDetected,
              metadata: metadata,
            );
          }
        },
      );
    });
