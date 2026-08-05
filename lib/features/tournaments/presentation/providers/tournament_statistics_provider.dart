import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../player/providers/player_providers.dart';

final tournamentStatisticsProvider = Provider<TournamentStatistics>((ref) {
  final player = ref.watch(currentPlayerProvider);

  if (player == null) {
    return const TournamentStatistics();
  }

  // Usually calculated from player profile fields
  return TournamentStatistics(
    totalWins: player.gamesWon, // Simplified mapping
    participation: player.gamesPlayed,
    tournamentXP: 0, // Placeholder
    tournamentCoins: 0, // Placeholder
  );
});

class TournamentStatistics {
  final int totalWins;
  final int participation;
  final int tournamentXP;
  final int tournamentCoins;

  const TournamentStatistics({
    this.totalWins = 0,
    this.participation = 0,
    this.tournamentXP = 0,
    this.tournamentCoins = 0,
  });
}
