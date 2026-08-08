import '../repositories/quiz_repository.dart';

class ValidateAnswerUseCase {
  final QuizRepository _repository;

  ValidateAnswerUseCase(this._repository);

  Future<bool> execute({
    required String questionId,
    required List<String> selectedOptionIds,
  }) {
    return _repository.validateAnswer(
      questionId: questionId,
      selectedOptionIds: selectedOptionIds,
    );
  }
}
