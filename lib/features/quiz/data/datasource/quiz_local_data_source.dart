import '../../domain/models/quiz_session.dart';

abstract class QuizLocalDataSource {
  Future<void> saveProgress(QuizSession session);
  Future<QuizSession?> loadProgress(String sessionId);
  Future<void> clearProgress(String sessionId);
}
