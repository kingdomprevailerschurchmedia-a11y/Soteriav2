import '../repositories/quiz_repository.dart';

class CalculateScoreUseCase {
  final QuizRepository _repository;

  CalculateScoreUseCase(this._repository);

  Future<int> execute(String sessionId) {
    return _repository.calculateScore(sessionId);
  }
}
