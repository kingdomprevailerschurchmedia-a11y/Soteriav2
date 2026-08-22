import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/gameplay_engine/timer/services/timer_policy_resolver.dart';

void main() {
  group('TimerPolicyResolver Tests', () {
    final resolver = TimerPolicyResolver();

    test('returns correct duration for Practice Mode', () {
      expect(
        resolver.getDuration(
          mode: GameMode.practice,
          difficulty: Difficulty.easy,
        ),
        const Duration(seconds: 20),
      );
      expect(
        resolver.getDuration(
          mode: GameMode.practice,
          difficulty: Difficulty.expert,
        ),
        const Duration(seconds: 12),
      );
    });

    test('returns correct duration for Pro Mode', () {
      expect(
        resolver.getDuration(
          mode: GameMode.pro,
          difficulty: Difficulty.easy,
        ),
        const Duration(seconds: 15),
      );
      expect(
        resolver.getDuration(
          mode: GameMode.pro,
          difficulty: Difficulty.expert,
        ),
        const Duration(seconds: 8),
      );
    });

    test('applies accessibility multiplier', () {
      final duration = resolver.getDuration(
        mode: GameMode.pro,
        difficulty: Difficulty.easy,
        accessibilityMultiplier: 1.5,
      );
      // 15s * 1.5 = 22.5s
      expect(duration.inMilliseconds, 22500);
    });
  });
}
