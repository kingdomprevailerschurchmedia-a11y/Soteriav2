import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/leaderboard_entry.dart';
import 'package:soteria/features/player/domain/models/rank_movement_event.dart';
import 'package:soteria/features/player/domain/services/leaderboard_insights_service.dart';

void main() {
  late LeaderboardInsightsService service;

  setUp(() {
    service = LeaderboardInsightsService();
  });

  group('LeaderboardInsightsService', () {
    final playerEntry = LeaderboardEntry(
      userId: 'u1',
      displayName: 'You',
      rankPoints: 2895,
      xp: 28950,
      rankTier: 'Platinum',
      division: 2,
      position: 115,
      lastUpdated: DateTime.now(),
    );

    test('should calculate percentile correctly', () {
      final percentile = service.calculatePercentile(115, 1350);
      expect(percentile, closeTo(8.5, 0.1));
    });

    test('should generate strong percentile insight for top 10%', () {
      final insights = service.generateInsights(
        playerEntry: playerEntry,
        totalPlayers: 1350,
        history: [],
      );

      expect(insights.any((i) => i.type == InsightType.strongPercentile), isTrue);
    });

    test('should generate significant movement insight', () {
      final history = [
        RankMovementEvent(
          id: 'm1',
          userId: 'u1',
          previousPosition: 127,
          currentPosition: 115,
          positionDelta: 12,
          previousRank: 'Platinum II',
          currentRank: 'Platinum II',
          rankPoints: 2895,
          type: RankMovementType.positionImproved,
          timestamp: DateTime.now(),
        ),
      ];

      final insights = service.generateInsights(
        playerEntry: playerEntry,
        totalPlayers: 1350,
        history: history,
      );

      expect(insights.any((i) => i.type == InsightType.significantMovement), isTrue);
      expect(insights.firstWhere((i) => i.type == InsightType.significantMovement).isPositive, isTrue);
    });

    test('should generate near promotion insight', () {
      final nearPlayer = playerEntry.copyWith(rankPoints: 3450); // Platinum threshold is 2000, Diamond is 3500
      
      final insights = service.generateInsights(
        playerEntry: nearPlayer,
        totalPlayers: 1350,
        history: [],
      );

      expect(insights.any((i) => i.type == InsightType.nearPromotion), isTrue);
    });
  });
}
