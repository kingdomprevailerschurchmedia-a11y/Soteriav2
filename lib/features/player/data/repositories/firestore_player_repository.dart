import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import '../../domain/models/player_profile.dart';
import '../../domain/repositories/player_repository.dart';
import '../models/player_profile_dto.dart';

class FirestorePlayerRepository implements PlayerRepository {
  FirestorePlayerRepository({required IDatabaseService database})
    : _database = database;

  final IDatabaseService _database;

  @override
  Future<PlayerProfile?> getPlayerProfile(String uid) async {
    final doc = await _database.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return PlayerProfileDto.fromFirestore(doc);
  }

  @override
  Stream<PlayerProfile?> observePlayerProfile(String uid) {
    return _database.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return PlayerProfileDto.fromFirestore(doc);
    });
  }

  @override
  Future<void> createPlayerProfile(PlayerProfile profile) async {
    await _database
        .collection('users')
        .doc(profile.uid)
        .set(PlayerProfileDto.toFirestore(profile), SetOptions(merge: false));
  }

  @override
  Future<void> updatePlayerProfile(PlayerProfile profile) async {
    await _database
        .collection('users')
        .doc(profile.uid)
        .update(
          PlayerProfileDto.toFirestore(profile)
            ..remove('createdAt'), // Never update createdAt
        );
  }
}
