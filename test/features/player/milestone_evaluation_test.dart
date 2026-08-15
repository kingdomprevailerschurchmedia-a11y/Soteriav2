import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/milestone.dart';
import 'package:soteria/features/player/domain/models/competitive_statistics.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/models/season_result.dart';
import 'package:soteria/features/player/domain/services/milestone_evaluation_service.dart';

void main() {
  late MilestoneEvaluationService service;

  setUp(() {
    service = MilestoneEvaluationService();
  });

  group('MilestoneEvaluationService', () {
    const userId = 'u1';
    final mockStats = CompetitiveStatistics(
      userId: userId,
      career: const CareerStatistics(
        gamesPlayed: 10,
        gamesWon: 5,
        gamesLost: 5,
        winRate: 0.5,
        totalQuestionsAnswered: 100,
        correctAnswers: 80,
        accuracy: 0.8,
        currentStreak: 0,
        highestStreak: 5,
        bestRank: 'Gold',
        peakPosition: 50,
        seasonsPlayed: 2,
      ),
      currentSeason: null,
      trends: [],
      insights: [],
      recentForm: [],
    );

    final mockProgression = PlayerProgression.initial(
      userId,
      's1',
    ).copyWith(currentRankTier: 'gold');

    final mockHistory = CompetitiveHistory(
      userId: userId,
      results: [],
      bestResult: SeasonResult(
        seasonId: 's1',
        userId: userId,
        seasonName: 'S1',
        seasonNumber: 1,
        finalPosition: 50,
        finalRankPoints: 1500,
        finalTier: 'Gold',
        finalDivision: 1,
        previousTier: 'Silver',
        previousDivision: 1,
        rankChange: 500,
        completedAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    test('should unlock COUNT milestone when threshold reached', () {
      final definitions = [
        const MilestoneDefinition(
          id: 'games_10',
          name: 'Veteran',
          description: 'Play 10 games',
          type: MilestoneType.count,
          category: MilestoneCategory.participation,
          threshold: 10,
        ),
      ];

      final result = service.evaluate(
        userId: userId,
        statistics: mockStats,
        progression: mockProgression,
        history: mockHistory,
        currentStates: [],
        definitions: definitions,
      );

      expect(result.length, 1);
      expect(result.first.milestoneId, 'games_10');
      expect(result.first.status, MilestoneStatus.completed);
      expect(result.first.currentProgress, 10.0);
    });

    test('should unlock RANK milestone when tier reached', () {
      final definitions = [
        const MilestoneDefinition(
          id: 'rank_gold',
          name: 'Gold',
          description: 'Reach Gold',
          type: MilestoneType.rank,
          category: MilestoneCategory.ranking,
          threshold: 1,
        ),
      ];

      final result = service.evaluate(
        userId: userId,
        statistics: mockStats,
        progression: mockProgression,
        history: mockHistory,
        currentStates: [],
        definitions: definitions,
      );

      expect(result.length, 1);
      expect(result.first.status, MilestoneStatus.completed);
    });

    test('should NOT unlock milestone if already completed', () {
      final definitions = [
        const MilestoneDefinition(
          id: 'games_10',
          name: 'Veteran',
          description: 'Play 10 games',
          type: MilestoneType.count,
          category: MilestoneCategory.participation,
          threshold: 10,
        ),
      ];

      final currentStates = [
        PlayerMilestone(
          userId: userId,
          milestoneId: 'games_10',
          status: MilestoneStatus.completed,
          currentProgress: 10.0,
          unlockedAt: DateTime.now(),
        ),
      ];

      final result = service.evaluate(
        userId: userId,
        statistics: mockStats,
        progression: mockProgression,
        history: mockHistory,
        currentStates: currentStates,
        definitions: definitions,
      );

      expect(result, isEmpty);
    });

    test('should handle POSITION milestones correctly', () {
      final definitions = [
        const MilestoneDefinition(
          id: 'top_100',
          name: 'Top 100',
          description: 'Top 100',
          type: MilestoneType.position,
          category: MilestoneCategory.ranking,
          threshold: 100,
        ),
      ];

      final result = service.evaluate(
        userId: userId,
        statistics: mockStats,
        progression: mockProgression,
        history: mockHistory,
        currentStates: [],
        definitions: definitions,
      );

      expect(result.length, 1);
      expect(result.first.status, MilestoneStatus.completed);
    });
  });
}
