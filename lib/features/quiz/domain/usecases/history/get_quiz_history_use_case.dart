import '../../models/quiz_result.dart';
import '../../repositories/quiz_history_repository.dart';

class GetQuizHistoryUseCase {
  final QuizHistoryRepository _repository;

  GetQuizHistoryUseCase(this._repository);

  Future<List<QuizResult>> execute(String playerId) {
    return _repository.getResults(playerId);
  }
}
