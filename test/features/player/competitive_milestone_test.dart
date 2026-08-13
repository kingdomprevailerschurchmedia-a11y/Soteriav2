import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/milestone.dart';
import 'package:soteria/features/player/domain/services/milestone_evaluation_service.dart';
import 'package:soteria/features/player/domain/models/competitive_statistics.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/player/domain/models/season_result.dart';

void main() {
  late MilestoneEvaluationService service;

  setUp(() {
    service = MilestoneEvaluationService();
  });

  group('MilestoneEvaluationService', () {
    final definitions = [
      const MilestoneDefinition(
        id: 'wins_10',
        name: 'Decathlon',
        description: 'Win 10 competitive games.',
        type: MilestoneType.win,
        category: MilestoneCategory.victory,
        threshold: 10,
      ),
      const MilestoneDefinition(
        id: 'rank_gold',
        name: 'Golden Standard',
        description: 'Reach Gold tier.',
        type: MilestoneType.rank,
        category: MilestoneCategory.ranking,
        threshold: 1,
      ),
    ];

    final baseStats = CompetitiveStatistics(
      userId: 'user',
      career: const CareerStatistics(
        gamesPlayed: 5,
        gamesWon: 2,
        gamesLost: 3,
        winRate: 0.4,
        totalQuestionsAnswered: 50,
        correctAnswers: 40,
        accuracy: 0.8,
        currentStreak: 0,
        highestStreak: 2,
        bestRank: 'Silver I',
        peakPosition: 500,
        seasonsPlayed: 1,
      ),
      currentSeason: null,
      trends: [],
      insights: [],
    );

    final baseProgression = PlayerProgression.initial('user', 'season').copyWith(
      currentRank: 'Silver I',
      currentRankTier: 'silver',
      rankPoints: 800,
    );

    final baseHistory = const CompetitiveHistory(userId: 'user');

    test('evaluates in-progress milestones', () {
      final results = service.evaluate(
        userId: 'user',
        definitions: definitions,
        statistics: baseStats,
        progression: baseProgression,
        history: baseHistory,
        currentStates: [],
      );

      // Only wins_10 is returned because its progress (2.0) differs from the default (0.0).
      // rank_gold progress is 0.0, which matches default, so it's not in the update list.
      expect(results.length, 1);
      final winsMilestone = results.firstWhere((m) => m.milestoneId == 'wins_10');
      expect(winsMilestone.status, MilestoneStatus.inProgress);
      expect(winsMilestone.currentProgress, 2.0);
    });

    test('detects completion of win-based milestone', () {
      final updatedStats = baseStats.copyWith(
        career: baseStats.career.copyWith(gamesWon: 10),
      );

      final results = service.evaluate(
        userId: 'user',
        definitions: definitions,
        statistics: updatedStats,
        progression: baseProgression,
        history: baseHistory,
        currentStates: [],
      );

      final winsMilestone = results.firstWhere((m) => m.milestoneId == 'wins_10');
      expect(winsMilestone.status, MilestoneStatus.completed);
      expect(winsMilestone.unlockedAt, isNotNull);
    });

    test('detects completion of rank-based milestone', () {
      final updatedProgression = baseProgression.copyWith(
        currentRank: 'Gold III',
        currentRankTier: 'gold',
        rankPoints: 1100,
      );

      final results = service.evaluate(
        userId: 'user',
        definitions: definitions,
        statistics: baseStats,
        progression: updatedProgression,
        history: baseHistory,
        currentStates: [],
      );

      final rankMilestone = results.firstWhere((m) => m.milestoneId == 'rank_gold');
      expect(rankMilestone.status, MilestoneStatus.completed);
    });

    test('idempotency: does not return already completed milestones', () {
      final currentState = [
        PlayerMilestone(
          userId: 'user',
          milestoneId: 'wins_10',
          status: MilestoneStatus.completed,
          currentProgress: 10.0,
        ),
      ];

      final updatedStats = baseStats.copyWith(
        career: baseStats.career.copyWith(gamesWon: 12),
      );

      final results = service.evaluate(
        userId: 'user',
        definitions: definitions,
        statistics: updatedStats,
        progression: baseProgression,
        history: baseHistory,
        currentStates: currentState,
      );

      expect(results.any((m) => m.milestoneId == 'wins_10'), false);
    });
  });
}
