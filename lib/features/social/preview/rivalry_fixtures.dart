import 'package:soteria/features/social/domain/models/player_rivalry.dart';
import 'package:soteria/features/social/domain/models/head_to_head_summary.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';

class RivalryFixtures {
  static PlayerRivalry rivalry() => PlayerRivalry(
    rivalryId: 'r1',
    userId: 'me',
    rivalId: 'rival_alex',
    matchesPlayed: 12,
    wins: 7,
    losses: 5,
    draws: 0,
    lastMatchAt: DateTime.now().subtract(const Duration(hours: 3)),
    lastOutcome: CompetitiveOutcome.win,
    recentForm: [CompetitiveOutcome.win, CompetitiveOutcome.win, CompetitiveOutcome.loss, CompetitiveOutcome.win, CompetitiveOutcome.loss],
  );

  static HeadToHeadSummary headToHeadSummary() => HeadToHeadSummary(
    playerAId: 'me',
    playerBId: 'rival_alex',
    totalMatches: 12,
    playerAWins: 7,
    playerBWins: 5,
    draws: 0,
    playerAWinRate: 7 / 12,
    playerBWinRate: 5 / 12,
    recentResults: [CompetitiveOutcome.win, CompetitiveOutcome.win, CompetitiveOutcome.loss],
    playerACurrentStreak: 2,
    playerBCurrentStreak: 0,
    playerABestStreak: 3,
    playerBBestStreak: 2,
    lastMatchAt: DateTime.now().subtract(const Duration(hours: 3)),
  );
}
