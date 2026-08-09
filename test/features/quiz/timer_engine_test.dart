import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/core/utils/clock.dart';
import 'package:soteria/features/quiz/domain/services/timer_engine.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';

void main() {
  group('TimerEngine Tests', () {
    test('creates timer correctly with deadline and running status', () {
      final now = DateTime(2026, 1, 1, 12, 0, 0);
      final clock = FakeClock(now);
      final engine = TimerEngine(clock: clock);

      final timer = engine.createTimer(const Duration(seconds: 30));

      expect(timer.isRunning, isTrue);
      expect(timer.status, equals(TimerStatus.running));
      expect(timer.totalDuration, equals(const Duration(seconds: 30)));
      expect(timer.remainingTime, equals(const Duration(seconds: 30)));
      expect(timer.deadline, equals(now.add(const Duration(seconds: 30))));
      expect(timer.hasExpired, isFalse);
    });

    test('ticks correctly into warning state', () {
      final now = DateTime(2026, 1, 1, 12, 0, 0);
      final clock = FakeClock(now);
      final engine = TimerEngine(clock: clock);

      var timer = engine.createTimer(const Duration(seconds: 30));

      // Advance by 22 seconds (8 seconds remaining -> warning threshold <= 10s)
      clock.advance(const Duration(seconds: 22));
      timer = engine.tick(timer);

      expect(timer.status, equals(TimerStatus.warning));
      expect(timer.isWarning, isTrue);
      expect(timer.isCritical, isFalse);
      expect(timer.remainingTime.inSeconds, equals(8));
    });

    test('ticks correctly into critical state', () {
      final now = DateTime(2026, 1, 1, 12, 0, 0);
      final clock = FakeClock(now);
      final engine = TimerEngine(clock: clock);

      var timer = engine.createTimer(const Duration(seconds: 30));

      // Advance by 26 seconds (4 seconds remaining -> critical threshold <= 5s)
      clock.advance(const Duration(seconds: 26));
      timer = engine.tick(timer);

      expect(timer.status, equals(TimerStatus.critical));
      expect(timer.isCritical, isTrue);
      expect(timer.remainingTime.inSeconds, equals(4));
    });

    test('expires when time runs out', () {
      final now = DateTime(2026, 1, 1, 12, 0, 0);
      final clock = FakeClock(now);
      final engine = TimerEngine(clock: clock);

      var timer = engine.createTimer(const Duration(seconds: 30));

      // Advance past total duration
      clock.advance(const Duration(seconds: 31));
      timer = engine.tick(timer);

      expect(timer.status, equals(TimerStatus.expired));
      expect(timer.hasExpired, isTrue);
      expect(timer.isRunning, isFalse);
      expect(timer.remainingTime, equals(Duration.zero));
    });

    test('pauses and resumes correctly preserving deadline offset', () {
      final now = DateTime(2026, 1, 1, 12, 0, 0);
      final clock = FakeClock(now);
      final engine = TimerEngine(clock: clock);

      var timer = engine.createTimer(const Duration(seconds: 30));
      clock.advance(const Duration(seconds: 10));
      timer = engine.tick(timer);

      expect(timer.remainingTime.inSeconds, equals(20));

      // Pause
      timer = engine.pause(timer);
      expect(timer.isRunning, isFalse);
      expect(timer.status, equals(TimerStatus.paused));

      // Advance clock while paused (should not affect deadline until resume or tick)
      clock.advance(const Duration(seconds: 5));

      // Resume with 5 seconds paused duration
      timer = engine.resume(timer, const Duration(seconds: 5));
      expect(timer.isRunning, isTrue);

      // Tick right after resume
      timer = engine.tick(timer);
      expect(timer.remainingTime.inSeconds, equals(20));
    });
  });
}
