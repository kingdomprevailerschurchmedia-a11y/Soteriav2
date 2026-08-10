import '../models/quiz_session.dart';
import '../repositories/quiz_session_repository.dart';

class LoadActiveSessionUseCase {
  final QuizSessionRepository _repository;

  LoadActiveSessionUseCase(this._repository);

  Future<QuizSession?> execute(String playerId) {
    return _repository.loadActiveSession(playerId);
  }
}
