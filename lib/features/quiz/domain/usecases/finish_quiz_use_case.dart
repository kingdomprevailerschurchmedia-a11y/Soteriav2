import '../models/quiz_result.dart';
import '../repositories/quiz_repository.dart';

class FinishQuizUseCase {
  final QuizRepository _repository;

  FinishQuizUseCase(this._repository);

  Future<QuizResult> execute(String sessionId) {
    return _repository.finishSession(sessionId);
  }
}
