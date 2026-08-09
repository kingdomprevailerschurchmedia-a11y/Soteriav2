import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/quiz_repository.dart';
import 'quiz_repository_impl.dart';
import '../datasource/quiz_remote_data_source.dart';
import '../datasource/quiz_local_data_source.dart';
import '../datasource/quiz_data_sources_impl.dart';

final quizRemoteDataSourceProvider = Provider<QuizRemoteDataSource>((ref) {
  return MockQuizRemoteDataSource();
});

final quizLocalDataSourceProvider = Provider<QuizLocalDataSource>((ref) {
  return MockQuizLocalDataSource();
});

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepositoryImpl(
    remoteDataSource: ref.watch(quizRemoteDataSourceProvider),
    localDataSource: ref.watch(quizLocalDataSourceProvider),
  );
});
