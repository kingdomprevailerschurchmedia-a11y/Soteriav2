import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/models/quiz_result.dart';
import 'quiz_providers.dart';
import '../../../../core/identity/providers/identity_providers.dart';
import '../../domain/usecases/history/get_performance_summary_use_case.dart';

enum HistorySort {
  newest,
  oldest,
  highestScore,
  highestAccuracy,
  highestXp,
  bestStreak,
}

class HistoryFilters {
  final GameMode? mode;
  final String? category;
  final Difficulty? difficulty;
  final DateTime? startDate;
  final DateTime? endDate;

  const HistoryFilters({
    this.mode,
    this.category,
    this.difficulty,
    this.startDate,
    this.endDate,
  });

  HistoryFilters copyWith({
    GameMode? mode,
    String? category,
    Difficulty? difficulty,
    DateTime? startDate,
    DateTime? endDate,
    bool clearMode = false,
    bool clearCategory = false,
    bool clearDifficulty = false,
  }) {
    return HistoryFilters(
      mode: clearMode ? null : (mode ?? this.mode),
      category: clearCategory ? null : (category ?? this.category),
      difficulty: clearDifficulty ? null : (difficulty ?? this.difficulty),
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  bool get isEmpty =>
      mode == null &&
      category == null &&
      difficulty == null &&
      startDate == null &&
      endDate == null;
}

final historyFiltersProvider = StateProvider<HistoryFilters>(
  (ref) => const HistoryFilters(),
);
final historySearchProvider = StateProvider<String>((ref) => '');
final historySortProvider = StateProvider<HistorySort>(
  (ref) => HistorySort.newest,
);

final historyListProvider = FutureProvider<List<QuizResult>>((ref) async {
  final playerId = ref.watch(sessionProvider).uid;
  if (playerId == null) return [];

  final filters = ref.watch(historyFiltersProvider);
  final search = ref.watch(historySearchProvider).toLowerCase();
  final sort = ref.watch(historySortProvider);

  final repository = ref.watch(quizHistoryRepositoryProvider);

  List<QuizResult> results = await repository.getResults(playerId);

  // Apply filters
  if (filters.mode != null) {
    results = results.where((r) => r.gameMode == filters.mode).toList();
  }
  if (filters.category != null) {
    results = results.where((r) => r.category == filters.category).toList();
  }
  if (filters.difficulty != null) {
    results = results.where((r) => r.difficulty == filters.difficulty).toList();
  }
  if (filters.startDate != null) {
    results = results
        .where((r) => r.completedAt.isAfter(filters.startDate!))
        .toList();
  }
  if (filters.endDate != null) {
    results = results
        .where((r) => r.completedAt.isBefore(filters.endDate!))
        .toList();
  }

  // Apply search
  if (search.isNotEmpty) {
    results = results
        .where(
          (r) =>
              r.category.toLowerCase().contains(search) ||
              r.gameMode.name.toLowerCase().contains(search) ||
              r.difficulty.name.toLowerCase().contains(search) ||
              r.performanceRating.toLowerCase().contains(search),
        )
        .toList();
  }

  // Apply sort
  switch (sort) {
    case HistorySort.newest:
      results.sort((a, b) => b.completedAt.compareTo(a.completedAt));
      break;
    case HistorySort.oldest:
      results.sort((a, b) => a.completedAt.compareTo(b.completedAt));
      break;
    case HistorySort.highestScore:
      results.sort((a, b) => b.finalScore.compareTo(a.finalScore));
      break;
    case HistorySort.highestAccuracy:
      results.sort((a, b) => b.accuracy.compareTo(a.accuracy));
      break;
    case HistorySort.highestXp:
      results.sort((a, b) => b.xpEarned.compareTo(a.xpEarned));
      break;
    case HistorySort.bestStreak:
      results.sort((a, b) => b.longestStreak.compareTo(a.longestStreak));
      break;
  }

  return results;
});

final performanceSummaryProvider = FutureProvider<PerformanceSummary>((
  ref,
) async {
  final playerId = ref.watch(sessionProvider).uid;
  if (playerId == null) return PerformanceSummary.empty();

  final useCase = ref.watch(getPerformanceSummaryUseCaseProvider);
  return useCase.execute(playerId);
});

final categoryPerformanceProvider = FutureProvider((ref) async {
  final playerId = ref.watch(sessionProvider).uid;
  if (playerId == null) return [];

  final useCase = ref.watch(getCategoryPerformanceUseCaseProvider);
  return useCase.execute(playerId);
});

final difficultyPerformanceProvider = FutureProvider((ref) async {
  final playerId = ref.watch(sessionProvider).uid;
  if (playerId == null) return [];

  final useCase = ref.watch(getDifficultyPerformanceUseCaseProvider);
  return useCase.execute(playerId);
});
