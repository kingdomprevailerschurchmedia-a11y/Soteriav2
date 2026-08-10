import '../models/quiz_session.dart';

abstract class QuizSessionRepository {
  Future<void> saveSession(QuizSession session);
  Future<QuizSession?> loadActiveSession(String playerId);
  Future<QuizSession?> loadSession(String sessionId);
  Future<void> deleteSession(String sessionId);
  Future<void> clearExpiredSessions(Duration maxAge);
  Future<void> deleteAllSessions(String playerId);
}
