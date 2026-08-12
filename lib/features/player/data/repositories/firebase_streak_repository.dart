import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/competitive_streak.dart';
import '../../domain/models/momentum.dart';
import '../../domain/repositories/streak_repository.dart';

class FirebaseStreakRepository implements StreakRepository {
  final FirebaseFirestore _firestore;

  FirebaseStreakRepository(this._firestore);

  DocumentReference<Map<String, dynamic>> _streakDoc(String userId) =>
      _firestore
          .collection('users')
          .doc(userId)
          .collection('competitive_stats')
          .doc('win_streak');

  DocumentReference<Map<String, dynamic>> _momentumDoc(String userId) =>
      _firestore
          .collection('users')
          .doc(userId)
          .collection('competitive_stats')
          .doc('momentum');

  @override
  Stream<CompetitiveStreak?> watchWinStreak(String userId) {
    return _streakDoc(userId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return CompetitiveStreak.fromJson(doc.data()!);
    });
  }

  @override
  Stream<CompetitiveMomentum?> watchMomentum(String userId) {
    return _momentumDoc(userId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return CompetitiveMomentum.fromJson(doc.data()!);
    });
  }

  @override
  Future<CompetitiveStreak?> getWinStreak(String userId) async {
    final doc = await _streakDoc(userId).get();
    if (!doc.exists) return null;
    return CompetitiveStreak.fromJson(doc.data()!);
  }

  @override
  Future<void> updateWinStreak(CompetitiveStreak streak) async {
    await _streakDoc(streak.userId).set(streak.toJson());
  }

  @override
  Future<void> updateMomentum(CompetitiveMomentum momentum) async {
    await _momentumDoc(momentum.userId).set(momentum.toJson());
  }
}
