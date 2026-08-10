import '../../domain/models/quiz_session.dart';
import '../../domain/repositories/quiz_session_repository.dart';
import '../datasource/quiz_local_data_source.dart';

class QuizSessionRepositoryImpl implements QuizSessionRepository {
  final QuizLocalDataSource _localDataSource;

  QuizSessionRepositoryImpl(this._localDataSource);

  @override
  Future<void> saveSession(QuizSession session) async {
    await _localDataSource.saveProgress(session);
  }

  @override
  Future<QuizSession?> loadActiveSession(String playerId) async {
    // For now, we assume there's only one "active" or "recoverable" session per player
    // This could be more sophisticated if we query by status
    // But since QuizLocalDataSource is simple, we might need to extend it
    // or just rely on the latest one found if we can list them.
    // For simplicity, I'll use a fixed key or similar in a real implementation.
    // But let's check what MockQuizLocalDataSource does.
    return _localDataSource.loadProgress('active_session_$playerId');
  }

  @override
  Future<QuizSession?> loadSession(String sessionId) async {
    return _localDataSource.loadProgress(sessionId);
  }

  @override
  Future<void> deleteSession(String sessionId) async {
    await _localDataSource.clearProgress(sessionId);
  }

  @override
  Future<void> clearExpiredSessions(Duration maxAge) async {
    // Not implemented in mock, but would be in real SQL storage
  }

  @override
  Future<void> deleteAllSessions(String playerId) async {
    await _localDataSource.clearAllProgress(playerId);
  }
}
