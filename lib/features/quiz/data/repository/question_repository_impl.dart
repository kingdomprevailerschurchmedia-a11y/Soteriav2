import '../../domain/models/question.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/repositories/question_repository.dart';
import '../datasource/question_remote_data_source.dart';
import '../datasource/question_local_data_source.dart';
import '../../../../core/logging/logger_service.dart';

class QuestionRepositoryImpl implements IQuestionRepository {
  final IQuestionRemoteDataSource _remoteDataSource;
  final IQuestionLocalDataSource _localDataSource;

  QuestionRepositoryImpl({
    required IQuestionRemoteDataSource remoteDataSource,
    required IQuestionLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<List<Question>> loadQuestions({
    String? categoryId,
    Difficulty? difficulty,
    bool forceRefresh = false,
  }) async {
    final cacheKey = _getCacheKey(categoryId, difficulty);

    if (!forceRefresh) {
      try {
        final cached = await _localDataSource.getCachedQuestions(cacheKey);
        if (cached != null && cached.isNotEmpty) {
          LoggerService.d('Loaded questions from cache for key: $cacheKey');
          // Refresh in background
          _refreshInBackground(cacheKey, categoryId, difficulty);
          return cached;
        }
      } catch (e) {
        LoggerService.w('Failed to load questions from cache: $e');
      }
    }

    return _fetchAndCache(cacheKey, categoryId, difficulty);
  }

  @override
  Future<List<Question>> loadByCategory(
    String categoryId, {
    bool forceRefresh = false,
  }) {
    return loadQuestions(categoryId: categoryId, forceRefresh: forceRefresh);
  }

  @override
  Future<List<Question>> loadByDifficulty(
    Difficulty difficulty, {
    bool forceRefresh = false,
  }) {
    return loadQuestions(difficulty: difficulty, forceRefresh: forceRefresh);
  }

  @override
  Future<List<Question>> loadRandomQuestions({int limit = 10}) async {
    try {
      return await _remoteDataSource.fetchRandomQuestions(limit: limit);
    } catch (e) {
      LoggerService.e('Failed to load random questions: $e');
      // Fallback to any cached questions if remote fails
      final cached = await _localDataSource.getCachedQuestions('all');
      if (cached != null) {
        cached.shuffle();
        return cached.take(limit).toList();
      }
      rethrow;
    }
  }

  @override
  Future<void> refreshQuestions({
    String? categoryId,
    Difficulty? difficulty,
  }) async {
    final cacheKey = _getCacheKey(categoryId, difficulty);
    await _fetchAndCache(cacheKey, categoryId, difficulty);
  }

  @override
  Future<void> clearCache() => _localDataSource.clearCache();

  String _getCacheKey(String? categoryId, Difficulty? difficulty) {
    return '${categoryId ?? 'all'}_${difficulty?.name ?? 'all'}';
  }

  Future<List<Question>> _fetchAndCache(
    String key,
    String? categoryId,
    Difficulty? difficulty,
  ) async {
    try {
      final remoteQuestions = await _remoteDataSource.fetchQuestions(
        categoryId: categoryId,
        difficulty: difficulty,
      );
      await _localDataSource.cacheQuestions(key, remoteQuestions);
      return remoteQuestions;
    } catch (e) {
      LoggerService.e('Failed to fetch questions from remote: $e');
      // If forceRefresh was true and remote failed, we might still want to try cache as ultimate fallback
      final cached = await _localDataSource.getCachedQuestions(key);
      if (cached != null) return cached;
      rethrow;
    }
  }

  void _refreshInBackground(
    String key,
    String? categoryId,
    Difficulty? difficulty,
  ) {
    _fetchAndCache(key, categoryId, difficulty).catchError((e) {
      LoggerService.w('Background refresh failed for key $key: $e');
      return <Question>[];
    });
  }
}
