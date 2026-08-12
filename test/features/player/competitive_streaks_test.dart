import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/competitive_streak.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import 'package:soteria/features/player/domain/models/momentum.dart';
import 'package:soteria/features/player/domain/services/competitive_streak_engine.dart';

void main() {
  group('CompetitiveStreakEngine', () {
    late CompetitiveStreakEngine engine;
    late CompetitiveStreak initialStreak;

    setUp(() {
      engine = CompetitiveStreakEngine();
      initialStreak = CompetitiveStreak(
        userId: 'u1',
        type: StreakType.win,
        current: 2,
        best: 5,
        seasonBest: 3,
        startedAt: DateTime.now().subtract(const Duration(days: 1)),
        lastQualifiedAt: DateTime.now().subtract(const Duration(hours: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      );
    });

    test('should increment win streak on WIN outcome', () {
      final result = CompetitiveResult(
        resultId: 'res1',
        userId: 'u1',
        seasonId: 's1',
        outcome: CompetitiveOutcome.win,
        mode: 'tournament',
        score: 100,
        completedAt: DateTime.now(),
      );

      final updated = engine.updateWinStreak(
        currentStreak: initialStreak,
        result: result,
      );

      expect(updated.current, 3);
      expect(
        updated.seasonBest,
        3,
      ); // Still 3 because current (3) == seasonBest (3)
    });

    test('should update bests when current exceeds them', () {
      final streak = initialStreak.copyWith(current: 5, best: 5, seasonBest: 5);
      final result = CompetitiveResult(
        resultId: 'res2',
        userId: 'u1',
        seasonId: 's1',
        outcome: CompetitiveOutcome.win,
        mode: 'tournament',
        score: 100,
        completedAt: DateTime.now(),
      );

      final updated = engine.updateWinStreak(
        currentStreak: streak,
        result: result,
      );

      expect(updated.current, 6);
      expect(updated.best, 6);
      expect(updated.seasonBest, 6);
    });

    test('should reset streak on LOSS outcome', () {
      final result = CompetitiveResult(
        resultId: 'res3',
        userId: 'u1',
        seasonId: 's1',
        outcome: CompetitiveOutcome.loss,
        mode: 'tournament',
        score: 50,
        completedAt: DateTime.now(),
      );

      final updated = engine.updateWinStreak(
        currentStreak: initialStreak,
        result: result,
      );

      expect(updated.current, 0);
      expect(updated.status, StreakStatus.broken);
      expect(updated.best, 5); // Best remains
    });

    test('should calculate momentum signals correctly', () {
      final streak = initialStreak.copyWith(current: 4);
      final recentResults = [
        CompetitiveResult(
          resultId: 'r1',
          userId: 'u1',
          seasonId: 's1',
          outcome: CompetitiveOutcome.win,
          mode: 'tournament',
          score: 100,
          completedAt: DateTime.now(),
        ),
        CompetitiveResult(
          resultId: 'r2',
          userId: 'u1',
          seasonId: 's1',
          outcome: CompetitiveOutcome.win,
          mode: 'tournament',
          score: 100,
          completedAt: DateTime.now(),
        ),
        CompetitiveResult(
          resultId: 'r3',
          userId: 'u1',
          seasonId: 's1',
          outcome: CompetitiveOutcome.win,
          mode: 'tournament',
          score: 100,
          completedAt: DateTime.now(),
        ),
        CompetitiveResult(
          resultId: 'r4',
          userId: 'u1',
          seasonId: 's1',
          outcome: CompetitiveOutcome.win,
          mode: 'tournament',
          score: 100,
          completedAt: DateTime.now(),
        ),
      ];

      final momentum = engine.calculateMomentum(
        userId: 'u1',
        recentResults: recentResults,
        currentStreak: streak,
        recentQuizResults: [],
      );

      expect(momentum.state, MomentumState.peak);
      expect(momentum.recentSignals, contains('4 Consecutive Wins'));
    });
  });
}
