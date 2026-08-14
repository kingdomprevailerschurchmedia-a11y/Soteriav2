import '../../player/domain/models/competitive_result.dart';
import '../domain/models/player_rivalry.dart';

class RivalryFixtures {
  static PlayerRivalry rivalry({
    String? rivalId,
    int wins = 7,
    int losses = 5,
  }) => PlayerRivalry(
    rivalryId: 'rivalry_123',
    userId: 'current_user',
    rivalId: rivalId ?? 'rival_alex',
    matchesPlayed: wins + losses,
    wins: wins,
    losses: losses,
    draws: 0,
    lastMatchAt: DateTime.now().subtract(const Duration(hours: 2)),
    lastOutcome: CompetitiveOutcome.win,
    recentForm: [
      CompetitiveOutcome.win,
      CompetitiveOutcome.win,
      CompetitiveOutcome.loss,
      CompetitiveOutcome.win,
      CompetitiveOutcome.loss,
    ],
  );
}
