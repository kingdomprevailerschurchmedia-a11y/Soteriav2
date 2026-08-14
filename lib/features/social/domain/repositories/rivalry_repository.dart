import '../models/player_rivalry.dart';

abstract interface class RivalryRepository {
  /// Calculates rivalry statistics for a specific opponent.
  Future<PlayerRivalry> getRivalry(String userId, String rivalId);

  /// Identifies and fetches top rivalries based on match frequency.
  Future<List<PlayerRivalry>> getTopRivalries(String userId, {int limit = 5});
}
