import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import '../../domain/models/tournament_ranking.dart';
import '../../data/repositories/tournament_repository_provider.dart';

final tournamentLeaderboardProvider =
    FutureProvider.family<List<TournamentRanking>, String>((
      ref,
      tournamentId,
    ) async {
      // In a real implementation, this would fetch the top 100 from the leaderboard collection
      return [];
    });

final playerTournamentRankingProvider =
    FutureProvider.family<TournamentRanking?, String>((
      ref,
      tournamentId,
    ) async {
      final repository = ref.watch(tournamentRepositoryProvider);
      final user = ref.watch(firebaseAuthProvider).currentUser;
      if (user == null) return null;

      return repository.getPlayerRanking(tournamentId, user.uid);
    });
