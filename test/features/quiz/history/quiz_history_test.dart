import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/quiz/data/datasource/quiz_data_sources_impl.dart';
import 'package:soteria/features/quiz/data/repository/quiz_history_repository_impl.dart';
import 'package:soteria/features/quiz/domain/models/quiz_result.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';
import 'package:soteria/features/quiz/domain/usecases/history/get_performance_summary_use_case.dart';
import 'package:soteria/features/quiz/domain/usecases/history/get_category_performance_use_case.dart';

void main() {
  late MockQuizLocalDataSource localDataSource;
  late QuizHistoryRepositoryImpl repository;
  late GetPerformanceSummaryUseCase summaryUseCase;
  late GetCategoryPerformanceUseCase categoryUseCase;

  setUp(() {
    localDataSource = MockQuizLocalDataSource();
    repository = QuizHistoryRepositoryImpl(localDataSource);
    summaryUseCase = GetPerformanceSummaryUseCase(repository);
    categoryUseCase = GetCategoryPerformanceUseCase(repository);
  });

  final mockResult = QuizResult(
    sessionId: 's1',
    playerId: 'user1',
    gameMode: GameMode.practice,
    category: 'Science',
    difficulty: Difficulty.easy,
    totalQuestions: 10,
    answeredQuestions: 10,
    correctAnswers: 8,
    wrongAnswers: 2,
    skipped: 0,
    timedOut: 0,
    accuracy: 0.8,
    finalScore: 1000,
    xpEarned: 100,
    longestStreak: 5,
    finalStreak: 2,
    averageResponseTime: const Duration(seconds: 2),
    fastestResponseTime: const Duration(seconds: 1),
    slowestResponseTime: const Duration(seconds: 3),
    questionResults: [],
    completedAt: DateTime.now(),
    completionTime: const Duration(minutes: 1),
    performanceRating: 'Good',
  );

  group('Quiz History Repository Tests', () {
    test('addResult stores result in local data source', () async {
      await repository.addResult(mockResult);
      final results = await repository.getResults('user1');
      expect(results.length, 1);
      expect(results.first.sessionId, 's1');
    });

    test('getResults filters by playerId', () async {
      await repository.addResult(mockResult);
      await repository.addResult(
        mockResult.copyWith(sessionId: 's2', playerId: 'user2'),
      );

      final user1Results = await repository.getResults('user1');
      expect(user1Results.length, 1);
      expect(user1Results.first.playerId, 'user1');
    });

    test('clearHistory removes results only for specific player', () async {
      await repository.addResult(mockResult);
      await repository.addResult(
        mockResult.copyWith(sessionId: 's2', playerId: 'user2'),
      );

      await repository.clearHistory('user1');

      expect((await repository.getResults('user1')).isEmpty, true);
      expect((await repository.getResults('user2')).length, 1);
    });
  });

  group('Performance Aggregation Tests', () {
    test('summaryUseCase calculates correct statistics', () async {
      await repository.addResult(mockResult); // 80% accuracy, 1000 score
      await repository.addResult(
        mockResult.copyWith(
          sessionId: 's2',
          accuracy: 0.6,
          finalScore: 500,
          longestStreak: 3,
        ),
      );

      final summary = await summaryUseCase.execute('user1');

      expect(summary.totalQuizzes, 2);
      expect(summary.averageAccuracy, 0.7);
      expect(summary.averageScore, 750);
      expect(summary.bestScore, 1000);
      expect(summary.bestStreak, 5);
    });

    test('categoryUseCase groups results by category', () async {
      await repository.addResult(mockResult); // Science
      await repository.addResult(
        mockResult.copyWith(
          sessionId: 's2',
          category: 'History',
          accuracy: 0.9,
        ),
      );
      await repository.addResult(
        mockResult.copyWith(
          sessionId: 's3',
          category: 'Science',
          accuracy: 1.0,
        ),
      );

      final performances = await categoryUseCase.execute('user1');

      expect(performances.length, 2);
      final science = performances.firstWhere((p) => p.category == 'Science');
      expect(science.averageAccuracy, 0.9); // (0.8 + 1.0) / 2
      expect(science.quizzesPlayed, 2);
    });
  });
}
