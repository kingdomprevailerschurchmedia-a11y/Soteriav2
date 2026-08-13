import '../models/competitive_result.dart';
import '../models/rank_change.dart';
import '../repositories/player_progression_repository.dart';
import '../services/competitive_streak_service.dart';
import '../../../quiz/domain/models/quiz_result.dart';
import '../repositories/competitive_result_repository.dart';
import '../services/personal_record_service.dart';
import '../models/competitive_match.dart';
import '../repositories/leaderboard_repository.dart';

class ProcessCompetitiveResultUseCase {
  final PlayerProgressionRepository _progressionRepository;
  final CompetitiveResultRepository _resultRepository;
  final CompetitiveStreakService _streakService;
  final PersonalRecordService _recordService;
  final LeaderboardRepository _leaderboardRepository;

  ProcessCompetitiveResultUseCase(
    this._progressionRepository,
    this._resultRepository,
    this._streakService,
    this._recordService,
    this._leaderboardRepository,
  );

  Future<RankChange> execute({
    required CompetitiveResult result,
    required List<QuizResult> recentQuizResults,
  }) async {
    // 1. Record the raw result
    await _resultRepository.recordResult(result);

    // 2. Fetch context for streak/momentum
    final recentResults = await _resultRepository.getRecentResults(
      result.userId,
      limit: 10,
    );

    // 3. Apply Result to Progression (Ranking, XP)
    final rankChange = await _progressionRepository.applyCompetitiveResult(
      result,
    );

    // 4. Update Streak & Momentum
    final updatedStreak = await _streakService.processResult(
      userId: result.userId,
      result: result,
      recentResults: recentResults,
      recentQuizResults: recentQuizResults,
    );

    // 5. Evaluate Personal Records
    // Try to find the matching QuizResult for this match
    final currentQuizResult = recentQuizResults.isEmpty 
        ? null 
        : recentQuizResults.firstWhere(
            (q) => q.sessionId == result.resultId, 
            orElse: () => recentQuizResults.first,
          );

    final match = CompetitiveMatch(
      result: result,
      rankChange: rankChange,
      quizResult: currentQuizResult,
    );

    await _recordService.evaluateMatch(match);
    await _recordService.evaluateStreak(updatedStreak);

    // 6. Evaluate Progression Records (Leaderboard Position)
    final globalPosition = await _leaderboardRepository.getPlayerRankPosition(
      userId: result.userId,
    );
    
    final updatedProgression = await _progressionRepository.getProgression(result.userId);

    if (updatedProgression != null) {
      await _recordService.evaluateProgression(
        userId: result.userId,
        progression: updatedProgression,
        globalPosition: globalPosition,
        seasonId: result.seasonId,
      );
    }

    return rankChange;
  }
}
