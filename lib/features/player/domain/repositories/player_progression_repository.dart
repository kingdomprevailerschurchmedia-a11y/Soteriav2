import '../models/player_progression.dart';
import '../models/xp_transaction.dart';
import '../models/competitive_result.dart';
import '../models/rank_change.dart';

abstract class PlayerProgressionRepository {
  Stream<PlayerProgression> watchProgression(String userId);
  Future<PlayerProgression?> getProgression(String userId);
  Future<void> updateProgression(PlayerProgression progression);
  Future<void> applyXpTransaction(XpTransaction transaction);
  Future<RankChange> applyCompetitiveResult(CompetitiveResult result);
  
  /// Applies a competitive result within an existing transaction.
  /// Used to ensure atomicity across wallet and progression updates.
  Future<RankChange> applyCompetitiveResultInTransaction(
    dynamic transaction, // Using dynamic to avoid hard dependency on Cloud Firestore in domain
    CompetitiveResult result,
  );
  Future<List<XpTransaction>> getXpTransactions(
    String userId, {
    int limit = 20,
  });
}
