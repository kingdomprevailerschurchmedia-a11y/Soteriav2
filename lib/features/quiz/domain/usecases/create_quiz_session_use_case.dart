import '../models/quiz_enums.dart';
import '../models/quiz_session.dart';
import '../repositories/quiz_repository.dart';

class CreateQuizSessionUseCase {
  final QuizRepository _repository;

  CreateQuizSessionUseCase(this._repository);

  Future<QuizSession> execute({
    required String playerId,
    required GameMode mode,
    required String category,
    required Difficulty difficulty,
  }) {
    return _repository.createSession(
      playerId: playerId,
      mode: mode,
      category: category,
      difficulty: difficulty,
    );
  }
}
