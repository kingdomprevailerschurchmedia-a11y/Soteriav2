import 'package:uuid/uuid.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/models/question.dart';
import '../../domain/models/quiz_session.dart';
import '../../domain/models/quiz_result.dart';
import '../../domain/models/player_answer.dart';
import 'quiz_remote_data_source.dart';
import 'quiz_local_data_source.dart';

class MockQuizRemoteDataSource implements QuizRemoteDataSource {
  @override
  Future<List<Question>> loadQuestions({
    required GameMode mode,
    required String category,
    required Difficulty difficulty,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return []; // Return empty for now or add some mock data
  }

  @override
  Future<QuizSession> createSession({
    required String playerId,
    required GameMode mode,
    required String category,
    required Difficulty difficulty,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return QuizSession(
      sessionId: const Uuid().v4(),
      playerId: playerId,
      gameMode: mode,
      category: category,
      difficulty: difficulty,
      startedTime: DateTime.now(),
    );
  }

  @override
  Future<QuizSession?> restoreSession(String sessionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }

  @override
  Future<PlayerAnswer> submitAnswer({
    required String sessionId,
    required PlayerAnswer answer,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return answer;
  }

  @override
  Future<QuizResult> finishSession(String sessionId) async {
    await Future.delayed(const Duration(seconds: 1));
    return QuizResult(
      finalScore: 0,
      accuracy: 0.0,
      correctAnswers: 0,
      wrongAnswers: 0,
      skipped: 0,
      averageResponseTime: Duration.zero,
      longestStreak: 0,
      xpEarned: 0,
      coinsEarned: 0,
      rank: 'N/A',
      performanceGrade: 'N/A',
      timestamp: DateTime.now(),
    );
  }

  @override
  Future<void> syncSession(String sessionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

class MockQuizLocalDataSource implements QuizLocalDataSource {
  final Map<String, QuizSession> _cache = {};

  @override
  Future<void> saveProgress(QuizSession session) async {
    _cache[session.sessionId] = session;
  }

  @override
  Future<QuizSession?> loadProgress(String sessionId) async {
    return _cache[sessionId];
  }

  @override
  Future<void> clearProgress(String sessionId) async {
    _cache.remove(sessionId);
  }
}
