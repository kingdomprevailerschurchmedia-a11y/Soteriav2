import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/season_result.dart';
import '../../domain/repositories/competitive_history_repository.dart';
import '../../data/repositories/firebase_competitive_history_repository.dart';
import '../../../../core/identity/providers/identity_providers.dart';

final competitiveHistoryRepositoryProvider =
    Provider<CompetitiveHistoryRepository>((ref) {
      return FirebaseCompetitiveHistoryRepository(FirebaseFirestore.instance);
    });

final seasonHistoryProvider = StreamProvider<List<SeasonResult>>((ref) {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) {
    return Stream.value([]);
  }

  return ref
      .watch(competitiveHistoryRepositoryProvider)
      .watchSeasonHistory(session.uid!);
});

final latestSeasonResultProvider = FutureProvider<SeasonResult?>((ref) {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) {
    return null;
  }

  return ref
      .watch(competitiveHistoryRepositoryProvider)
      .getLatestSeasonResult(session.uid!);
});

final bestSeasonResultProvider = FutureProvider<SeasonResult?>((ref) {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) {
    return null;
  }

  return ref
      .watch(competitiveHistoryRepositoryProvider)
      .getBestSeasonResult(session.uid!);
});

final competitiveHistorySummaryProvider =
    Provider<AsyncValue<CompetitiveHistory>>((ref) {
      final historyAsync = ref.watch(seasonHistoryProvider);
      final latestAsync = ref.watch(latestSeasonResultProvider);
      final bestAsync = ref.watch(bestSeasonResultProvider);
      final session = ref.watch(sessionProvider);

      if (historyAsync.isLoading ||
          latestAsync.isLoading ||
          bestAsync.isLoading) {
        return const AsyncValue.loading();
      }

      if (historyAsync.hasError)
        return AsyncValue.error(historyAsync.error!, historyAsync.stackTrace!);
      if (latestAsync.hasError)
        return AsyncValue.error(latestAsync.error!, latestAsync.stackTrace!);
      if (bestAsync.hasError)
        return AsyncValue.error(bestAsync.error!, bestAsync.stackTrace!);

      return AsyncValue.data(
        CompetitiveHistory(
          userId: session.uid ?? '',
          results: historyAsync.value ?? [],
          latestResult: latestAsync.value,
          bestResult: bestAsync.value,
        ),
      );
    });
