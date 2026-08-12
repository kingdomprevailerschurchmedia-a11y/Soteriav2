import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/milestone.dart';
import '../../domain/repositories/milestone_repository.dart';

class FirebaseMilestoneRepository implements MilestoneRepository {
  final FirebaseFirestore _firestore;

  FirebaseMilestoneRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> _milestoneCollection(
    String userId,
  ) => _firestore.collection('users').doc(userId).collection('milestones');

  @override
  Future<List<MilestoneDefinition>> getMilestoneDefinitions() async {
    // For now, we return a static list to ensure deterministic behavior.
    // In a future phase, this could be moved to its own Firestore collection.
    return [
      const MilestoneDefinition(
        id: 'first_game',
        name: 'First Step',
        description: 'Complete your first competitive game.',
        type: MilestoneType.count,
        category: MilestoneCategory.participation,
        threshold: 1,
        icon: 'stars_rounded',
      ),
      const MilestoneDefinition(
        id: 'first_win',
        name: 'First Blood',
        description: 'Win your first competitive game.',
        type: MilestoneType.win,
        category: MilestoneCategory.victory,
        threshold: 1,
        icon: 'emoji_events_rounded',
      ),
      const MilestoneDefinition(
        id: 'wins_10',
        name: 'Decathlon',
        description: 'Win 10 competitive games.',
        type: MilestoneType.win,
        category: MilestoneCategory.victory,
        threshold: 10,
        icon: 'military_tech_rounded',
      ),
      const MilestoneDefinition(
        id: 'wins_50',
        name: 'Half Century',
        description: 'Win 50 competitive games.',
        type: MilestoneType.win,
        category: MilestoneCategory.victory,
        threshold: 50,
        icon: 'workspace_premium_rounded',
      ),
      const MilestoneDefinition(
        id: 'rank_diamond',
        name: 'Diamond Soul',
        description: 'Reach Diamond tier.',
        type: MilestoneType.rank,
        category: MilestoneCategory.ranking,
        threshold: 1, // Logic handled in evaluator
        icon: 'diamond_rounded',
      ),
      const MilestoneDefinition(
        id: 'top_100',
        name: 'Global Elite',
        description: 'Finish a season in the top 100.',
        type: MilestoneType.position,
        category: MilestoneCategory.ranking,
        threshold: 100,
        icon: 'public_rounded',
      ),
    ];
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
