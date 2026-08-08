import '../models/player_answer.dart';
import '../repositories/quiz_repository.dart';

class SubmitAnswerUseCase {
  final QuizRepository _repository;

  SubmitAnswerUseCase(this._repository);

  Future<PlayerAnswer> execute({
    required String sessionId,
    required PlayerAnswer answer,
  }) {
    return _repository.submitAnswer(sessionId: sessionId, answer: answer);
  }
}
