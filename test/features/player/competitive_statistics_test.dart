import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/competitive_statistics.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/models/season_result.dart';
import 'package:soteria/features/player/domain/services/competitive_statistics_service.dart';

void main() {
  late CompetitiveStatisticsService service;

  setUp(() {
    service = CompetitiveStatisticsService();
  });

  group('CompetitiveStatisticsService', () {
    final mockProfile = PlayerProfile(
      uid: 'u1',
      displayName: 'Pro',
      email: 'pro@test.com',
      gamesPlayed: 100,
      gamesWon: 60,
      accuracy: 0.75,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final mockProgression = PlayerProgression.initial(
      'u1',
      's8',
    ).copyWith(rankPoints: 2000);

    test('should calculate correct career win rate', () {
      final stats = service.calculate(
        userId: 'u1',
        profile: mockProfile,
        history: const CompetitiveHistory(userId: 'u1'),
        progression: mockProgression,
        currentSeason: null,
        globalPosition: -1,
      );

      expect(stats.career.winRate, 0.6);
      expect(stats.career.gamesLost, 40);
    });

    test('should determine improving trend when win rate increases', () {
      final history = CompetitiveHistory(
        userId: 'u1',
        results: [
          SeasonResult(
            seasonId: 's7',
            userId: 'u1',
            seasonName: 'S7',
            seasonNumber: 7,
            finalPosition: 100,
            finalRankPoints: 1500,
            finalTier: 'Gold',
            finalDivision: 1,
            previousTier: 'Silver',
            previousDivision: 1,
            rankChange: 500,
            completedAt: DateTime.now(),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            statistics: {'winRate': 0.70},
          ),
          SeasonResult(
            seasonId: 's6',
            userId: 'u1',
            seasonName: 'S6',
            seasonNumber: 6,
            finalPosition: 200,
            finalRankPoints: 1000,
            finalTier: 'Silver',
            finalDivision: 1,
            previousTier: 'Bronze',
            previousDivision: 1,
            rankChange: 500,
            completedAt: DateTime.now(),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            statistics: {'winRate': 0.60},
          ),
        ],
      );

      final stats = service.calculate(
        userId: 'u1',
        profile: mockProfile,
        history: history,
        progression: mockProgression,
        currentSeason: null,
        globalPosition: -1,
      );

      final wrTrend = stats.trends.firstWhere(
        (t) => t.metricName == 'Win Rate',
      );
      expect(wrTrend.state, TrendState.improving);
      expect(wrTrend.changePercentage, closeTo(0.1, 0.001));
    });

    test('should return empty trends when insufficient history', () {
      final stats = service.calculate(
        userId: 'u1',
        profile: mockProfile,
        history: const CompetitiveHistory(userId: 'u1', results: []),
        progression: mockProgression,
        currentSeason: null,
        globalPosition: -1,
      );

      expect(stats.trends, isEmpty);
    });

    test('should generate positive insight for high win rate', () {
      final stats = service.calculate(
        userId: 'u1',
        profile: mockProfile.copyWith(gamesPlayed: 10, gamesWon: 8),
        history: const CompetitiveHistory(userId: 'u1'),
        progression: mockProgression,
        currentSeason: null,
        globalPosition: -1,
      );

      expect(stats.insights.any((i) => i.title == 'Elite Win Rate'), isTrue);
    });
  });
}
