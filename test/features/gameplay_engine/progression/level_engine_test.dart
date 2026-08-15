import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/progression/services/level_engine.dart';
import 'package:soteria/features/player/domain/config/progression_config.dart';

void main() {
  group('LevelEngine Tests (Story 11.2 - Unified & Hardened)', () {
    final engine = LevelEngine();

    test('calculateLevel: level 1 for 0 or negative XP', () {
      expect(engine.calculateLevel(0), 1);
      expect(engine.calculateLevel(-100), 1);
    });

    test('calculateLevel: level up at exact thresholds', () {
      // Level 2: 150 XP
      expect(engine.calculateLevel(149), 1);
      expect(engine.calculateLevel(150), 2);
      expect(engine.calculateLevel(151), 2);

      // Level 3: 382 XP
      expect(engine.calculateLevel(381), 2);
      expect(engine.calculateLevel(382), 3);
    });

    test('calculateLevel: multiple level jump', () {
      // Level 5 requirement: 100 * (4)^1.5 + 50 * 4 = 100 * 8 + 200 = 1000
      expect(engine.calculateLevel(1000), 5);
      expect(engine.calculateLevel(10000), greaterThan(10));
    });

    test('calculateLevel: caps at ProgressionConfig.maxLevel', () {
      // Very large XP
      expect(engine.calculateLevel(10000000), ProgressionConfig.maxLevel);
    });

    test('xpIntoCurrentLevel: returns 0 for XP 0', () {
      expect(engine.xpIntoCurrentLevel(0), 0);
    });

    test('xpIntoCurrentLevel: returns correct partial XP', () {
      // Level 1 (0 XP) to Level 2 (150 XP)
      expect(engine.xpIntoCurrentLevel(50), 50);
      expect(engine.xpIntoCurrentLevel(150), 0);
      expect(engine.xpIntoCurrentLevel(200), 50); // Level 2 starts at 150
    });

    test('calculateLevelProgress: returns 0.0 at level start', () {
      expect(engine.calculateLevelProgress(0), 0.0);
      expect(engine.calculateLevelProgress(150), 0.0);
    });

    test('calculateLevelProgress: returns 0.5 at level midpoint', () {
      // Level 1: 0 to 150. Midpoint 75.
      expect(engine.calculateLevelProgress(75), 0.5);
    });

    test('calculateLevelProgress: returns 1.0 at max level', () {
      expect(engine.calculateLevelProgress(10000000), 1.0);
    });

    test('xpRemainingToNextLevel: returns full requirement at level start', () {
      expect(engine.xpRemainingToNextLevel(0), 150);
      expect(engine.xpRemainingToNextLevel(150), 232); // Level 3 at 382. 382 - 150 = 232.
    });

    test('xpRemainingToNextLevel: returns 0 at max level', () {
      expect(engine.xpRemainingToNextLevel(10000000), 0);
    });
  });
}
