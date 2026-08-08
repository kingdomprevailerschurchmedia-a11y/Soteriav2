import '../../domain/models/quiz_enums.dart';
import '../../domain/models/question.dart';
import '../../domain/models/quiz_session.dart';
import '../../domain/models/quiz_result.dart';
import '../../domain/models/player_answer.dart';

abstract class QuizRemoteDataSource {
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

  Future<void> syncSession(String sessionId);
}
