import '../models/quiz_enums.dart';
import '../models/question.dart';
import '../models/quiz_session.dart';
import '../models/quiz_result.dart';
import '../models/player_answer.dart';

abstract class QuizRepository {
  Future<List<Question>> loadQuestions({
    required GameMode mode,
    required String category,
    required Difficulty difficulty,
  });

  Future<QuizSession> createSession({
    required String playerId,
    required GameMode mode,
    required String category,
    required Difficulty difficulty,
  });

  Future<QuizSession?> restoreSession(String sessionId);

  Future<PlayerAnswer> submitAnswer({
    required String sessionId,
    required PlayerAnswer answer,
  });

  Future<QuizResult> finishSession(String sessionId);

  Future<int> calculateScore(String sessionId);

  Future<void> saveProgress(QuizSession session);

  Future<QuizSession?> loadProgress(String sessionId);

  Future<bool> validateAnswer({
    required String questionId,
    required List<String> selectedOptionIds,
  });

  Future<void> syncSession(String sessionId);
}
