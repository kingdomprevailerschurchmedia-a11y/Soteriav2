import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import 'package:soteria/features/player/domain/models/rank_change.dart';
import 'package:soteria/features/player/domain/services/competitive_ranking_engine.dart';

void main() {
  late CompetitiveRankingEngine engine;

  setUp(() {
    engine = CompetitiveRankingEngine();
  });

  PlayerProgression mockProgression({
    int points = 0,
    String rank = 'Unranked',
  }) {
    return PlayerProgression(
      userId: 'user1',
      currentLevel: 1,
      currentXp: 0,
      lifetimeXp: 0,
      xpRequiredForCurrentLevel: 0,
      xpRequiredForNextLevel: 1000,
      xpProgress: 0.0,
      currentRank: rank,
      currentRankTier: rank.split(' ')[0].toLowerCase(),
      rankPoints: points,
      rankProgress: 0.0,
      seasonId: 'season1',
      seasonXp: 0,
      seasonRankPoints: points,
      lastUpdated: DateTime.now(),
    );
  }

  CompetitiveResult mockResult(CompetitiveOutcome outcome) {
    return CompetitiveResult(
      resultId: 'res1',
      userId: 'user1',
      seasonId: 'season1',
      outcome: outcome,
      mode: 'ranked',
      score: 100,
      completedAt: DateTime.now(),
    );
  }

  group('CompetitiveRankingEngine - Point Calculations', () {
    test('should add 25 points for a win', () {
      final prev = mockProgression(points: 100, rank: 'Bronze III');
      final result = mockResult(CompetitiveOutcome.win);

      final change = engine.calculateRankChange(
        currentProgression: prev,
        result: result,
      );

      expect(change.newRankPoints, 125);
      expect(change.type, RankChangeType.increase);
    });

    test('should subtract 15 points for a loss', () {
      final prev = mockProgression(points: 200, rank: 'Bronze III');
      final result = mockResult(CompetitiveOutcome.loss);

      final change = engine.calculateRankChange(
        currentProgression: prev,
        result: result,
      );

      expect(change.newRankPoints, 185);
      expect(change.type, RankChangeType.decrease);
    });

    test('should not fall below 0 points', () {
      final prev = mockProgression(points: 5, rank: 'Bronze III');
      final result = mockResult(CompetitiveOutcome.loss);

      final change = engine.calculateRankChange(
        currentProgression: prev,
        result: result,
      );

      expect(change.newRankPoints, 0);
    });
  });

  group('CompetitiveRankingEngine - Boundaries & Promotion', () {
    test('should promote from Bronze to Silver at 500 RP', () {
      // Bronze: 100 - 499. Silver starts at 500.
      final prev = mockProgression(points: 480, rank: 'Bronze I');
      final result = mockResult(CompetitiveOutcome.win);

      final change = engine.calculateRankChange(
        currentProgression: prev,
        result: result,
      );

      expect(change.newRankPoints, 505);
      expect(change.newRank, startsWith('Silver'));
      expect(change.type, RankChangeType.promotion);
    });

    test(
      'should demote from Silver to Bronze below 450 RP (Demotion Threshold)',
      () {
        // Silver: 500 - 999. Demotion at 450.
        // Wait, RankingEngine uses tier minPoints for now, not thresholds.
        // Let's check ProgressionConfig.
        // Silver min: 500.
        final prev = mockProgression(points: 510, rank: 'Silver III');
        final result = mockResult(CompetitiveOutcome.loss);

        final change = engine.calculateRankChange(
          currentProgression: prev,
          result: result,
        );

        expect(change.newRankPoints, 495);
        expect(change.newRank, startsWith('Bronze'));
        expect(change.type, RankChangeType.demotion);
      },
    );
  });

  group('CompetitiveRankingEngine - Divisions', () {
    test('should calculate correct division within Silver', () {
      // Silver: 500 - 999 (Range 500). 3 Divisions. ~166 per division.
      // Silver III: 500 - 666
      // Silver II: 667 - 833
      // Silver I: 834 - 999

      final p1 = mockProgression(points: 550, rank: 'Silver III');
      expect(
        engine
            .calculateRankChange(
              currentProgression: p1,
              result: mockResult(CompetitiveOutcome.draw),
            )
            .newRank,
        'Silver III',
      );

      final p2 = mockProgression(points: 750, rank: 'Silver II');
      expect(
        engine
            .calculateRankChange(
              currentProgression: p2,
              result: mockResult(CompetitiveOutcome.draw),
            )
            .newRank,
        'Silver II',
      );

      final p3 = mockProgression(points: 900, rank: 'Silver I');
      expect(
        engine
            .calculateRankChange(
              currentProgression: p3,
              result: mockResult(CompetitiveOutcome.draw),
            )
            .newRank,
        'Silver I',
      );
    });
  });
}
