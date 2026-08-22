import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progress_snapshot.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_result.dart';
import 'package:soteria/features/gameplay_engine/progression/services/achievement_engine.dart';

void main() {
  group('AchievementEngine Tests', () {
    test('Identifies newly unlocked score achievement', () {
      final before = ProgressSnapshot.initial().copyWith(score: 500, sessionScore: 50);
      final after = before.copyWith(score: 1200, sessionScore: 750);
      
      final result = ProgressionResult(
        before: before,
        after: after,
        scoreDelta: 700,
        xpDelta: 100,
        events: [],
      );

      final unlocked = AchievementEngine.checkAchievements(
        result: result,
        careerContext: {},
      );

      expect(unlocked, contains('score_1k'));
      expect(unlocked, contains('century'));
      expect(unlocked.length, 2);
    });

    test('Identifies newly unlocked streak achievement', () {
      final before = ProgressSnapshot.initial().copyWith(currentStreak: 9);
      final after = before.copyWith(currentStreak: 10);
      
      final result = ProgressionResult(
        before: before,
        after: after,
        scoreDelta: 100,
        xpDelta: 10,
        events: [],
      );

      final unlocked = AchievementEngine.checkAchievements(
        result: result,
        careerContext: {},
      );

      expect(unlocked, contains('streak_10'));
    });

    test('Identifies single-match score achievement (Century)', () {
      final before = ProgressSnapshot.initial().copyWith(sessionScore: 50);
      final after = before.copyWith(sessionScore: 110);
      
      final result = ProgressionResult(
        before: before,
        after: after,
        scoreDelta: 60,
        xpDelta: 10,
        events: [],
      );

      final unlocked = AchievementEngine.checkAchievements(
        result: result,
        careerContext: {},
      );

      expect(unlocked, contains('century'));
    });

    test('Does not unlock already unlocked achievement', () {
      // If score was already 1200, and it increased to 1500, it shouldn't unlock score_1k again
      final before = ProgressSnapshot.initial().copyWith(score: 1200);
      final after = before.copyWith(score: 1500);
      
      final result = ProgressionResult(
        before: before,
        after: after,
        scoreDelta: 300,
        xpDelta: 50,
        events: [],
      );

      final unlocked = AchievementEngine.checkAchievements(
        result: result,
        careerContext: {},
      );

      expect(unlocked, isNot(contains('score_1k')));
    });

    test('Evaluates category mastery from career context + snapshot', () {
      final before = ProgressSnapshot.initial().copyWith(sessionCategoryMastery: {'logic': 9});
      final after = before.copyWith(sessionCategoryMastery: {'logic': 10});
      
      final result = ProgressionResult(
        before: before,
        after: after,
        scoreDelta: 100,
        xpDelta: 10,
        events: [],
      );

      final unlocked = AchievementEngine.checkAchievements(
        result: result,
        careerContext: {
          'categoryMastery': {'logic': 0}
        },
      );

      expect(unlocked, contains('logic_master'));
    });

    test('Participation achievement unlocks at round end', () {
      final before = ProgressSnapshot.initial();
      final after = before.copyWith(totalXP: 50);
      
      final result = ProgressionResult(
        before: before,
        after: after,
        scoreDelta: 0,
        xpDelta: 50,
        events: [],
      );

      final unlocked = AchievementEngine.checkAchievements(
        result: result,
        careerContext: {
          'gamesPlayed': 0
        },
        isRoundEnd: true,
      );

      expect(unlocked, contains('first_game'));
    });
  });
}
