import '../domain/models/competitive_challenge.dart';

class ChallengeFixtures {
  static CompetitiveChallenge activeChallenge() => CompetitiveChallenge(
    challengeId: 'c1',
    challengerId: 'me',
    challengedPlayerId: 'rival1',
    type: ChallengeType.matchWins,
    target: 3,
    status: ChallengeStatus.active,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    expiresAt: DateTime.now().add(const Duration(days: 2)),
    challengerProgress: 2,
    opponentProgress: 1,
  );

  static CompetitiveChallenge pendingChallenge() => CompetitiveChallenge(
    challengeId: 'c2',
    challengerId: 'rival2',
    challengedPlayerId: 'me',
    type: ChallengeType.winStreak,
    target: 5,
    status: ChallengeStatus.pending,
    createdAt: DateTime.now(),
    expiresAt: DateTime.now().add(const Duration(hours: 24)),
  );
}
