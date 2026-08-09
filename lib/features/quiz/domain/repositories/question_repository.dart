import '../models/question.dart';
import '../models/quiz_enums.dart';

abstract interface class IQuestionRepository {
  Future<List<Question>> loadQuestions({
    String? categoryId,
    Difficulty? difficulty,
    bool forceRefresh = false,
  });

  Future<List<Question>> loadByCategory(
    String categoryId, {
    bool forceRefresh = false,
  });

  Future<List<Question>> loadByDifficulty(
    Difficulty difficulty, {
    bool forceRefresh = false,
  });

  Future<List<Question>> loadRandomQuestions({int limit = 10});

  Future<void> refreshQuestions({String? categoryId, Difficulty? difficulty});

  Future<void> clearCache();
}
