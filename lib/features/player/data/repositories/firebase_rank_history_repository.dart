import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/rank_change.dart';
import '../../domain/repositories/rank_history_repository.dart';

class FirebaseRankHistoryRepository implements RankHistoryRepository {
  final FirebaseFirestore _firestore;

  FirebaseRankHistoryRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _historyCollection =>
      _firestore.collection('rank_history');

  @override
  Future<void> addRankChange(RankChange change) async {
    await _historyCollection.doc(change.changeId).set(change.toJson());
  }

  @override
  Future<void> acknowledgeRankChange(String changeId) async {
    await _historyCollection.doc(changeId).update({'acknowledged': true});
  }

  @override
  Stream<List<RankChange>> watchRankHistory(String userId, {int limit = 50}) {
    return _historyCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RankChange.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Future<List<RankChange>> getRankHistory(
    String userId, {
    int limit = 50,
  }) async {
    final snapshot = await _historyCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return snapshot.docs.map((doc) => RankChange.fromJson(doc.data())).toList();
  }

  @override
  Future<List<RankChange>> getRecentPromotions(
    String userId, {
    int limit = 5,
  }) async {
    final snapshot = await _historyCollection
        .where('userId', isEqualTo: userId)
        .where('type', whereIn: [
          RankChangeType.promotion.name,
          RankChangeType.divisionPromotion.name,
        ])
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    return snapshot.docs.map((doc) => RankChange.fromJson(doc.data())).toList();
  }

  @override
  Future<List<RankChange>> getUnacknowledgedChanges(String userId) async {
    final snapshot = await _historyCollection
        .where('userId', isEqualTo: userId)
        .where('acknowledged', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => RankChange.fromJson(doc.data())).toList();
  }

  @override
  Stream<List<RankChange>> watchUnacknowledgedChanges(String userId) {
    return _historyCollection
        .where('userId', isEqualTo: userId)
        .where('acknowledged', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RankChange.fromJson(doc.data()))
              .toList(),
        );
  }
}
