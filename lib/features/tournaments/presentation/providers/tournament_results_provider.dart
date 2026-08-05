import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/tournament_ranking.dart';
import 'tournament_leaderboard_provider.dart';

final tournamentResultsProvider =
    Provider.family<TournamentResultsData, String>((ref, tournamentId) {
      final rankingAsync = ref.watch(
        playerTournamentRankingProvider(tournamentId),
      );

      return TournamentResultsData(
        ranking: rankingAsync.value,
        isLoading: rankingAsync.isLoading,
        error: rankingAsync.error?.toString(),
      );
    });

class TournamentResultsData {
  final TournamentRanking? ranking;
  final bool isLoading;
  final String? error;

  TournamentResultsData({this.ranking, this.isLoading = false, this.error});
}
