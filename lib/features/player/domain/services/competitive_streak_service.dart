import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/competitive_streak.dart';
import '../models/competitive_result.dart';
import '../repositories/streak_repository.dart';
import 'competitive_streak_engine.dart';
import '../../../quiz/domain/models/quiz_result.dart';

class CompetitiveStreakService {
  final StreakRepository _repository;
  final CompetitiveStreakEngine _engine;

  CompetitiveStreakService(this._repository, this._engine);

  Future<CompetitiveStreak> processResult({
    required String userId,
    required CompetitiveResult result,
    required List<CompetitiveResult> recentResults,
    required List<QuizResult> recentQuizResults,
  }) async {
    // 1. Fetch Current Streak
    var currentStreak = await _repository.getWinStreak(userId);
    currentStreak ??= CompetitiveStreak(
      userId: userId,
      type: StreakType.win,
      current: 0,
      best: 0,
      seasonBest: 0,
      startedAt: DateTime.now(),
      lastQualifiedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // 2. Update Streak
    final updatedStreak = _engine.updateWinStreak(
      currentStreak: currentStreak,
      result: result,
    );

    await _repository.updateWinStreak(updatedStreak);

    // 3. Update Momentum
    final updatedMomentum = _engine.calculateMomentum(
      userId: userId,
      recentResults: [result, ...recentResults],
      currentStreak: updatedStreak,
      recentQuizResults: recentQuizResults,
    );

    await _repository.updateMomentum(updatedMomentum);

    return updatedStreak;
  }
}
