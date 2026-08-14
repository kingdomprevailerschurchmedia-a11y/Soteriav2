import '../entities/question.dart';
import '../entities/difficulty.dart';

/// Abstract interface for the Question Bank repository.
abstract interface class QuestionRepository {
  /// Fetches published questions based on taxonomy and difficulty.
  Future<List<Question>> getQuestions({
    String? categoryId,
    String? subcategoryId,
    String? topicId,
    Difficulty? difficulty,
    int limit = 10,
    String? startAfterId,
    List<String>? tags,
  });

  /// Fetches a specific question by ID.
  Future<Question?> getQuestionById(String id);

  /// Watches a question for real-time updates.
  Stream<Question?> watchQuestion(String id);

  /// Synchronizes local cache with the remote source.
  Future<void> syncQuestionsPool({
    String? categoryId,
    Difficulty? difficulty,
  });

  /// Invalidates and clears the local cache.
  Future<void> clearCache();

  /// Admin-only: Fetches questions by status.
  Future<List<Question>> getQuestionsByStatus(QuestionStatus status, {int limit = 50});
}
