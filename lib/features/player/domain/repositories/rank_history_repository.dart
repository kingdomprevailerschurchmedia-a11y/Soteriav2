import '../models/rank_change.dart';

abstract class RankHistoryRepository {
  Future<void> addRankChange(RankChange change);
  Stream<List<RankChange>> watchRankHistory(String userId, {int limit = 50});
  Future<List<RankChange>> getRankHistory(String userId, {int limit = 50});
  Future<List<RankChange>> getRecentPromotions(String userId, {int limit = 5});
}
