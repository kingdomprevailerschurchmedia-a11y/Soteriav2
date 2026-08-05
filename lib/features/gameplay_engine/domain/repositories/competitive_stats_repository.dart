import '../../models/game_result.dart';

abstract interface class CompetitiveStatsRepository {
  /// Updates aggregated player statistics based on a session result.
  Future<void> updatePlayerStats(String uid, GameResult result, int coinsDelta);
}
