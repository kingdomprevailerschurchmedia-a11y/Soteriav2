import '../models/competitive_result.dart';
import '../models/rank_change.dart';
import '../repositories/player_progression_repository.dart';
import '../services/competitive_streak_service.dart';
import '../../../quiz/domain/models/quiz_result.dart';
import '../repositories/competitive_result_repository.dart';

class ProcessCompetitiveResultUseCase {
  final PlayerProgressionRepository _progressionRepository;
  final CompetitiveResultRepository _resultRepository;
  final CompetitiveStreakService _streakService;

  ProcessCompetitiveResultUseCase(
    this._progressionRepository,
    this._resultRepository,
    this._streakService,
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
    await _streakService.processResult(
      userId: result.userId,
      result: result,
      recentResults: recentResults,
      recentQuizResults: recentQuizResults,
    );

    return rankChange;
  }
}
