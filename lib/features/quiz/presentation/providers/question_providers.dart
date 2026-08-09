import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/question.dart';
import '../../domain/models/quiz_enums.dart';
import '../../domain/repositories/question_repository.dart';
import '../../data/repository/question_repository_impl.dart';
import '../../data/repository/mock_question_repository.dart';
import '../../data/datasource/question_remote_data_source.dart';
import '../../data/datasource/question_local_data_source.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';

// Repository Provider
final questionRepositoryProvider = Provider<IQuestionRepository>((ref) {
  // Check if we are in preview mode or test environment
  // In a real app, this might use a configuration provider
  const bool useMock = false;

  if (useMock) {
    return MockQuestionRepository();
  }

  return QuestionRepositoryImpl(
    remoteDataSource: FirestoreQuestionRemoteDataSource(
      ref.watch(firestoreDatabaseServiceProvider),
    ),
    localDataSource: SprefsQuestionLocalDataSource(),
  );
});

// Loader parameters
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
  int get hashCode => categoryId.hashCode ^ difficulty.hashCode;
}

// Question Loader Provider
final questionLoaderProvider =
    FutureProvider.family<List<Question>, QuestionQuery>((ref, query) async {
      final repository = ref.watch(questionRepositoryProvider);
      return repository.loadQuestions(
        categoryId: query.categoryId,
        difficulty: query.difficulty,
      );
    });

// Random Questions Provider
final randomQuestionsProvider = FutureProvider.family<List<Question>, int>((
  ref,
  limit,
) async {
  final repository = ref.watch(questionRepositoryProvider);
  return repository.loadRandomQuestions(limit: limit);
});
