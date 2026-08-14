import '../models/competitive_challenge.dart';

abstract class ChallengeRepository {
  Future<void> sendChallenge(CompetitiveChallenge challenge);
  
  Future<void> acceptChallenge(String challengeId);
  
  Future<void> declineChallenge(String challengeId);
  
  Future<void> cancelChallenge(String challengeId);
  
  Stream<List<CompetitiveChallenge>> watchIncomingChallenges(String userId);
  
  Stream<List<CompetitiveChallenge>> watchOutgoingChallenges(String userId);
  
  Stream<List<CompetitiveChallenge>> watchActiveChallenges(String userId);
  
  Future<List<CompetitiveChallenge>> getChallengeHistory(String userId);
  
  Future<CompetitiveChallenge?> getChallenge(String challengeId);
}
