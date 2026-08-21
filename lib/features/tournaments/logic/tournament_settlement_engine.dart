import '../domain/models/tournament.dart';
import '../domain/models/tournament_ranking.dart';
import '../domain/models/tournament_reward.dart';
import '../domain/models/tournament_raw_result.dart';

class TournamentSettlementEngine {
  /// Sorts and ranks tournament sessions based on deterministic rules.
  static List<TournamentRanking> calculateFinalRanking(
    List<TournamentRawResult> results,
  ) {
    // 1. Sort based on the rules:
    // Highest Score -> Highest Accuracy -> Fastest Completion Time -> Earliest Completion Timestamp
    final sortedResults = List<TournamentRawResult>.from(results)
      ..sort((a, b) {
        // Higher score is better
        if (b.score != a.score) return b.score.compareTo(a.score);

        // Higher accuracy is better
        if (b.accuracy != a.accuracy) return b.accuracy.compareTo(a.accuracy);

        // Lower time is better
        if (a.completionTime != b.completionTime) {
          return a.completionTime.compareTo(b.completionTime);
        }

        // Earlier timestamp is better (tie-breaker)
        return a.completionTimestamp.compareTo(b.completionTimestamp);
      });

    final List<TournamentRanking> rankings = [];
    for (int i = 0; i < sortedResults.length; i++) {
      final res = sortedResults[i];
      final isTie =
          i > 0 &&
          res.score == sortedResults[i - 1].score &&
          res.accuracy == sortedResults[i - 1].accuracy &&
          res.completionTime == sortedResults[i - 1].completionTime;

      rankings.add(
        TournamentRanking(
          rank: i + 1,
          uid: res.uid,
          displayName: res.displayName,
          photoUrl: res.photoUrl,
          score: res.score,
          accuracy: res.accuracy,
          completionTime: res.completionTime,
          completionTimestamp: res.completionTimestamp,
          isTie: isTie,
        ),
      );
    }

    return rankings;
  }

  /// Calculates the prize distribution for each rank based on tournament prize pool.
  static List<TournamentRanking> distributePrizes(
    Tournament tournament,
    List<TournamentRanking> rankings,
  ) {
    final pool = tournament.prizePool;

    return rankings.map((r) {
      TournamentReward? reward;

      if (r.rank == 1) {
        reward = TournamentReward(
          coins: (pool * 0.5).toInt(),
          xp: 1000,
          titles: ['Champion'],
        );
      } else if (r.rank == 2) {
        reward = TournamentReward(coins: (pool * 0.25).toInt(), xp: 500);
      } else if (r.rank == 3) {
        reward = TournamentReward(coins: (pool * 0.15).toInt(), xp: 250);
      } else if (r.rank <= 10) {
        reward = TournamentReward(coins: (pool * 0.01).toInt(), xp: 100);
      } else {
        // Participation Reward
        reward = const TournamentReward(xp: 50);
      }

      return TournamentRanking(
        rank: r.rank,
        uid: r.uid,
        displayName: r.displayName,
        photoUrl: r.photoUrl,
        score: r.score,
        accuracy: r.accuracy,
        completionTime: r.completionTime,
        completionTimestamp: r.completionTimestamp,
        prize: reward,
        isTie: r.isTie,
      );
    }).toList();
  }
}
