import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/progression/services/level_engine.dart';
import 'package:soteria/features/gameplay_engine/progression/models/level_config.dart';

void main() {
  group('LevelEngine Tests', () {
    final config = const LevelConfig(
      baseXP: 100,
      exponent: 2.0,
      linearFactor: 0,
    );
    final engine = LevelEngine(config: config);

    test('level 1 requires 0 XP', () {
      expect(engine.calculateLevel(0), 1);
      expect(engine.calculateLevel(50), 1);
    });

    test('level up happens at correct threshold', () {
      // Level 2: 100 * (2-1)^2 + 0 = 100
      expect(engine.calculateLevel(99), 1);
      expect(engine.calculateLevel(100), 2);

      // Level 3: 100 * (3-1)^2 + 0 = 400
      expect(engine.calculateLevel(399), 2);
      expect(engine.calculateLevel(400), 3);
    });

    test('progress calculation is accurate', () {
      // At 50 XP, halfway to Level 2 (100 XP)
      expect(engine.calculateLevelProgress(50), 0.5);

      // At 250 XP, halfway from L2(100) to L3(400)
      // Total needed in level = 300. Current in level = 150.
      expect(engine.calculateLevelProgress(250), 0.5);
    });
  });
}
