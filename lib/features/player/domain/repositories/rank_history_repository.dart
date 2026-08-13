import '../models/rank_change.dart';

abstract class RankHistoryRepository {
  Future<void> addRankChange(RankChange change);
  Future<void> acknowledgeRankChange(String changeId);
  Stream<List<RankChange>> watchRankHistory(String userId, {int limit = 50});
  Future<List<RankChange>> getRankHistory(String userId, {int limit = 50});
  Future<List<RankChange>> getRecentPromotions(String userId, {int limit = 5});
  Future<List<RankChange>> getUnacknowledgedChanges(String userId);
  Stream<List<RankChange>> watchUnacknowledgedChanges(String userId);
}
