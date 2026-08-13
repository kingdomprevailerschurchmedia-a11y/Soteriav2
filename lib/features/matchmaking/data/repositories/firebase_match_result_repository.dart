import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_match_result.dart';
import '../../domain/repositories/match_result_repository.dart';

class FirebaseMatchResultRepository implements MatchResultRepository {
  final FirebaseFirestore _firestore;

  FirebaseMatchResultRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _results =>
      _firestore.collection('match_results');

  @override
  Future<CompetitiveMatchResult?> getMatchResult(String matchId, String userId) async {
    final doc = await _results.doc('${matchId}_$userId').get();
    if (!doc.exists) return null;
    return CompetitiveMatchResult.fromJson(doc.data()!);
  }

  @override
  Future<void> requestRematch(String matchId, String userId) async {
    // This would likely create a new Challenge or MatchmakingSession
    // with a flag indicating it's a rematch.
    await _firestore.collection('challenges').add({
      'matchId': matchId,
      'challengerId': userId,
      'status': 'pending',
      'isRematch': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Stream<CompetitiveMatchResult?> observeMatchResult(String matchId, String userId) {
    return _results.doc('${matchId}_$userId').snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return null;
      return CompetitiveMatchResult.fromJson(snapshot.data()!);
    });
  }
}
