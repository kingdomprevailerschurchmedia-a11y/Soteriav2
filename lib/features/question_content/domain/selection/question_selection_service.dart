import '../../../../core/logging/logger_service.dart';
import '../repositories/question_repository.dart';
import '../entities/question.dart';
import 'selection_models.dart';
import 'selection_strategy.dart';

class QuestionSelectionService {
  final QuestionRepository _repository;

  QuestionSelectionService(this._repository);

  /// Selects questions based on the provided request.
  Future<QuestionSelectionResult> selectQuestions(QuestionSelectionRequest request) async {
    try {
      final List<Question> pool = [];
      
      // If no categories specified, search across all categories
      if (request.categoryIds.isEmpty) {
        final questions = await _repository.getQuestions(
          difficulty: request.difficulty,
          limit: request.questionCount * 2,
        );
        pool.addAll(questions);
      } else {
        // Fetch questions for each specified category in parallel to build the pool
        final results = await Future.wait(
          request.categoryIds.map((categoryId) => _repository.getQuestions(
            categoryId: categoryId,
            difficulty: request.difficulty,
            limit: request.questionCount * 2,
          ))
        );
        for (final questions in results) {
          pool.addAll(questions);
        }
      }

      // Filter out excluded questions
      final filteredPool = pool.where((q) => !request.excludedQuestionIds.contains(q.id)).toList();

      if (filteredPool.isEmpty) {
        // Attempt fallback to all categories if preferred ones are empty
        if (request.categoryIds.isNotEmpty) {
           final fallbackPool = await _repository.getQuestions(
             difficulty: request.difficulty,
             limit: request.questionCount,
           );
           if (fallbackPool.isNotEmpty) {
             return _finalizeSelection(fallbackPool, request.questionCount, SelectionStatus.success);
           }
        }
        LoggerService.w('Insufficient questions for Pro Mode session pool.', feature: 'QuestionSelection');
        return const QuestionSelectionResult(
          questions: [],
          status: SelectionStatus.insufficientContent,
        );
      }

      // Determine strategy
      final strategy = request.categoryIds.length > 1 
          ? BalancedCategoryStrategy() 
          : RandomSelectionStrategy();

      final selected = strategy.select(filteredPool, request.questionCount);

      if (selected.length < request.questionCount) {
        LoggerService.w('Strategy selected too few questions: ${selected.length} < ${request.questionCount}', feature: 'QuestionSelection');
        return QuestionSelectionResult(
          questions: selected,
          status: SelectionStatus.insufficientContent,
        );
      }

      return _finalizeSelection(selected, request.questionCount, SelectionStatus.success);
    } catch (e) {
      LoggerService.e('Question selection failed', error: e, feature: 'QuestionSelection');
      return const QuestionSelectionResult(
        questions: [],
        status: SelectionStatus.error,
      );
    }
  }

  QuestionSelectionResult _finalizeSelection(List<Question> questions, int requestedCount, SelectionStatus status) {
    // Ensure we don't return more than requested
    final finalQuestions = questions.take(requestedCount).toList();
    return QuestionSelectionResult(
      questions: finalQuestions,
      status: status,
    );
  }
}
