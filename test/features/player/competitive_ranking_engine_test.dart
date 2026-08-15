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
      'should NOT demote from Silver to Bronze if points are above demotion threshold (Rank Protection)',
      () {
        // Silver: 500 - 999. Demotion at 450.
        // Current: 505 (Silver III). Loss: -15 -> 490.
        // 490 < 500 (Min Silver) but 490 >= 450 (Demotion Threshold).
        final prev = mockProgression(points: 505, rank: 'Silver III');
        final result = mockResult(CompetitiveOutcome.loss);

        final change = engine.calculateRankChange(
          currentProgression: prev,
          result: result,
        );

        expect(change.newRankPoints, 490);
        expect(change.newRank, 'Silver III');
        expect(change.type, RankChangeType.decrease);
      },
    );

    test(
      'should demote from Silver to Bronze if points drop below demotion threshold',
      () {
        // Silver: 500 - 999. Demotion at 450.
        // Current: 460 (Silver III due to protection). Loss: -15 -> 445.
        // 445 < 450.
        final prev = mockProgression(points: 460, rank: 'Silver III');
        final result = mockResult(CompetitiveOutcome.loss);

        final change = engine.calculateRankChange(
          currentProgression: prev,
          result: result,
        );

        expect(change.newRankPoints, 445);
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

  group('CompetitiveRankingEngine - Rank Progress', () {
    test('should calculate correct progress for Unranked', () {
      final progress = engine.calculateRankProgress(50);
      expect(progress.isUnranked, true);
      expect(progress.progressPercentage, closeTo(50 / 99, 0.01));
      expect(progress.nextRank, 'Bronze III');
    });

    test('should calculate correct progress for Elite', () {
      final progress = engine.calculateRankProgress(8000);
      expect(progress.isMaxRank, true);
      expect(progress.progressPercentage, 1.0);
    });

    test('should calculate correct division progress within Gold', () {
      // Gold: 1000 - 1999 (Range 1000). 3 Divisions. ~333 per div.
      // Gold III: 1000 - 1332
      // Gold II: 1333 - 665 (Wait, range is 1000. 1000/3 = 333.33)
      // Div 3: [1000, 1332]
      // Div 2: [1333, 1665]
      // Div 1: [1666, 1999]

      final p1 = engine.calculateRankProgress(1100);
      expect(p1.currentRank, 'Gold III');
      expect(p1.division, 3);
      expect(p1.progressPercentage, closeTo(100 / 333, 0.01));
      expect(p1.nextRank, 'Gold II');

      final p2 = engine.calculateRankProgress(1500);
      expect(p2.currentRank, 'Gold II');
      expect(p2.division, 2);
      expect(p2.nextRank, 'Gold I');

      final p3 = engine.calculateRankProgress(1800);
      expect(p3.currentRank, 'Gold I');
      expect(p3.division, 1);
      expect(p3.nextRank, 'Platinum III');
    });
  });
}
