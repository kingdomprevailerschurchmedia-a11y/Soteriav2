import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/leaderboard_entry.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../../domain/config/leaderboard_config.dart';

class FirebaseLeaderboardRepository implements LeaderboardRepository {
  final FirebaseFirestore _firestore;

  FirebaseLeaderboardRepository(this._firestore);

  Query<Map<String, dynamic>> _getBaseQuery(String? seasonId) {
    if (seasonId == null) {
      return _firestore.collection(
        LeaderboardConfig.globalLeaderboardCollection,
      );
    } else {
      // Assuming a flattened collection for simpler querying at scale
      // Index: seasonId (ASC), rankPoints (DESC), userId (ASC)
      return _firestore
          .collection(LeaderboardConfig.seasonLeaderboardCollection)
          .where('seasonId', isEqualTo: seasonId);
    }
  }

  @override
  Future<List<LeaderboardEntry>> getLeaderboardPage({
    String? seasonId,
    int limit = 50,
    dynamic lastCursor,
  }) async {
    var query = _getBaseQuery(seasonId)
        .orderBy('rankPoints', descending: true)
        .orderBy('userId', descending: false) // Tie-breaker
        .limit(limit);

    if (lastCursor != null) {
      query = query.startAfterDocument(lastCursor as DocumentSnapshot);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => LeaderboardEntry.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<LeaderboardEntry?> getPlayerEntry({
    required String userId,
    String? seasonId,
  }) async {
    final docId = seasonId == null ? userId : '${seasonId}_$userId';
    final collection = seasonId == null
        ? LeaderboardConfig.globalLeaderboardCollection
        : LeaderboardConfig.seasonLeaderboardCollection;

    final doc = await _firestore.collection(collection).doc(docId).get();
    if (!doc.exists) return null;
    return LeaderboardEntry.fromJson(doc.data()!);
  }

  @override
  Future<int> getPlayerRankPosition({
    required String userId,
    String? seasonId,
  }) async {
    final entry = await getPlayerEntry(userId: userId, seasonId: seasonId);
    if (entry == null) return -1;

    // Efficiently count entries with higher rank points
    // Index needed: seasonId (ASC), rankPoints (DESC), userId (ASC)
    final countQuery = _getBaseQuery(
      seasonId,
    ).where('rankPoints', isGreaterThan: entry.rankPoints);

    final countSnapshot = await countQuery.count().get();

    // Also handle ties: count users with same points but "lower" tie-breaker (userId)
    final tieQuery = _getBaseQuery(seasonId)
        .where('rankPoints', isEqualTo: entry.rankPoints)
        .where('userId', isLessThan: userId);

    final tieSnapshot = await tieQuery.count().get();

    return countSnapshot.count! + tieSnapshot.count! + 1;
  }

  @override
  Future<List<LeaderboardEntry>> getLeaderboardAroundPlayer({
    required String userId,
    String? seasonId,
    int windowSize = 5,
  }) async {
    final entry = await getPlayerEntry(userId: userId, seasonId: seasonId);
    if (entry == null) return [];

    // Fetch entries with higher points (Above)
    final aboveQuery = _getBaseQuery(seasonId)
        .orderBy('rankPoints', descending: false)
        .orderBy('userId', descending: true)
        .startAfter([entry.rankPoints, entry.userId])
        .limit(windowSize);

    // Fetch entries with lower points (Below)
    final belowQuery = _getBaseQuery(seasonId)
        .orderBy('rankPoints', descending: true)
        .orderBy('userId', descending: false)
        .startAfter([entry.rankPoints, entry.userId])
        .limit(windowSize);

    final results = await Future.wait([aboveQuery.get(), belowQuery.get()]);

    final aboveEntries = results[0].docs
        .map((doc) => LeaderboardEntry.fromJson(doc.data()))
        .toList()
        .reversed // Correct order
        .toList();

    final belowEntries = results[1].docs
        .map((doc) => LeaderboardEntry.fromJson(doc.data()))
        .toList();

    return [...aboveEntries, entry, ...belowEntries];
  }
}
