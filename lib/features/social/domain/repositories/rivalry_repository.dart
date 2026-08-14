import '../models/player_rivalry.dart';
import '../models/head_to_head_summary.dart';

abstract class RivalryRepository {
  Future<PlayerRivalry> getRivalry(String userId, String rivalId);
  
  Future<List<PlayerRivalry>> getTopRivalries(String userId, {int limit = 5});
  
  Future<HeadToHeadSummary> getHeadToHeadSummary(String playerAId, String playerBId);
}
