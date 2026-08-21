import 'dart:async';
import '../../domain/entities/question.dart';
import '../../domain/entities/difficulty.dart';
import '../../domain/repositories/question_repository.dart';
import '../data_sources/firestore_data_source.dart';
import '../mappers/question_mapper.dart';
import '../validators/question_validator.dart';

/// Concrete implementation of the QuestionRepository.
class QuestionRepositoryImpl implements QuestionRepository {
  final FirestoreQuestionDataSource _remoteSource;

  // In-memory cache.
  final Map<String, Question> _cache = {};

  QuestionRepositoryImpl({required this._remoteSource});

  @override
  Future<List<Question>> getQuestions({
    String? categoryId,
    String? subcategoryId,
    String? topicId,
    Difficulty? difficulty,
    int limit = 10,
    String? startAfterId,
    List<String>? tags,
  }) async {
    try {
      final dtos = await _remoteSource.fetchQuestions(
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        topicId: topicId,
        difficulty: difficulty?.name,
        limit: limit,
        startAfterId: startAfterId,
      );

      final validQuestions = <Question>[];
      for (final dto in dtos) {
        final entity = QuestionMapper.fromDto(dto);
        final errors = QuestionValidator.validate(entity);
        if (errors.isEmpty) {
          _cache[entity.id] = entity;
          validQuestions.add(entity);
        }
      }

      return validQuestions;
    } catch (e) {
      // Fallback to cache for offline support if remote fails
      return _cache.values
          .where((q) => q.status == QuestionStatus.published)
          .where((q) => categoryId == null || q.categoryId == categoryId)
          .where((q) => subcategoryId == null || q.subcategoryId == subcategoryId)
          .where((q) => topicId == null || q.topicId == topicId)
          .where((q) => difficulty == null || q.difficulty == difficulty)
          .take(limit)
          .toList();
    }
  }

  @override
  Future<Question?> getQuestionById(String id) async {
    if (_cache.containsKey(id)) return _cache[id];

    final dto = await _remoteSource.fetchQuestionById(id);
    if (dto != null) {
      final entity = QuestionMapper.fromDto(dto);
      _cache[id] = entity;
      return entity;
    }
    return null;
  }

  @override
  Stream<Question?> watchQuestion(String id) {
    return _remoteSource.watchQuestion(id).map((dto) {
      if (dto == null) return null;
      final entity = QuestionMapper.fromDto(dto);
      _cache[id] = entity;
      return entity;
    });
  }

  @override
  Future<void> syncQuestionsPool({
    String? categoryId,
    Difficulty? difficulty,
  }) async {
    // Background pre-fetching to fill cache
    await getQuestions(
      categoryId: categoryId,
      difficulty: difficulty,
      limit: 50,
    );
  }

  @override
  Future<void> clearCache() async {
    _cache.clear();
  }

  @override
  Future<List<Question>> getQuestionsByStatus(QuestionStatus status, {int limit = 50}) async {
    final dtos = await _remoteSource.fetchQuestions(
      status: status.name,
      limit: limit,
    );
    return dtos.map((dto) => QuestionMapper.fromDto(dto)).toList();
  }
}
