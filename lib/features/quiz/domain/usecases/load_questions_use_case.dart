import '../models/quiz_enums.dart';
import '../models/question.dart';
import '../repositories/quiz_repository.dart';

class LoadQuestionsUseCase {
  final QuizRepository _repository;

  LoadQuestionsUseCase(this._repository);

  Future<List<Question>> execute({
    required GameMode mode,
    required String category,
    required Difficulty difficulty,
  }) {
    return _repository.loadQuestions(
      mode: mode,
      category: category,
      difficulty: difficulty,
    );
  }
}
