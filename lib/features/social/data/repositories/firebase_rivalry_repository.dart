import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../player/domain/models/competitive_result.dart';
import '../../../player/domain/repositories/competitive_result_repository.dart';
import '../../domain/models/player_rivalry.dart';
import '../../domain/repositories/rivalry_repository.dart';

class FirebaseRivalryRepository implements RivalryRepository {
  final CompetitiveResultRepository _resultRepository;

  FirebaseRivalryRepository(this._resultRepository);

  @override
  Future<PlayerRivalry> getRivalry(String userId, String rivalId) async {
    final results = await _resultRepository.getResults(
      userId,
      opponentId: rivalId,
      limit: 100, // Reasonable limit for calculation
    );

    if (results.isEmpty) {
      return PlayerRivalry(
        rivalryId: '${userId}_$rivalId',
        userId: userId,
        rivalId: rivalId,
        matchesPlayed: 0,
        wins: 0,
        losses: 0,
        draws: 0,
        lastMatchAt: DateTime.now(),
      );
    }

    int wins = 0;
    int losses = 0;
    int draws = 0;
    for (final r in results) {
      if (r.outcome == CompetitiveOutcome.win) wins++;
      else if (r.outcome == CompetitiveOutcome.loss) losses++;
      else if (r.outcome == CompetitiveOutcome.draw) draws++;
    }

    return PlayerRivalry(
      rivalryId: '${userId}_$rivalId',
      userId: userId,
      rivalId: rivalId,
      matchesPlayed: results.length,
      wins: wins,
      losses: losses,
      draws: draws,
      lastMatchAt: results.first.completedAt,
      lastOutcome: results.first.outcome,
      recentForm: results.take(5).map((e) => e.outcome).toList(),
    );
  }

  @override
  Future<List<PlayerRivalry>> getTopRivalries(String userId, {int limit = 5}) async {
    // This is tricky without a dedicated rivalry collection.
    // We'll fetch recent results and group by opponent.
    final recentResults = await _resultRepository.getRecentResults(userId, limit: 100);
    
    final opponentCounts = <String, int>{};
    for (final r in recentResults) {
      if (r.opponentId != null) {
        opponentCounts[r.opponentId!] = (opponentCounts[r.opponentId!] ?? 0) + 1;
      }
    }

    final topOpponents = opponentCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final topRivalryIds = topOpponents.take(limit).map((e) => e.key).toList();

    return Future.wait(topRivalryIds.map((rivalId) => getRivalry(userId, rivalId)));
  }
}
