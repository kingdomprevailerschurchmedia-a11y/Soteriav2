import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/player/domain/models/milestone.dart';
import 'package:soteria/features/player/domain/models/season_reward_definition.dart';
import 'package:soteria/features/player/domain/config/milestone_registry.dart';
import 'package:soteria/features/player/domain/repositories/milestone_repository.dart';

class FirebaseMilestoneRepository implements MilestoneRepository {
  final FirebaseFirestore _firestore;

  FirebaseMilestoneRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> _milestoneCollection(
    String userId,
  ) => _firestore.collection('users').doc(userId).collection('milestones');

  @override
  Future<List<MilestoneDefinition>> getMilestoneDefinitions() async {
    return MilestoneRegistry.definitions;
  }

  @override
  Stream<List<PlayerMilestone>> watchPlayerMilestones(String userId) {
    return _milestoneCollection(userId).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => PlayerMilestone.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<void> updateMilestoneState(PlayerMilestone milestone) async {
    await _milestoneCollection(
      milestone.userId,
    ).doc(milestone.milestoneId).set(milestone.toJson());
  }

  @override
  Future<void> claimMilestone(String userId, String milestoneId) async {
    final definition = MilestoneRegistry.getById(milestoneId);
    if (definition == null) throw Exception('Milestone definition not found');

    final milestoneDoc = _milestoneCollection(userId).doc(milestoneId);
    final userDoc = _firestore.collection('users').doc(userId);

    await _firestore.runTransaction((tx) async {
      final milestoneSnap = await tx.get(milestoneDoc);
      if (!milestoneSnap.exists) throw Exception('Milestone not found');

      final milestone = PlayerMilestone.fromJson(milestoneSnap.data()!);
      if (milestone.status == MilestoneStatus.claimed) return; // Already claimed

      if (milestone.status != MilestoneStatus.completed) {
        throw Exception('Milestone is not completed');
      }

      final now = DateTime.now();

      // 1. Update Milestone status
      tx.update(milestoneDoc, {
        'status': MilestoneStatus.claimed.name,
        'claimedAt': now.toIso8601String(),
      });

      // 2. Increment user rewards if applicable
      if (definition.rewardType == RewardType.coins &&
          definition.rewardAmount != null) {
        tx.update(userDoc, {
          'coins': FieldValue.increment(definition.rewardAmount!),
          'updatedAt': now.toIso8601String(),
        });
      }

      // Note: XP rewards for milestones are usually handled during unlock/evaluation
      // but we can add specific claim-time logic here if needed.
    });
  }

  @override
  Future<PlayerMilestone?> getPlayerMilestone(
    String userId,
    String milestoneId,
  ) async {
    final doc = await _milestoneCollection(userId).doc(milestoneId).get();
    if (!doc.exists) return null;
    return PlayerMilestone.fromJson(doc.data()!);
  }
}
