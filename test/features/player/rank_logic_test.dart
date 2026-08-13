import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/services/competitive_ranking_engine.dart';

void main() {
  late CompetitiveRankingEngine engine;

  setUp(() {
    engine = CompetitiveRankingEngine();
  });

  group('CompetitiveRankingEngine - Progress Calculation', () {
    test('calculates correct progress in Bronze (100-499)', () {
      // Bronze range is 400 RP. 3 divisions. ~133 RP per division.
      // Bronze III: 100 - 232
      // Bronze II: 233 - 365
      // Bronze I: 366 - 499
      
      final progress = engine.calculateRankProgress(100); // Start of Bronze III
      expect(progress.currentRank, 'Bronze III');
      expect(progress.progressPercentage, 0.0);
      expect(progress.nextRank, 'Bronze II');

      final midProgress = engine.calculateRankProgress(166); 
      expect(midProgress.progressPercentage, closeTo(0.5, 0.01));
    });

    test('clamps progress between 0.0 and 1.0', () {
      final low = engine.calculateRankProgress(0); // Unranked
      expect(low.progressPercentage, 0.0);

      final high = engine.calculateRankProgress(999999); // Max
      expect(high.progressPercentage, 1.0);
    });

    test('handles Max Rank (Elite) correctly', () {
      final progress = engine.calculateRankProgress(8000);
      expect(progress.currentRank, 'Elite');
      expect(progress.isMaxRank, true);
      expect(progress.nextRank, isNull);
      expect(progress.rpToNextRank, isNull);
    });

    test('handles Unranked correctly', () {
      final progress = engine.calculateRankProgress(50);
      expect(progress.isUnranked, true);
      expect(progress.nextRank, 'Bronze III');
      expect(progress.rpToNextRank, 50);
    });
  });

  group('CompetitiveRankingEngine - Rank Ordering', () {
    test('correctly identifies higher ranks', () {
      expect(engine.isHigher('Gold III', 'Silver I'), true);
      expect(engine.isHigher('Gold II', 'Gold III'), true);
      expect(engine.isHigher('Platinum III', 'Gold I'), true);
      expect(engine.isHigher('Elite', 'Master I'), true);
    });

    test('correctly identifies lower ranks', () {
      expect(engine.isHigher('Silver I', 'Gold III'), false);
      expect(engine.isHigher('Gold III', 'Gold II'), false);
    });

    test('handles Unranked vs any rank', () {
      expect(engine.isHigher('Bronze III', 'Unranked'), true);
    });
  });
}
