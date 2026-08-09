import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/question.dart';
import '../dto/question_dto.dart';
import '../mapper/question_mapper.dart';

abstract interface class IQuestionLocalDataSource {
  Future<void> cacheQuestions(String key, List<Question> questions);
  Future<List<Question>?> getCachedQuestions(String key);
  Future<void> clearCache();
}

class SprefsQuestionLocalDataSource implements IQuestionLocalDataSource {
  static const _kCachePrefix = 'quiz_questions_cache_';
  static const _kTimestampPrefix = 'quiz_questions_timestamp_';
  static const _kCacheExpiry = Duration(hours: 24);

  @override
  Future<void> cacheQuestions(String key, List<Question> questions) async {
    final prefs = await SharedPreferences.getInstance();
    final dtoList = questions
        .map((q) => QuestionMapper.toDto(q).toJson())
        .toList();

    await prefs.setString(_kCachePrefix + key, jsonEncode(dtoList));
    await prefs.setInt(
      _kTimestampPrefix + key,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  Future<List<Question>?> getCachedQuestions(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_kCachePrefix + key);
    final timestamp = prefs.getInt(_kTimestampPrefix + key);

    if (cachedData == null || timestamp == null) return null;

    final lastUpdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    if (DateTime.now().difference(lastUpdate) > _kCacheExpiry) {
      return null; // Cache expired
    }

    final List<dynamic> decoded = jsonDecode(cachedData);
    return decoded
        .map(
          (item) => QuestionMapper.fromDto(
            QuestionDto.fromJson(item as Map<String, dynamic>),
          ),
        )
        .toList();
  }

  @override
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where(
      (k) => k.startsWith(_kCachePrefix) || k.startsWith(_kTimestampPrefix),
    );
    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}
