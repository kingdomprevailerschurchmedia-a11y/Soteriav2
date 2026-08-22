import '../../domain/models/quiz_enums.dart';
import '../../domain/models/question.dart';
import '../../domain/models/quiz_session.dart';
import '../../domain/models/quiz_result.dart';
import '../../domain/models/player_answer.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasource/quiz_remote_data_source.dart';
import '../datasource/quiz_local_data_source.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDataSource _remoteDataSource;
  final QuizLocalDataSource _localDataSource;

  QuizRepositoryImpl({
    required this._remoteDataSource,
    required this._localDataSource,
  });

  @override
  Future<List<Question>> loadQuestions({
    required GameMode mode,
    required String category,
    required Difficulty difficulty,
  }) {
    return _remoteDataSource.loadQuestions(
      mode: mode,
      category: category,
      difficulty: difficulty,
    );
  }

  @override
  Future<QuizSession> createSession({
    required String playerId,
    required GameMode mode,
    required String category,
    required Difficulty difficulty,
  }) {
    return _remoteDataSource.createSession(
      playerId: playerId,
      mode: mode,
      category: category,
      difficulty: difficulty,
    );
  }

  @override
  Future<QuizSession?> restoreSession(String sessionId) {
    return _remoteDataSource.restoreSession(sessionId);
  }

  @override
  Future<PlayerAnswer> submitAnswer({
    required String sessionId,
    required PlayerAnswer answer,
  }) {
    return _remoteDataSource.submitAnswer(sessionId: sessionId, answer: answer);
  }

  @override
  Future<QuizResult> finishSession(String sessionId) {
    return _remoteDataSource.finishSession(sessionId);
  }

  @override
  Future<int> calculateScore(String sessionId) async {
    // Basic calculation for now, could be moved to remote if needed
    final session = await _remoteDataSource.restoreSession(sessionId);
    if (session == null) return 0;
    return session.currentScore;
  }

  @override
  Future<void> saveProgress(QuizSession session) {
    return _localDataSource.saveProgress(session);
  }

  @override
  Future<QuizSession?> loadProgress(String sessionId) {
    return _localDataSource.loadProgress(sessionId);
  }

  @override
  Future<bool> validateAnswer({
    required String questionId,
    required List<String> selectedOptionIds,
  }) async {
    // This would typically involve a call to remote or a local check against loaded questions
    // For now, we'll return false as it's just a contract
    return false;
  }

  @override
  Future<void> syncSession(String sessionId) {
    return _remoteDataSource.syncSession(sessionId);
  }
}
