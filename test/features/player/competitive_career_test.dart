import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/competitive_personal_record.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/player/domain/models/season_result.dart';
import 'package:soteria/features/player/domain/services/competitive_statistics_service.dart';

void main() {
  late CompetitiveStatisticsService service;

  setUp(() {
    service = CompetitiveStatisticsService();
  });

  group('CompetitiveCareerSummary', () {
    final now = DateTime.now();
    final mockProfile = PlayerProfile(
      uid: 'u1',
      displayName: 'CareerPlayer',
      email: 'career@test.com',
      gamesPlayed: 100,
      gamesWon: 75,
      xp: 12000,
      highestStreak: 10,
      createdAt: now,
      lastLogin: now,
      updatedAt: now,
    );

    final mockHistory = CompetitiveHistory(
      userId: 'u1',
      results: [
        SeasonResult(
          seasonId: 's1',
          userId: 'u1',
          seasonName: 'Season 1',
          seasonNumber: 1,
          finalPosition: 10,
          finalRankPoints: 2500,
          finalTier: 'Diamond',
          finalDivision: 1,
          previousTier: 'Gold',
          previousDivision: 1,
          rankChange: 500,
          completedAt: now,
          createdAt: now,
          updatedAt: now,
        ),
      ],
      bestResult: SeasonResult(
        seasonId: 's1',
        userId: 'u1',
        seasonName: 'Season 1',
        seasonNumber: 1,
        finalPosition: 10,
        finalRankPoints: 2500,
        finalTier: 'Diamond',
        finalDivision: 1,
        previousTier: 'Gold',
        previousDivision: 1,
        rankChange: 500,
        completedAt: now,
        createdAt: now,
        updatedAt: now,
      ),
    );

    final mockRecords = [
      CompetitivePersonalRecord(
        id: 'r1',
        userId: 'u1',
        type: CompetitiveRecordType.highestScore,
        value: 2800,
        displayValue: '2,800',
        achievedAt: now,
        isCareerRecord: true,
      ),
    ];

    test('should calculate correct career summary', () {
      final summary = service.calculateCareerSummary(
        userId: 'u1',
        profile: mockProfile,
        history: mockHistory,
        records: mockRecords,
      );

      expect(summary.totalMatches, 100);
      expect(summary.totalWins, 75);
      expect(summary.winRate, 0.75);
      expect(summary.bestRank, 'Diamond');
      expect(summary.bestPosition, 10);
      expect(summary.highestScore, 2800);
      expect(summary.totalXp, 12000);
    });

    test('should handle empty history and records', () {
      final summary = service.calculateCareerSummary(
        userId: 'u1',
        profile: mockProfile.copyWith(gamesPlayed: 0, gamesWon: 0, xp: 0, highestStreak: 0),
        history: const CompetitiveHistory(userId: 'u1'),
        records: [],
      );

      expect(summary.totalMatches, 0);
      expect(summary.winRate, 0.0);
      expect(summary.bestRank, 'N/A');
      expect(summary.bestPosition, -1);
      expect(summary.highestScore, 0);
    });
  });
}
