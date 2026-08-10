import '../../models/quiz_enums.dart';
import '../../models/quiz_result.dart';
import '../../repositories/quiz_history_repository.dart';

class DifficultyPerformance {
  final Difficulty difficulty;
  final double averageAccuracy;
  final int quizzesPlayed;

  DifficultyPerformance({
    required this.difficulty,
    required this.averageAccuracy,
    required this.quizzesPlayed,
  });
}

class GetDifficultyPerformanceUseCase {
  final QuizHistoryRepository _repository;

  GetDifficultyPerformanceUseCase(this._repository);

  Future<List<DifficultyPerformance>> execute(String playerId) async {
    final results = await _repository.getResults(playerId);
    if (results.isEmpty) return [];

    final Map<Difficulty, List<QuizResult>> difficultyGroups = {};
    for (final result in results) {
      difficultyGroups.putIfAbsent(result.difficulty, () => []).add(result);
    }

    return difficultyGroups.entries.map((entry) {
      final difficultyResults = entry.value;
      final totalAccuracy = difficultyResults.fold(
        0.0,
        (sum, r) => sum + r.accuracy,
      );
      return DifficultyPerformance(
        difficulty: entry.key,
        averageAccuracy: totalAccuracy / difficultyResults.length,
        quizzesPlayed: difficultyResults.length,
      );
    }).toList();
  }
}
