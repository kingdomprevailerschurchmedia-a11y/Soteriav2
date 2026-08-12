import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/player_progression.dart';
import '../../domain/models/xp_transaction.dart';
import '../../domain/repositories/player_progression_repository.dart';
import '../../data/repositories/firebase_player_progression_repository.dart';
import '../../domain/services/progression_service.dart';
import '../../domain/services/competitive_ranking_engine.dart';
import '../../domain/models/player_statistics.dart';
import '../../domain/models/player_profile.dart';
import '../../../../core/identity/providers/identity_providers.dart';
import '../../providers/player_providers.dart';
import '../../domain/repositories/competitive_result_repository.dart';
import '../../data/repositories/firebase_competitive_result_repository.dart';

// --- Services ---
final progressionServiceProvider = Provider<ProgressionService>((ref) {
  return ProgressionService();
});

final rankingEngineProvider = Provider<CompetitiveRankingEngine>((ref) {
  return CompetitiveRankingEngine();
});

// --- Repositories ---
final playerProgressionRepositoryProvider =
    Provider<PlayerProgressionRepository>((ref) {
      return FirebasePlayerProgressionRepository(
        FirebaseFirestore.instance,
        ref.watch(progressionServiceProvider),
        ref.watch(rankingEngineProvider),
      );
    });

final competitiveResultRepositoryProvider =
    Provider<CompetitiveResultRepository>((ref) {
      return FirebaseCompetitiveResultRepository(FirebaseFirestore.instance);
    });

// --- Progression State ---
final competitiveProgressionProvider = StreamProvider<PlayerProgression>((ref) {
  final session = ref.watch(sessionProvider);
  if (!session.isAuthenticated || session.uid == null) {
    // Return a dummy initial state instead of throwing to prevent UI hangs during logout/login transitions
    return Stream.value(PlayerProgression.initial('guest', 'none'));
  }

  return ref
      .watch(playerProgressionRepositoryProvider)
      .watchProgression(session.uid!);
});

final currentCompetitiveLevelProvider = Provider<int>((ref) {
  return ref
      .watch(competitiveProgressionProvider)
      .when(data: (p) => p.currentLevel, loading: () => 1, error: (_, __) => 1);
});

final lifetimeCompetitiveXpProvider = Provider<int>((ref) {
  return ref
      .watch(competitiveProgressionProvider)
      .when(data: (p) => p.lifetimeXp, loading: () => 0, error: (_, __) => 0);
});

final competitiveXpProgressProvider = Provider<double>((ref) {
  return ref
      .watch(competitiveProgressionProvider)
      .when(
        data: (p) => p.xpProgress,
        loading: () => 0.0,
        error: (_, __) => 0.0,
      );
});

final playerStatisticsProvider = Provider<PlayerStatistics>((ref) {
  final player = ref.watch(currentPlayerProvider);
  if (player == null) return const PlayerStatistics();

  return PlayerStatistics(
    totalQuestionsAnswered: player.totalQuestionsAnswered,
    overallAccuracy: player.accuracy,
    totalStudyTime: Duration(seconds: player.practiceSessions * 300),
    averageResponseTimeMs: 4500,
  );
});

// --- Actions ---
final applyXpTransactionProvider =
    Provider<Future<void> Function(XpTransaction)>((ref) {
      final repository = ref.watch(playerProgressionRepositoryProvider);
      return (transaction) => repository.applyXpTransaction(transaction);
    });
