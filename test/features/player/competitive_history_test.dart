import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/season_result.dart';

void main() {
  group('SeasonResult', () {
    test('should serialize and deserialize correctly', () {
      final now = DateTime.now();
      final result = SeasonResult(
        seasonId: 'season_1',
        userId: 'user_1',
        seasonName: 'Alpha',
        seasonNumber: 1,
        finalPosition: 5,
        finalRankPoints: 1500,
        finalTier: 'Gold',
        finalDivision: 2,
        previousTier: 'Silver',
        previousDivision: 1,
        rankChange: 300,
        completedAt: now,
        createdAt: now,
        updatedAt: now,
      );

      final json = result.toJson();
      final fromJson = SeasonResult.fromJson(json);

      expect(fromJson.seasonId, result.seasonId);
      expect(fromJson.userId, result.userId);
      expect(fromJson.finalPosition, result.finalPosition);
      expect(fromJson.finalRankPoints, result.finalRankPoints);
      expect(
        fromJson.completedAt.toIso8601String(),
        result.completedAt.toIso8601String(),
      );
    });
  });

  group('CompetitiveHistory', () {
    test('should hold results and identify best/latest', () {
      final now = DateTime.now();
      final r1 = SeasonResult(
        seasonId: 's1',
        userId: 'u1',
        seasonName: 'Beta',
        seasonNumber: 1,
        finalPosition: 100,
        finalRankPoints: 1000,
        finalTier: 'Gold',
        finalDivision: 3,
        previousTier: 'Unranked',
        previousDivision: 0,
        rankChange: 1000,
        completedAt: now.subtract(const Duration(days: 30)),
        createdAt: now,
        updatedAt: now,
      );

      final r2 = SeasonResult(
        seasonId: 's2',
        userId: 'u1',
        seasonName: 'Ascension',
        seasonNumber: 2,
        finalPosition: 10,
        finalRankPoints: 2500,
        finalTier: 'Diamond',
        finalDivision: 1,
        previousTier: 'Gold',
        previousDivision: 3,
        rankChange: 1500,
        completedAt: now,
        createdAt: now,
        updatedAt: now,
      );

      final history = CompetitiveHistory(
        userId: 'u1',
        results: [r2, r1],
        latestResult: r2,
        bestResult: r2,
      );

      expect(history.results.length, 2);
      expect(history.latestResult?.seasonId, 's2');
      expect(history.bestResult?.finalPosition, 10);
    });
  });
}
