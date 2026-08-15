import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/milestone.dart';
import '../../domain/config/milestone_registry.dart';
import '../../domain/repositories/milestone_repository.dart';

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
  Future<PlayerMilestone?> getPlayerMilestone(
    String userId,
    String milestoneId,
  ) async {
    final doc = await _milestoneCollection(userId).doc(milestoneId).get();
    if (!doc.exists) return null;
    return PlayerMilestone.fromJson(doc.data()!);
  }
}
