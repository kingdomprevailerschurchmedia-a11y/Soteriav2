import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'question_bank_providers.dart';
import '../../domain/selection/question_selection_service.dart';
import '../../domain/selection/selection_models.dart';
import '../../domain/entities/question.dart';
import '../../../player/providers/player_providers.dart';

/// Provider for the Question Selection Service.
final questionSelectionServiceProvider = Provider<QuestionSelectionService>((ref) {
  return QuestionSelectionService(ref.watch(questionRepositoryProvider));
});

/// Provider for personalized question selection.
/// Uses user interests from their profile to select a pool of questions.
final personalizedQuestionSelectionProvider = FutureProvider.family<QuestionSelectionResult, QuestionSelectionRequest>((ref, request) async {
  final service = ref.watch(questionSelectionServiceProvider);
  
  // If request has no categories, try to use user's favorite categories
  if (request.categoryIds.isEmpty) {
    final profile = ref.watch(currentPlayerStreamProvider).value;
    if (profile != null && profile.favoriteCategories.isNotEmpty) {
      final updatedRequest = request.copyWith(categoryIds: profile.favoriteCategories);
      return service.selectQuestions(updatedRequest);
    }
  }

  return service.selectQuestions(request);
});

/// A simpler provider that just returns a list of questions based on a request.
final selectedQuestionsProvider = FutureProvider.family<List<Question>, QuestionSelectionRequest>((ref, request) async {
  final result = await ref.watch(personalizedQuestionSelectionProvider(request).future);
  return result.questions;
});
