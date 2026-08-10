import '../../models/quiz_result.dart';
import '../../repositories/quiz_history_repository.dart';

class CategoryPerformance {
  final String category;
  final double averageAccuracy;
  final int quizzesPlayed;

  CategoryPerformance({
    required this.category,
    required this.averageAccuracy,
    required this.quizzesPlayed,
  });
}

class GetCategoryPerformanceUseCase {
  final QuizHistoryRepository _repository;

  GetCategoryPerformanceUseCase(this._repository);

  Future<List<CategoryPerformance>> execute(String playerId) async {
    final results = await _repository.getResults(playerId);
    if (results.isEmpty) return [];

    final Map<String, List<QuizResult>> categoryGroups = {};
    for (final result in results) {
      categoryGroups.putIfAbsent(result.category, () => []).add(result);
    }

    return categoryGroups.entries.map((entry) {
      final categoryResults = entry.value;
      final totalAccuracy = categoryResults.fold(
        0.0,
        (sum, r) => sum + r.accuracy,
      );
      return CategoryPerformance(
        category: entry.key,
        averageAccuracy: totalAccuracy / categoryResults.length,
        quizzesPlayed: categoryResults.length,
      );
    }).toList()..sort((a, b) => b.averageAccuracy.compareTo(a.averageAccuracy));
  }
}
