import '../repositories/quiz_session_repository.dart';

class DeleteSessionUseCase {
  final QuizSessionRepository _repository;

  DeleteSessionUseCase(this._repository);

  Future<void> execute(String sessionId) {
    return _repository.deleteSession(sessionId);
  }
}
