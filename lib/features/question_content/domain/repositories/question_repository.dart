import 'package:soteria/features/question_content/domain/entities/question.dart';

/// Abstract interface defining how questions are retrieved and managed.
/// This decouples the engine from specific data sources (Firebase, Local, etc.).
abstract class QuestionRepository {
  /// Fetches a list of questions based on a set of filters.
  Future<List<Question>> getQuestions({
    String? category,
    String? topic,
    QuestionDifficulty? difficulty,
    int limit = 10,
    List<String>? tags,
  });

  /// Fetches a single question by its unique ID.
  Future<Question?> getQuestionById(String id);

  /// Synchronizes local cache with the remote source.
  Future<void> syncQuestions();

  /// Invalidates and clears the local cache.
  Future<void> clearCache();
}
