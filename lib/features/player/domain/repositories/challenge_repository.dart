import '../models/competitive_challenge.dart';

abstract interface class ChallengeRepository {
  /// Sends a new challenge to another player.
  Future<void> sendChallenge(CompetitiveChallenge challenge);

  /// Accepts a pending challenge.
  Future<void> acceptChallenge(String challengeId);

  /// Declines a pending challenge.
  Future<void> declineChallenge(String challengeId);

  /// Cancels an outgoing challenge.
  Future<void> cancelChallenge(String challengeId);

  /// Streams incoming challenges for a player.
  Stream<List<CompetitiveChallenge>> watchIncomingChallenges(String userId);

  /// Streams outgoing challenges for a player.
  Stream<List<CompetitiveChallenge>> watchOutgoingChallenges(String userId);

  /// Fetches a specific challenge by ID.
  Future<CompetitiveChallenge?> getChallenge(String challengeId);
}
