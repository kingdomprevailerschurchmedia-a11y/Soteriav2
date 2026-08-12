import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/rank_change.dart';
import '../../domain/models/competitive_result.dart';
import '../../domain/repositories/rank_history_repository.dart';
import '../../data/repositories/firebase_rank_history_repository.dart';
import '../../domain/services/competitive_ranking_engine.dart';
import 'progression_providers.dart';
import '../../../../core/identity/providers/identity_providers.dart';
import '../../domain/usecases/process_competitive_result_use_case.dart';
import 'streak_providers.dart';
import '../../../quiz/presentation/providers/history_providers.dart';

// --- Services ---
final rankingEngineProvider = Provider<CompetitiveRankingEngine>((ref) {
  return CompetitiveRankingEngine();
});

// --- Repositories ---
final rankHistoryRepositoryProvider = Provider<RankHistoryRepository>((ref) {
  return FirebaseRankHistoryRepository(FirebaseFirestore.instance);
});

// --- Rank History State ---
final rankHistoryProvider = StreamProvider<List<RankChange>>((ref) {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) {
    return Stream.value([]);
  }

  return ref
      .watch(rankHistoryRepositoryProvider)
      .watchRankHistory(session.uid!);
});

final recentRankChangesProvider = FutureProvider<List<RankChange>>((ref) {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) {
    return [];
  }

  return ref
      .watch(rankHistoryRepositoryProvider)
      .getRankHistory(session.uid!, limit: 10);
});

// --- Rank Info (Derived) ---
final currentRankPointsProvider = Provider<int>((ref) {
  return ref
      .watch(competitiveProgressionProvider)
      .when(data: (p) => p.rankPoints, loading: () => 0, error: (_, __) => 0);
});

final currentRankNameProvider = Provider<String>((ref) {
  return ref
      .watch(competitiveProgressionProvider)
      .when(
        data: (p) => p.currentRank,
        loading: () => 'Unranked',
        error: (_, __) => 'Unranked',
      );
});

// --- Actions ---
final processCompetitiveResultUseCaseProvider =
    Provider<ProcessCompetitiveResultUseCase>((ref) {
      return ProcessCompetitiveResultUseCase(
        ref.watch(playerProgressionRepositoryProvider),
        ref.watch(competitiveResultRepositoryProvider),
        ref.watch(streakServiceProvider),
      );
    });

final applyCompetitiveResultProvider =
    Provider<Future<RankChange> Function(CompetitiveResult)>((ref) {
      final useCase = ref.watch(processCompetitiveResultUseCaseProvider);

      return (result) async {
        final recentQuizResults = await ref.read(historyListProvider.future);

        return useCase.execute(
          result: result,
          recentQuizResults: recentQuizResults,
        );
      };
    });
