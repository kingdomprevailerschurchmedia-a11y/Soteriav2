import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/leaderboard_entry.dart';
import '../../domain/models/rank_movement_event.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../../domain/config/leaderboard_config.dart';

import '../../domain/models/player_profile.dart';
import '../../domain/models/player_progression.dart';

class FirebaseLeaderboardRepository implements LeaderboardRepository {
  final FirebaseFirestore _firestore;

  FirebaseLeaderboardRepository(this._firestore);

  @override
  Future<void> syncLeaderboardEntry({
    required PlayerProfile profile,
    required PlayerProgression progression,
    String? seasonId,
    dynamic transaction,
  }) async {
    final entry = LeaderboardEntry(
      userId: profile.uid,
      displayName: profile.displayName,
      avatarUrl: profile.photoUrl,
      avatarId: profile.selectedAvatarId,
      rankPoints:
          seasonId == null ? progression.lifetimeXp : progression.rankPoints,
      xp: progression.lifetimeXp,
      rankTier: progression.currentRankTier,
      division: _parseDivision(progression.currentRank),
      position: 0, // Calculated client-side
      registrationOrder: profile.registrationOrder,
      titleId: profile.equippedTitleId,
      lastUpdated: DateTime.now(),
      createdAt: profile.createdAt,
    );

    final data = entry.toJson();
    if (seasonId != null) {
      data['seasonId'] = seasonId;
    }

    final collection = seasonId == null
        ? LeaderboardConfig.globalLeaderboardCollection
        : LeaderboardConfig.seasonLeaderboardCollection;
    final docId = seasonId == null ? profile.uid : '${seasonId}_${profile.uid}';

    final docRef = _firestore.collection(collection).doc(docId);

    if (transaction != null && transaction is Transaction) {
      transaction.set(docRef, data, SetOptions(merge: true));
    } else {
      await docRef.set(data, SetOptions(merge: true));
    }
  }

  int _parseDivision(String rankString) {
    if (rankString == 'Unranked' || rankString == 'Elite') return 0;
    final parts = rankString.split(' ');
    if (parts.length < 2) return 0;
    switch (parts[1]) {
      case 'I':
        return 1;
      case 'II':
        return 2;
      case 'III':
        return 3;
      default:
        return 0;
    }
  }

  Query<Map<String, dynamic>> _getBaseQuery(String? seasonId) {
    if (seasonId == null) {
      return _firestore.collection(
        LeaderboardConfig.globalLeaderboardCollection,
      );
    } else {
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
        .orderBy('registrationOrder', descending: false)
        .limit(limit);

    if (lastCursor != null) {
      if (lastCursor is LeaderboardEntry) {
        query = query.startAfter([lastCursor.rankPoints, lastCursor.registrationOrder]);
      } else if (lastCursor is DocumentSnapshot) {
        query = query.startAfterDocument(lastCursor);
      }
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

    final betterXpQuery = _getBaseQuery(
      seasonId,
    ).where('rankPoints', isGreaterThan: entry.rankPoints);

    final betterXpSnapshot = await betterXpQuery.count().get();

    final tieXpQuery = _getBaseQuery(seasonId)
        .where('rankPoints', isEqualTo: entry.rankPoints)
        .where('registrationOrder', isLessThan: entry.registrationOrder);

    final tieXpSnapshot = await tieXpQuery.count().get();

    return (betterXpSnapshot.count ?? 0) + (tieXpSnapshot.count ?? 0) + 1;
  }

  @override
  Future<List<LeaderboardEntry>> getLeaderboardAroundPlayer({
    required String userId,
    String? seasonId,
    int windowSize = 5,
  }) async {
    final entry = await getPlayerEntry(userId: userId, seasonId: seasonId);
    if (entry == null) return [];

    final aboveQuery = _getBaseQuery(seasonId)
        .orderBy('rankPoints', descending: false)
        .orderBy('registrationOrder', descending: true)
        .startAfter([entry.rankPoints, entry.registrationOrder])
        .limit(windowSize);

    final belowQuery = _getBaseQuery(seasonId)
        .orderBy('rankPoints', descending: true)
        .orderBy('registrationOrder', descending: false)
        .startAfter([entry.rankPoints, entry.registrationOrder])
        .limit(windowSize);

    final results = await Future.wait([aboveQuery.get(), belowQuery.get()]);

    final aboveEntries = results[0].docs
        .map((doc) => LeaderboardEntry.fromJson(doc.data()))
        .toList()
        .reversed
        .toList();

    final belowEntries = results[1].docs
        .map((doc) => LeaderboardEntry.fromJson(doc.data()))
        .toList();

    return [...aboveEntries, entry, ...belowEntries];
  }

  @override
  Future<int> getTotalPlayers({String? seasonId}) async {
    final snapshot = await _getBaseQuery(seasonId).count().get();
    return snapshot.count ?? 0;
  }

  @override
  Future<List<RankMovementEvent>> getPositionHistory({
    required String userId,
    String? seasonId,
    int limit = 50,
  }) async {
    var query = _firestore
        .collection('rank_movement_history')
        .where('userId', isEqualTo: userId);

    if (seasonId != null) {
      query = query.where('seasonId', isEqualTo: seasonId);
    }

    final snapshot = await query
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => RankMovementEvent.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> recordMovement(RankMovementEvent event) async {
    await _firestore
        .collection('rank_movement_history')
        .doc(event.id)
        .set(event.toJson());
  }

  @override
  Future<List<LeaderboardEntry>> getEntriesByUserIds(List<String> userIds, {String? seasonId}) async {
    if (userIds.isEmpty) return [];

    final docIdSuffix = seasonId == null ? '' : '_$seasonId';
    final collection = seasonId == null
        ? LeaderboardConfig.globalLeaderboardCollection
        : LeaderboardConfig.seasonLeaderboardCollection;

    // Firestore whereIn limit is 30.
    final chunks = <List<String>>[];
    for (var i = 0; i < userIds.length; i += 30) {
      chunks.add(userIds.sublist(i, i + 30 > userIds.length ? userIds.length : i + 30));
    }

    final results = await Future.wait(chunks.map((chunk) {
      return _firestore.collection(collection)
          .where('userId', whereIn: chunk)
          .get();
    }));

    return results.expand((snapshot) => snapshot.docs)
        .map((doc) => LeaderboardEntry.fromJson(doc.data()))
        .toList();
  }
}
