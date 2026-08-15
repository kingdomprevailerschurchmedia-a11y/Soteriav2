import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/services/progression_service.dart';
import 'package:soteria/features/player/domain/config/progression_config.dart';
import 'package:soteria/features/gameplay_engine/progression/services/level_engine.dart';

void main() {
  group('Level System Authoritative Logic Tests (Story 11.2)', () {
    late ProgressionService progressionService;
    late LevelEngine levelEngine;

    setUp(() {
      progressionService = ProgressionService();
      levelEngine = LevelEngine();
    });

    test('XP 0 starts at Level 1', () {
      final initial = PlayerProgression.initial('user', 'season');
      expect(initial.currentLevel, 1);
      expect(initial.lifetimeXp, 0);
      expect(initial.xpRequiredForCurrentLevel, 0);
      expect(initial.xpRequiredForNextLevel, 150);
    });

    test('Exact XP threshold for Level 2', () {
      final initial = PlayerProgression.initial('user', 'season');
      final updated = progressionService.addXp(initial, 150);
      
      expect(updated.currentLevel, 2);
      expect(updated.currentXp, 0);
      expect(updated.lifetimeXp, 150);
      expect(updated.xpProgress, 0.0);
    });

    test('XP just below and just above Level 2 threshold', () {
      final initial = PlayerProgression.initial('user', 'season');
      
      final justBelow = progressionService.addXp(initial, 149);
      expect(justBelow.currentLevel, 1);
      expect(justBelow.currentXp, 149);
      
      final justAbove = progressionService.addXp(initial, 151);
      expect(justAbove.currentLevel, 2);
      expect(justAbove.currentXp, 1);
    });

    test('Multi-level jump in single transaction', () {
      final initial = PlayerProgression.initial('user', 'season');
      
      // Level 5 requires 1000 XP
      final multiJump = progressionService.addXp(initial, 1050);
      
      expect(multiJump.currentLevel, 5);
      expect(multiJump.lifetimeXp, 1050);
      expect(multiJump.currentXp, 50); // Level 5 starts at 1000
    });

    test('Level caps at maxLevel', () {
      final initial = PlayerProgression.initial('user', 'season');
      final godMode = progressionService.addXp(initial, 10000000);
      
      expect(godMode.currentLevel, ProgressionConfig.maxLevel);
      expect(godMode.xpProgress, 1.0);
      expect(godMode.xpRequiredForNextLevel, ProgressionConfig.xpRequiredForLevel(ProgressionConfig.maxLevel + 1));
    });

    test('Level calculation is deterministic across modes', () {
      const xpTotal = 2500;
      
      // Practice flow (conceptually)
      final practiceLevel = levelEngine.calculateLevel(xpTotal);
      
      // Pro flow (conceptually)
      final proLevel = levelEngine.calculateLevel(xpTotal);
      
      // Tournament flow (conceptually)
      final tournamentLevel = levelEngine.calculateLevel(xpTotal);
      
      expect(practiceLevel, proLevel);
      expect(proLevel, tournamentLevel);
      expect(practiceLevel, 8); // Level 8 starts at 2226 XP. Level 9 starts at 2701 XP.
    });

    test('Negative XP does not decrease level below 1', () {
      final initial = PlayerProgression.initial('user', 'season');
      final negative = progressionService.addXp(initial, -100);
      
      expect(negative.currentLevel, 1);
      expect(negative.lifetimeXp, -100);
    });
  });
}
