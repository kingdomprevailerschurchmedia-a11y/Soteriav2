import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/season_reward_definition.dart';
import '../../domain/models/reward_grant.dart';
import '../../domain/repositories/reward_repository.dart';

class FirebaseRewardRepository implements RewardRepository {
  final FirebaseFirestore _firestore;

  FirebaseRewardRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _definitionsCollection =>
      _firestore.collection('season_reward_definitions');

  CollectionReference<Map<String, dynamic>> get _grantsCollection =>
      _firestore.collection('season_reward_grants');

  @override
  Future<List<SeasonRewardDefinition>> getRewardDefinitions(
    String seasonId,
  ) async {
    final snapshot = await _definitionsCollection
        .where('seasonId', isEqualTo: seasonId)
        .where('isActive', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((doc) => SeasonRewardDefinition.fromJson(doc.data()))
        .toList();
  }

  @override
  Stream<List<RewardGrant>> watchPlayerRewards(String userId) {
    return _grantsCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RewardGrant.fromJson(doc.data()))
              .toList(),
        );
  }

  @override
  Future<List<RewardGrant>> getPlayerRewards(String userId) async {
    final snapshot = await _grantsCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => RewardGrant.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<RewardGrant>> getSeasonRewards(
    String userId,
    String seasonId,
  ) async {
    final snapshot = await _grantsCollection
        .where('userId', isEqualTo: userId)
        .where('seasonId', isEqualTo: seasonId)
        .get();

    return snapshot.docs
        .map((doc) => RewardGrant.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<List<RewardGrant>> getPendingRewards(String userId) async {
    final snapshot = await _grantsCollection
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: GrantStatus.pending.name)
        .get();

    return snapshot.docs
        .map((doc) => RewardGrant.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> claimReward(String grantId) async {
    // This would typically be a Cloud Function call in a real prod app
    // but for the sake of this story, we'll simulate the client-initiated claim
    // which the server-side security rules must protect.

    await _firestore.runTransaction((tx) async {
      final grantDoc = _grantsCollection.doc(grantId);
      final snapshot = await tx.get(grantDoc);

      if (!snapshot.exists) throw Exception('Reward grant not found');

      final grant = RewardGrant.fromJson(snapshot.data()!);

      if (grant.status != GrantStatus.granted &&
          grant.status != GrantStatus.eligible) {
        throw Exception('Reward is not in a claimable state');
      }

      if (grant.status == GrantStatus.claimed) {
        throw Exception('Reward already claimed');
      }

      // Update grant status
      tx.update(grantDoc, {
        'status': GrantStatus.claimed.name,
        'claimedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Integration with Economy/Progression happens here (AUTHORITATIVE)
      // In a real server environment, a trigger would handle this.
      // For this implementation, we assume the server rules or a function handles the balance update.
    });
  }
}
