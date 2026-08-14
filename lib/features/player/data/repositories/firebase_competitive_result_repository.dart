import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_result.dart';
import '../../domain/repositories/competitive_result_repository.dart';

class FirebaseCompetitiveResultRepository
    implements CompetitiveResultRepository {
  final FirebaseFirestore _firestore;

  FirebaseCompetitiveResultRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> _resultsCollection(String userId) =>
      _firestore
          .collection('users')
          .doc(userId)
          .collection('competitive_results');

  @override
  Future<void> recordResult(CompetitiveResult result) async {
    await _resultsCollection(
      result.userId,
    ).doc(result.resultId).set(result.toJson());
  }

  @override
  Future<List<CompetitiveResult>> getRecentResults(
    String userId, {
    int limit = 10,
  }) async {
    final snapshot = await _resultsCollection(
      userId,
    ).orderBy('completedAt', descending: true).limit(limit).get();

    return snapshot.docs
        .map((doc) => CompetitiveResult.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<CompetitiveResult>> getResults(
    String userId, {
    int limit = 20,
    CompetitiveResult? lastResult,
    String? seasonId,
    String? mode,
    CompetitiveOutcome? outcome,
    String? opponentId,
  }) async {
    var query = _resultsCollection(
      userId,
    ).orderBy('completedAt', descending: true).limit(limit);

    if (seasonId != null) {
      query = query.where('seasonId', isEqualTo: seasonId);
    }
    if (mode != null) {
      query = query.where('mode', isEqualTo: mode);
    }
    if (outcome != null) {
      query = query.where('outcome', isEqualTo: outcome.name);
    }
    if (opponentId != null) {
      query = query.where('opponentId', isEqualTo: opponentId);
    }
    if (lastResult != null) {
      query = query.startAfter([lastResult.completedAt]);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => CompetitiveResult.fromJson(doc.data()))
        .toList();
  }

  @override
  Stream<List<CompetitiveResult>> watchRecentResults(
    String userId, {
    int limit = 10,
  }) {
    return _resultsCollection(userId)
        .orderBy('completedAt', descending: true)
        .limit(limit)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CompetitiveResult.fromJson(doc.data()))
              .toList(),
        );
  }
}
