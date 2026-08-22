import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/rank_change.dart';
import '../../domain/models/competitive_result.dart';
import '../../domain/repositories/rank_history_repository.dart';
import '../../data/repositories/firebase_rank_history_repository.dart';
import '../../domain/services/competitive_ranking_engine.dart';
import '../../domain/models/rank_progress.dart';
import 'progression_providers.dart';
import '../../../../core/identity/providers/identity_providers.dart';
import '../../domain/usecases/process_competitive_result_use_case.dart';
import 'streak_providers.dart';
import '../../../quiz/presentation/providers/history_providers.dart';
import 'personal_record_providers.dart';
import 'leaderboard_providers.dart';

import 'achievement_providers.dart';

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

final unacknowledgedRankChangesProvider = StreamProvider<List<RankChange>>((
  ref,
) {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) {
    return Stream.value([]);
  }

  return ref
      .watch(rankHistoryRepositoryProvider)
      .watchUnacknowledgedChanges(session.uid!);
});

final acknowledgeRankChangeActionProvider = Provider<
  Future<void> Function(String)
>((ref) {
  final repository = ref.watch(rankHistoryRepositoryProvider);
  return (changeId) => repository.acknowledgeRankChange(changeId);
});

// --- Rank Info (Derived) ---
final currentRankPointsProvider = Provider<int>((ref) {
  return ref
      .watch(competitiveProgressionProvider)
      .when(data: (p) => p.rankPoints, loading: () => 0, error: (_, _) => 0);
});

final currentRankNameProvider = Provider<String>((ref) {
  return ref
      .watch(competitiveProgressionProvider)
      .when(
        data: (p) => p.currentRank,
        loading: () => 'Unranked',
        error: (_, _) => 'Unranked',
      );
});

final rankProgressProvider = Provider<AsyncValue<RankProgress>>((ref) {
  final progressionAsync = ref.watch(competitiveProgressionProvider);
  final engine = ref.watch(rankingEngineProvider);

  return progressionAsync.whenData((p) {
    return engine.calculateRankProgress(p.rankPoints);
  });
});

// --- Actions ---
final processCompetitiveResultUseCaseProvider =
    Provider<ProcessCompetitiveResultUseCase>((ref) {
      return ProcessCompetitiveResultUseCase(
        ref.watch(playerProgressionRepositoryProvider),
        ref.watch(competitiveResultRepositoryProvider),
        ref.watch(streakServiceProvider),
        ref.watch(personalRecordServiceProvider),
        ref.watch(leaderboardRepositoryProvider),
        ref.watch(achievementServiceProvider),
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
