import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/season_result.dart';
import '../../domain/repositories/competitive_history_repository.dart';

class FirebaseCompetitiveHistoryRepository
    implements CompetitiveHistoryRepository {
  final FirebaseFirestore _firestore;

  FirebaseCompetitiveHistoryRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> _resultsCollection(String userId) =>
      _firestore.collection('users').doc(userId).collection('season_results');

  @override
  Future<List<SeasonResult>> getSeasonResults(
    String userId, {
    int limit = 20,
    dynamic startAfter,
  }) async {
    var query = _resultsCollection(
      userId,
    ).orderBy('seasonNumber', descending: true).limit(limit);

    if (startAfter != null) {
      query = query.startAfter([startAfter]);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => SeasonResult.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<SeasonResult?> getSeasonResult(String userId, String seasonId) async {
    final doc = await _resultsCollection(userId).doc(seasonId).get();
    if (!doc.exists) return null;
    return SeasonResult.fromJson(doc.data()!);
  }

  @override
  Future<SeasonResult?> getLatestSeasonResult(String userId) async {
    final snapshot = await _resultsCollection(
      userId,
    ).orderBy('seasonNumber', descending: true).limit(1).get();
    if (snapshot.docs.isEmpty) return null;
    return SeasonResult.fromJson(snapshot.docs.first.data());
  }

  @override
  Future<SeasonResult?> getBestSeasonResult(String userId) async {
    // Best is defined by highest rank points in a finalized season
    final snapshot = await _resultsCollection(
      userId,
    ).orderBy('finalRankPoints', descending: true).limit(1).get();
    if (snapshot.docs.isEmpty) return null;
    return SeasonResult.fromJson(snapshot.docs.first.data());
  }

  @override
  Stream<List<SeasonResult>> watchSeasonHistory(
    String userId, {
    int limit = 50,
  }) {
    return _resultsCollection(userId)
        .orderBy('seasonNumber', descending: true)
        .limit(limit)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => SeasonResult.fromJson(doc.data()))
              .toList(),
        );
  }
}
