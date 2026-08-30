import '../../../../core/logging/logger_service.dart';
import '../../../gameplay_engine/models/game_mode.dart';
import '../repositories/question_repository.dart';
import '../../data/data_sources/local_question_data_source.dart';
import '../../data/mappers/question_mapper.dart';
import '../entities/question.dart';
import '../entities/difficulty.dart';
import 'selection_models.dart';
import 'selection_strategy.dart';

class QuestionSelectionService {
  final QuestionRepository _repository;
  final LocalQuestionDataSource? _localDataSource;

  QuestionSelectionService(this._repository, [this._localDataSource]);

  /// Selects questions based on the provided request.
  Future<QuestionSelectionResult> selectQuestions(QuestionSelectionRequest request) async {
    try {
      final List<Question> pool = [];
      
      // Increase fetch limit if many questions are excluded to ensure a valid pool after filtering
      final int fetchLimit = request.excludedQuestionIds.length > request.questionCount 
          ? (request.questionCount + request.excludedQuestionIds.length) 
          : request.questionCount * 2;

      // Determine mode-specific tags
      List<String>? modeTags;
      if (request.mode == GameMode.practice) {
        modeTags = ['practice'];
      } else if (request.mode == GameMode.pro || 
                 request.mode == GameMode.versus || 
                 request.mode == GameMode.tournament) {
        modeTags = ['competitive'];
      }

      // Handle Adaptive Difficulty: Pull from all difficulties to create a dynamic range
      final Difficulty? filterDifficulty = request.difficulty == Difficulty.adaptive ? null : request.difficulty;
      
      // If no categories specified, search across all categories
      if (request.categoryIds.isEmpty) {
        final questions = await _repository.getQuestions(
          difficulty: filterDifficulty,
          limit: fetchLimit,
          tags: modeTags,
        );
        pool.addAll(questions);
      } else {
        // Fetch questions for each specified category in parallel to build the pool
        final results = await Future.wait(
          request.categoryIds.map((categoryId) => _repository.getQuestions(
            categoryId: categoryId,
            difficulty: filterDifficulty,
            limit: fetchLimit,
            tags: modeTags,
          ))
        );
        for (final questions in results) {
          pool.addAll(questions);
        }
      }

      // Filter out excluded questions
      var filteredPool = pool.where((q) => !request.excludedQuestionIds.contains(q.id)).toList();

      // SMART FALLBACK: If mode-specific pool is empty, try again with general pool
      if (filteredPool.isEmpty && modeTags != null) {
        LoggerService.w('No mode-specific content for ${request.mode?.name}. Falling back to general pool.', feature: 'QuestionSelection');
        
        final List<Question> fallbackPool = [];
        if (request.categoryIds.isEmpty) {
          fallbackPool.addAll(await _repository.getQuestions(
            difficulty: filterDifficulty,
            limit: request.questionCount * 2,
          ));
        } else {
          final results = await Future.wait(
            request.categoryIds.map((categoryId) => _repository.getQuestions(
              categoryId: categoryId,
              difficulty: filterDifficulty,
              limit: request.questionCount * 2,
            ))
          );
          for (final questions in results) {
            fallbackPool.addAll(questions);
          }
        }
        filteredPool = fallbackPool.where((q) => !request.excludedQuestionIds.contains(q.id)).toList();
      }

      // LOCAL STARTER BANK FALLBACK: If Practice mode is still empty, load from local asset
      if (filteredPool.isEmpty && request.mode == GameMode.practice && _localDataSource != null) {
        LoggerService.i('Falling back to local Starter Bank for Practice Mode', feature: 'QuestionSelection');
        final dtos = await _localDataSource.fetchStarterQuestions();
        final localQuestions = dtos.map((dto) => QuestionMapper.fromDto(dto)).toList();
        
        filteredPool = localQuestions.where((q) => 
          (request.categoryIds.isEmpty || request.categoryIds.contains(q.categoryId)) &&
          (filterDifficulty == null || q.difficulty == filterDifficulty) &&
          !request.excludedQuestionIds.contains(q.id)
        ).toList();
      }

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
