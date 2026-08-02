import 'dart:async';
import 'package:soteria/features/question_content/data/data_sources/firestore_data_source.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/question_content/domain/repositories/question_repository.dart';
import 'package:soteria/features/question_content/data/validators/question_validator.dart';

/// Concrete implementation of the QuestionRepository.
/// Coordinates remote data fetching, local caching, and background prefetching.
class QuestionRepositoryImpl implements QuestionRepository {
  final FirestoreQuestionDataSource _remoteSource;

  // In-memory cache for demonstration. Production should use persistence (e.g. Hive/Isar).
  final Map<String, Question> _cache = {};

  QuestionRepositoryImpl({required FirestoreQuestionDataSource remoteSource})
    : _remoteSource = remoteSource;

  @override
  Future<List<Question>> getQuestions({
    String? category,
    String? topic,
    QuestionDifficulty? difficulty,
    int limit = 10,
    List<String>? tags,
  }) async {
    try {
      final remoteQuestions = await _remoteSource.fetchQuestions(
        category: category,
        topic: topic,
        difficulty: difficulty?.name,
        limit: limit,
      );

      final validQuestions = <Question>[];
      for (final q in remoteQuestions) {
        final validationErrors = QuestionValidator.validate(q);
        if (validationErrors.isEmpty) {
          _cache[q.id] = q;
          validQuestions.add(q);
        } else {
          // Log validation errors in a real app
        }
      }

      return validQuestions;
    } catch (e) {
      // Fallback to cache if remote fetch fails (Offline Support)
      return _cache.values
          .where((q) => category == null || q.category == category)
          .where((q) => difficulty == null || q.difficulty == difficulty)
          .take(limit)
          .toList();
    }
  }

  @override
  Future<Question?> getQuestionById(String id) async {
    if (_cache.containsKey(id)) return _cache[id];

    final remoteQuestion = await _remoteSource.fetchQuestionById(id);
    if (remoteQuestion != null) {
      _cache[id] = remoteQuestion;
    }
    return remoteQuestion;
  }

  @override
  Future<void> syncQuestions() async {
    // Logic for background synchronization (e.g. fetching popular categories)
    await getQuestions(limit: 50);
  }

  @override
  Future<void> clearCache() async {
    _cache.clear();
  }

  /// Implementation of prefetching logic.
  /// Fetches next questions in the background to avoid UI lag.
  void prefetchNextQuestions(List<String> questionIds) {
    for (final id in questionIds) {
      if (!_cache.containsKey(id)) {
        getQuestionById(id);
      }
    }
  }
}
