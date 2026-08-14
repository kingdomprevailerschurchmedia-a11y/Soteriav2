import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/difficulty.dart';
import '../../domain/repositories/question_repository.dart';
import '../../data/repositories/question_repository_impl.dart';
import '../../data/data_sources/firestore_data_source.dart';
import '../../domain/selection/selection_strategy.dart';

/// Provider for the remote Firestore data source.
final firestoreQuestionDataSourceProvider = Provider<FirestoreQuestionDataSource>((ref) {
  return FirestoreQuestionDataSource(
    ref.watch(firestoreDatabaseServiceProvider),
  );
});

/// The canonical provider for the Question Repository.
final questionRepositoryProvider = Provider<QuestionRepository>((ref) {
  return QuestionRepositoryImpl(
    remoteSource: ref.watch(firestoreQuestionDataSourceProvider),
  );
});

/// Provider for the active question selection strategy.
/// Can be overridden based on the game mode.
final questionSelectionStrategyProvider = Provider<QuestionSelectionStrategy>((ref) {
  return RandomSelectionStrategy();
});

/// Parameters for querying questions.
class QuestionBankQuery {
  final String? categoryId;
  final String? subcategoryId;
  final String? topicId;
  final Difficulty? difficulty;
  final int limit;

  QuestionBankQuery({
    this.categoryId,
    this.subcategoryId,
    this.topicId,
    this.difficulty,
    this.limit = 10,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionBankQuery &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId &&
          subcategoryId == other.subcategoryId &&
          topicId == other.topicId &&
          difficulty == other.difficulty &&
          limit == other.limit;

  @override
  int get hashCode =>
      categoryId.hashCode ^
      subcategoryId.hashCode ^
      topicId.hashCode ^
      difficulty.hashCode ^
      limit.hashCode;
}

/// Provider for fetching a list of published questions.
final questionBankProvider = FutureProvider.family<List<Question>, QuestionBankQuery>((ref, query) async {
  final repository = ref.watch(questionRepositoryProvider);
  return repository.getQuestions(
    categoryId: query.categoryId,
    subcategoryId: query.subcategoryId,
    topicId: query.topicId,
    difficulty: query.difficulty,
    limit: query.limit,
  );
});

/// Provider for watching a specific question by ID.
final questionByIdProvider = StreamProvider.family<Question?, String>((ref, id) {
  final repository = ref.watch(questionRepositoryProvider);
  return repository.watchQuestion(id);
});
