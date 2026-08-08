import '../models/quiz_session.dart';
import '../repositories/quiz_repository.dart';

class SaveProgressUseCase {
  final QuizRepository _repository;

  SaveProgressUseCase(this._repository);

  Future<void> execute(QuizSession session) {
    return _repository.saveProgress(session);
  }
}
