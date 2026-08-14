import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import '../../domain/models/competitive_match_result.dart';
import '../../domain/repositories/match_result_repository.dart';
import '../../data/repositories/firebase_match_result_repository.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../../question_content/domain/repositories/question_repository.dart';
import '../../../question_content/data/repositories/question_repository_impl.dart';
import '../../../question_content/data/data_sources/firestore_data_source.dart';
import '../../../question_content/domain/entities/question.dart';
import '../../domain/models/competitive_match_replay.dart';
import '../../domain/services/competitive_insights_service.dart';
import '../../../player/presentation/providers/match_history_providers.dart';

final matchResultRepositoryProvider = Provider<MatchResultRepository>((ref) {
  return FirebaseMatchResultRepository(ref.watch(firestoreProvider));
});

final currentMatchResultProvider = StreamProvider.family<CompetitiveMatchResult?, String>((ref, matchId) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value(null);

  return ref.watch(matchResultRepositoryProvider).observeMatchResult(matchId, userId);
});

final competitiveInsightsServiceProvider = Provider((ref) => CompetitiveInsightsService());

final competitiveInsightsProvider = FutureProvider<CompetitiveInsights>((ref) async {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return CompetitiveInsightsService().calculateInsights([]);
  
  final historyAsync = ref.watch(matchHistoryProvider(userId));
  return historyAsync.when(
    data: (history) => ref.read(competitiveInsightsServiceProvider).calculateInsights(history),
    loading: () => CompetitiveInsightsService().calculateInsights([]),
    error: (_, __) => CompetitiveInsightsService().calculateInsights([]),
  );
});

final questionRepositoryProvider = Provider<QuestionRepository>((ref) {
  return QuestionRepositoryImpl(
    remoteSource: FirestoreQuestionDataSource(ref.watch(firestoreDatabaseServiceProvider)),
  );
});

final matchReplayProvider = FutureProvider.family<CompetitiveMatchReplay?, String>((ref, matchId) async {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return null;

  final result = await ref.watch(matchResultRepositoryProvider).getMatchResult(matchId, userId);
  if (result == null) return null;

  final questionRepo = ref.read(questionRepositoryProvider);
  final questionIds = result.playerPerformance.answers.map((a) => a.questionId).toList();
  
  final questions = await Future.wait(
    questionIds.map((id) => questionRepo.getQuestionById(id))
  );

  return CompetitiveMatchReplay(
    result: result,
    questions: questions.whereType<Question>().toList(),
  );
});

class RematchNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> requestRematch(String matchId) async {
    state = const AsyncValue.loading();
    try {
      final userId = ref.read(authRepositoryProvider).currentUserId;
      if (userId == null) throw Exception('Not authenticated');

      await ref.read(matchResultRepositoryProvider).requestRematch(matchId, userId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final rematchControllerProvider =
    AutoDisposeAsyncNotifierProvider<RematchNotifier, void>(
  RematchNotifier.new,
);
