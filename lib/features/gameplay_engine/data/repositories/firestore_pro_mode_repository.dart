import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/firebase/services/firebase_interfaces.dart';
import '../../domain/repositories/pro_mode_repository.dart';
import '../../models/competitive_session.dart';

class FirestoreProModeRepository implements ProModeRepository {
  final IDatabaseService _database;

  FirestoreProModeRepository(this._database);

  @override
  Future<bool> validateEntry(String uid, int fee) async {
    final snapshot = await _database.collection('players').doc(uid).get();
    if (!snapshot.exists) return false;

    final data = snapshot.data();
    if (data == null) return false;

    final int currentCoins = data['coins'] ?? 0;
    return currentCoins >= fee;
  }

  @override
  Future<void> reserveEntryFee(String uid, String sessionId, int fee) async {
    // Hardening: Check for existing active sessions to prevent parallel play
    final activeSessions = await _database
        .collection('competitive_sessions')
        .where('uid', isEqualTo: uid)
        .where('status', isEqualTo: 'initialized')
        .get();

    if (activeSessions.docs.isNotEmpty) {
      throw Exception('An active competitive session already exists.');
    }

    // 1. Deduct coins from player
    await _database.collection('players').doc(uid).update({
      'coins': FieldValue.increment(-fee),
      'proSessions': FieldValue.increment(1),
    });

    // 2. Create a reservation record
    await _database.collection('pro_reservations').doc(sessionId).set({
      'uid': uid,
      'fee': fee,
      'timestamp': DateTime.now().toIso8601String(),
      'status': 'reserved',
    });
  }

  @override
  Future<void> createCompetitiveSession(CompetitiveSession session) async {
    await _database
        .collection('competitive_sessions')
        .doc(session.sessionId)
        .set(session.toJson());
  }
}
