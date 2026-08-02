import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/question_content/data/data_sources/firestore_data_source.dart';
import 'package:soteria/features/question_content/data/repositories/question_repository_impl.dart';
import 'package:soteria/features/question_content/domain/repositories/question_repository.dart';
import 'package:soteria/features/question_content/domain/selection/selection_strategy.dart';

/// Provider for the remote Firestore data source.
final firestoreDataSourceProvider = Provider<FirestoreQuestionDataSource>((
  ref,
) {
  return FirestoreQuestionDataSource();
});

/// Core repository provider for question content.
final questionRepositoryProvider = Provider<QuestionRepository>((ref) {
  final remoteSource = ref.watch(firestoreDataSourceProvider);
  return QuestionRepositoryImpl(remoteSource: remoteSource);
});

/// Provider for the active question selection strategy.
/// Can be overridden based on the game mode.
final questionSelectionStrategyProvider = Provider<QuestionSelectionStrategy>((
  ref,
) {
  return RandomSelectionStrategy();
});

/// Helper provider to prefetch questions.
final questionPrefetchProvider = Provider.family<void, List<String>>((
  ref,
  ids,
) {
  final repository = ref.watch(questionRepositoryProvider);
  if (repository is QuestionRepositoryImpl) {
    repository.prefetchNextQuestions(ids);
  }
});
