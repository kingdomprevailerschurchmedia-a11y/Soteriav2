import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/question_content/domain/entities/question.dart';
import '../../../../features/question_content/domain/entities/difficulty.dart';
import '../../../../features/question_content/domain/repositories/question_repository.dart';
import '../../../../features/question_content/presentation/providers/question_bank_providers.dart' as canonical;

// Redirection to the canonical Question Bank providers for backward compatibility.

/// The canonical provider for the Question Repository.
final questionRepositoryProvider = Provider<QuestionRepository>((ref) {
  return ref.watch(canonical.questionRepositoryProvider);
});

/// Parameters for querying questions (compatible with the new system).
class QuestionQuery {
  final String? categoryId;
  final Difficulty? difficulty;

  QuestionQuery({this.categoryId, this.difficulty});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionQuery &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId &&
          difficulty == other.difficulty;

  @override
  int get hashCode => categoryId.hashCode ^ (difficulty?.hashCode ?? 0);
}

/// Redirects to the canonical question bank provider.
final questionLoaderProvider =
    FutureProvider.family<List<Question>, QuestionQuery>((ref, query) async {
      return ref.watch(canonical.questionBankProvider(canonical.QuestionBankQuery(
        categoryId: query.categoryId,
        difficulty: query.difficulty,
      )).future);
    });

/// Redirects to the canonical random questions provider.
final randomQuestionsProvider = FutureProvider.family<List<Question>, int>((
  ref,
  limit,
) async {
  final repository = ref.watch(questionRepositoryProvider);
  return repository.getQuestions(limit: limit);
});
