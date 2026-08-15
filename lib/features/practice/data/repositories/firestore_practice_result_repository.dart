import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/practice_result.dart';
import '../../domain/repositories/practice_result_repository.dart';

class FirestorePracticeResultRepository implements PracticeResultRepository {
  final FirebaseFirestore _firestore;

  FirestorePracticeResultRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> _resultsCollection(String userId) =>
      _firestore
          .collection('users')
          .doc(userId)
          .collection('practice_results');

  @override
  Future<void> recordResult(PracticeResult result) async {
    await _resultsCollection(result.userId)
        .doc(result.sessionId) // Using sessionId as resultId for idempotency
        .set(result.toJson());
  }

  @override
  Future<List<PracticeResult>> getRecentResults(
    String userId, {
    int limit = 10,
  }) async {
    final snapshot = await _resultsCollection(userId)
        .orderBy('completedAt', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => PracticeResult.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<PracticeResult>> getResults(
    String userId, {
    int limit = 20,
    PracticeResult? lastResult,
    String? categoryId,
  }) async {
    var query = _resultsCollection(userId)
        .orderBy('completedAt', descending: true)
        .limit(limit);

    if (categoryId != null) {
      query = query.where('categoryPerformance.$categoryId', isNull: false);
    }

    if (lastResult != null) {
      query = query.startAfter([lastResult.completedAt]);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => PracticeResult.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> deleteResult(String userId, String resultId) async {
    await _resultsCollection(userId).doc(resultId).delete();
  }
}
