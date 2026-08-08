import '../models/quiz_session.dart';
import '../repositories/quiz_repository.dart';

class RestoreSessionUseCase {
  final QuizRepository _repository;

  RestoreSessionUseCase(this._repository);

  Future<QuizSession?> execute(String sessionId) {
    return _repository.restoreSession(sessionId);
  }
}
