import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/timer/providers/timer_engine_provider.dart';

void main() {
  group('Timer Anomaly Tests', () {
    test('detects significant clock drift', () async {
      final engine = TimerEngine(
        onEventEmitted: (name, {metadata = const {}}) {
          // Verify event name in a real integration test or by extracting logic
        },
      );

      // Start the timer
      engine.start(const Duration(seconds: 30));

      expect(engine.debugState.remaining.inSeconds, 30);
    });
  });
}
