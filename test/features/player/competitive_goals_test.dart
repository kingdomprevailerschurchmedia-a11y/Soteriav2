import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/competitive_goal.dart';
import 'package:soteria/features/player/domain/services/competitive_goal_evaluation_service.dart';
import 'package:soteria/features/player/domain/models/competitive_statistics.dart';
import 'package:soteria/features/player/domain/models/player_progression.dart';
import 'package:soteria/features/quiz/domain/models/quiz_result.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';

void main() {
  group('CompetitiveGoalEvaluationService', () {
    late CompetitiveGoalEvaluationService service;
    late PlayerProgression mockProgression;
    late CompetitiveStatistics mockStats;

    setUp(() {
      service = CompetitiveGoalEvaluationService();
      mockProgression = PlayerProgression.initial(
        'u1',
        's1',
      ).copyWith(currentRankTier: 'Gold');
      mockStats = CompetitiveStatistics(
        userId: 'u1',
        career: CareerStatistics(
          gamesPlayed: 10,
          gamesWon: 5,
          gamesLost: 5,
          winRate: 0.5,
          totalQuestionsAnswered: 100,
          correctAnswers: 80,
          accuracy: 0.8,
          currentStreak: 2,
          highestStreak: 5,
          bestRank: 'Gold',
          peakPosition: 500,
          seasonsPlayed: 1,
        ),
        currentSeason: null,
        trends: [],
        insights: [],
      );
    });

    test('should update progress for gameCount goal', () {
      final now = DateTime.now();
      final goal = CompetitiveGoal(
        id: 'g1',
        type: GoalType.daily,
        category: GoalCategory.gameCount,
        title: 'Play Games',
        description: 'Play 3 games',
        target: 3,
        currentProgress: 0,
        status: GoalStatus.active,
        startAt: now.subtract(const Duration(hours: 1)),
        endAt: now.add(const Duration(hours: 23)),
      );

      final results = [
        QuizResult(
          sessionId: 's1',
          playerId: 'u1',
          gameMode: GameMode.tournament,
          difficulty: Difficulty.medium,
          category: 'History',
          totalQuestions: 10,
          answeredQuestions: 10,
          correctAnswers: 8,
          wrongAnswers: 2,
          skipped: 0,
          timedOut: 0,
          finalScore: 100,
          accuracy: 0.8,
          completedAt: now,
          xpEarned: 50,
          longestStreak: 5,
          finalStreak: 3,
          averageResponseTime: Duration(seconds: 5),
          fastestResponseTime: Duration(seconds: 2),
          slowestResponseTime: Duration(seconds: 10),
          questionResults: [],
          completionTime: Duration(minutes: 1),
          performanceRating: 'A',
        ),
        QuizResult(
          sessionId: 's2',
          playerId: 'u1',
          gameMode: GameMode.versus,
          difficulty: Difficulty.medium,
          category: 'Science',
          totalQuestions: 10,
          answeredQuestions: 10,
          correctAnswers: 9,
          wrongAnswers: 1,
          skipped: 0,
          timedOut: 0,
          finalScore: 150,
          accuracy: 0.9,
          completedAt: now.add(const Duration(minutes: 10)),
          xpEarned: 60,
          longestStreak: 7,
          finalStreak: 5,
          averageResponseTime: Duration(seconds: 4),
          fastestResponseTime: Duration(seconds: 1),
          slowestResponseTime: Duration(seconds: 8),
          questionResults: [],
          completionTime: Duration(minutes: 1),
          performanceRating: 'S',
        ),
      ];

      final updated = service.evaluate(
        activeGoals: [goal],
        recentResults: results,
        statistics: mockStats,
        progression: mockProgression,
      );

      expect(updated.length, 1);
      expect(updated.first.currentProgress, 2.0);
      expect(updated.first.status, GoalStatus.active);
    });

    test('should mark goal as completed when target is reached', () {
      final now = DateTime.now();
      final goal = CompetitiveGoal(
        id: 'g2',
        type: GoalType.daily,
        category: GoalCategory.win,
        title: 'Win Games',
        description: 'Win 1 game',
        target: 1,
        currentProgress: 0,
        status: GoalStatus.active,
        startAt: now.subtract(const Duration(hours: 1)),
        endAt: now.add(const Duration(hours: 23)),
      );

      final results = [
        QuizResult(
          sessionId: 's1',
          playerId: 'u1',
          gameMode: GameMode.tournament,
          difficulty: Difficulty.medium,
          category: 'History',
          totalQuestions: 10,
          answeredQuestions: 10,
          correctAnswers: 10,
          wrongAnswers: 0,
          skipped: 0,
          timedOut: 0,
          finalScore: 100,
          accuracy: 1.0,
          completedAt: now,
          xpEarned: 50,
          longestStreak: 10,
          finalStreak: 10,
          averageResponseTime: Duration(seconds: 3),
          fastestResponseTime: Duration(seconds: 1),
          slowestResponseTime: Duration(seconds: 5),
          questionResults: [],
          completionTime: Duration(minutes: 1),
          performanceRating: 'S',
        ),
      ];

      final updated = service.evaluate(
        activeGoals: [goal],
        recentResults: results,
        statistics: mockStats,
        progression: mockProgression,
      );

      expect(updated.first.status, GoalStatus.completed);
      expect(updated.first.currentProgress, 1.0);
    });
  });
}
