import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_status.dart';
import 'package:soteria/features/gameplay_engine/timer/providers/timer_engine_provider.dart';

void main() {
  group('TimerEngine Tests', () {
    test('initial state is idle', () {
      final engine = TimerEngine();
      expect(engine.debugState.status, TimerStatus.idle);
      expect(engine.debugState.remaining, Duration.zero);
    });

    test('start begins countdown', () async {
      final engine = TimerEngine();
      engine.start(const Duration(seconds: 10));

      expect(engine.debugState.status, TimerStatus.running);
      expect(engine.debugState.remaining, const Duration(seconds: 10));

      // Wait a bit and check if it decreased
      await Future.delayed(const Duration(milliseconds: 300));
      expect(engine.debugState.remaining.inMilliseconds, lessThan(10000));
    });

    test('pause stops countdown', () async {
      final engine = TimerEngine();
      engine.start(const Duration(seconds: 10));
      engine.pause();

      expect(engine.debugState.status, TimerStatus.paused);
      final remaining = engine.debugState.remaining;

      await Future.delayed(const Duration(milliseconds: 300));
      expect(engine.debugState.remaining, remaining); // Should not have changed
    });

    test('resume continues countdown', () async {
      final engine = TimerEngine();
      engine.start(const Duration(seconds: 10));
      engine.pause();
      final pausedRemaining = engine.debugState.remaining;

      engine.resume();
      expect(engine.debugState.status, TimerStatus.running);

      await Future.delayed(const Duration(milliseconds: 300));
      expect(
        engine.debugState.remaining.inMilliseconds,
        lessThan(pausedRemaining.inMilliseconds),
      );
    });

    test('triggers warning and critical states', () async {
      final engine = TimerEngine();
      // Start with 6 seconds, thresholds are 5s and 3s
      engine.start(const Duration(seconds: 6));

      await Future.delayed(const Duration(seconds: 2));
      expect(engine.debugState.status, TimerStatus.warning);

      await Future.delayed(const Duration(seconds: 2));
      expect(engine.debugState.status, TimerStatus.critical);
    });

    test('expires when time runs out', () async {
      final engine = TimerEngine();
      engine.start(const Duration(milliseconds: 500));

      await Future.delayed(const Duration(seconds: 1));
      expect(engine.debugState.status, TimerStatus.expired);
      expect(engine.debugState.remaining, Duration.zero);
    });
  });
}
