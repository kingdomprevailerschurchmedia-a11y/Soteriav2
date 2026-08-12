import 'package:soteria/features/player/domain/models/competitive_match.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import 'package:soteria/features/player/domain/models/rank_change.dart';
import 'package:soteria/features/quiz/domain/models/quiz_result.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';

class MatchHistoryFixtures {
  static CompetitiveMatch win({String? id}) => CompetitiveMatch(
    result: CompetitiveResult(
      resultId: id ?? 'match_win_1',
      userId: 'user_1',
      seasonId: 'season_1',
      outcome: CompetitiveOutcome.win,
      mode: 'Tournament',
      score: 8420,
      completedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    rankChange: RankChange(
      changeId: 'rc_1',
      userId: 'user_1',
      seasonId: 'season_1',
      previousRank: 'Gold II',
      newRank: 'Gold I',
      previousRankPoints: 1200,
      newRankPoints: 1242,
      changeAmount: 42,
      type: RankChangeType.increase,
      referenceResultId: id ?? 'match_win_1',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    quizResult: QuizResult(
      sessionId: id ?? 'match_win_1',
      playerId: 'user_1',
      gameMode: GameMode.tournament,
      category: 'General Knowledge',
      difficulty: Difficulty.hard,
      totalQuestions: 20,
      answeredQuestions: 20,
      correctAnswers: 18,
      wrongAnswers: 2,
      skipped: 0,
      timedOut: 0,
      accuracy: 0.9,
      finalScore: 8420,
      xpEarned: 500,
      longestStreak: 12,
      finalStreak: 5,
      averageResponseTime: const Duration(seconds: 4),
      fastestResponseTime: const Duration(seconds: 1),
      slowestResponseTime: const Duration(seconds: 8),
      questionResults: [],
      completedAt: DateTime.now().subtract(const Duration(hours: 2)),
      completionTime: const Duration(minutes: 8, seconds: 42),
      performanceRating: 'Excellent',
    ),
  );

  static CompetitiveMatch loss({String? id}) => CompetitiveMatch(
    result: CompetitiveResult(
      resultId: id ?? 'match_loss_1',
      userId: 'user_1',
      seasonId: 'season_1',
      outcome: CompetitiveOutcome.loss,
      mode: 'Pro Mode',
      score: 4200,
      completedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    rankChange: RankChange(
      changeId: 'rc_2',
      userId: 'user_1',
      seasonId: 'season_1',
      previousRank: 'Gold I',
      newRank: 'Gold I',
      previousRankPoints: 1242,
      newRankPoints: 1224,
      changeAmount: -18,
      type: RankChangeType.decrease,
      referenceResultId: id ?? 'match_loss_1',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    quizResult: QuizResult(
      sessionId: id ?? 'match_loss_1',
      playerId: 'user_1',
      gameMode: GameMode.pro,
      category: 'Science',
      difficulty: Difficulty.expert,
      totalQuestions: 15,
      answeredQuestions: 15,
      correctAnswers: 7,
      wrongAnswers: 8,
      skipped: 0,
      timedOut: 0,
      accuracy: 0.46,
      finalScore: 4200,
      xpEarned: 100,
      longestStreak: 3,
      finalStreak: 0,
      averageResponseTime: const Duration(seconds: 6),
      fastestResponseTime: const Duration(seconds: 2),
      slowestResponseTime: const Duration(seconds: 12),
      questionResults: [],
      completedAt: DateTime.now().subtract(const Duration(days: 1)),
      completionTime: const Duration(minutes: 6, seconds: 15),
      performanceRating: 'Poor',
    ),
  );

  static CompetitiveMatch draw({String? id}) => CompetitiveMatch(
    result: CompetitiveResult(
      resultId: id ?? 'match_draw_1',
      userId: 'user_1',
      seasonId: 'season_1',
      outcome: CompetitiveOutcome.draw,
      mode: 'Versus',
      score: 6500,
      completedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  );

  static List<CompetitiveMatch> list() => [
    win(id: 'w1'),
    loss(id: 'l1'),
    win(id: 'w2'),
    draw(id: 'd1'),
    win(id: 'w3'),
  ];
}
