import 'package:uuid/uuid.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/models/question.dart';
import '../../domain/models/quiz_session.dart';
import '../../domain/models/quiz_result.dart';
import '../../domain/models/player_answer.dart';
import '../../domain/models/answer_option.dart';
import '../../domain/models/power_up_state.dart';
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
    return [
      Question(
        id: 'q1',
        type: QuestionType.multipleChoice,
        categoryId: category,
        difficulty: difficulty,
        text: 'What is the capital of France?',
        options: [
          const Answer(id: 'o1', text: 'Paris'),
          const Answer(id: 'o2', text: 'London'),
          const Answer(id: 'o3', text: 'Berlin'),
          const Answer(id: 'o4', text: 'Madrid'),
        ],
        correctOptionIds: ['o1'],
        estimatedTime: const Duration(seconds: 30),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Mock',
      ),
      Question(
        id: 'q2',
        type: QuestionType.multipleChoice,
        categoryId: category,
        difficulty: difficulty,
        text: 'Which planet is known as the Red Planet?',
        options: [
          const Answer(id: 'o1', text: 'Mars'),
          const Answer(id: 'o2', text: 'Venus'),
          const Answer(id: 'o3', text: 'Jupiter'),
          const Answer(id: 'o4', text: 'Saturn'),
        ],
        correctOptionIds: ['o1'],
        estimatedTime: const Duration(seconds: 30),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Mock',
      ),
    ];
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
      powerUps: [
        const PowerUpState(type: PowerUpType.fiftyFifty),
        const PowerUpState(type: PowerUpType.pauseTimer),
        const PowerUpState(type: PowerUpType.askAudience),
      ],
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
      sessionId: sessionId,
      playerId: 'mock_p1',
      gameMode: GameMode.practice,
      category: 'Science',
      difficulty: Difficulty.easy,
      totalQuestions: 0,
      answeredQuestions: 0,
      correctAnswers: 0,
      wrongAnswers: 0,
      skipped: 0,
      timedOut: 0,
      accuracy: 0.0,
      finalScore: 0,
      xpEarned: 0,
      coinsEarned: 0,
      longestStreak: 0,
      finalStreak: 0,
      averageResponseTime: Duration.zero,
      fastestResponseTime: Duration.zero,
      slowestResponseTime: Duration.zero,
      questionResults: [],
      completedAt: DateTime.now(),
      completionTime: Duration.zero,
      performanceRating: 'N/A',
    );
  }

  @override
  Future<void> syncSession(String sessionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}

class MockQuizLocalDataSource implements QuizLocalDataSource {
  final Map<String, QuizSession> _cache = {};
  final Map<String, QuizResult> _resultsCache = {};

  @override
  Future<void> saveProgress(QuizSession session) async {
    _cache[session.sessionId] = session;
    // Also save as active session for the player
    _cache['active_session_${session.playerId}'] = session;
  }

  @override
  Future<QuizSession?> loadProgress(String sessionId) async {
    return _cache[sessionId];
  }

  @override
  Future<void> clearProgress(String sessionId) async {
    final session = _cache[sessionId];
    if (session != null) {
      _cache.remove('active_session_${session.playerId}');
    }
    _cache.remove(sessionId);
  }

  @override
  Future<void> clearAllProgress(String playerId) async {
    _cache.remove('active_session_$playerId');
    _cache.removeWhere((key, value) => value.playerId == playerId);
  }

  @override
  Future<void> saveResult(QuizResult result) async {
    _resultsCache[result.sessionId] = result;
  }

  @override
  Future<QuizResult?> getResult(String sessionId) async {
    return _resultsCache[sessionId];
  }

  @override
  Future<List<QuizResult>> getResults(String playerId) async {
    return _resultsCache.values.where((r) => r.playerId == playerId).toList();
  }

  @override
  Future<void> deleteResult(String sessionId) async {
    _resultsCache.remove(sessionId);
  }

  @override
  Future<void> clearHistory(String playerId) async {
    _resultsCache.removeWhere((key, value) => value.playerId == playerId);
  }
}
