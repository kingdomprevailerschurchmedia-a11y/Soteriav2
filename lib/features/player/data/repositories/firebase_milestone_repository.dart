import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/milestone.dart';
import '../../domain/models/season_reward_definition.dart';
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
        rewardType: RewardType.coins,
        rewardAmount: 50,
        displayOrder: 1,
      ),
      const MilestoneDefinition(
        id: 'first_win',
        name: 'First Blood',
        description: 'Win your first competitive game.',
        type: MilestoneType.win,
        category: MilestoneCategory.victory,
        threshold: 1,
        icon: 'emoji_events_rounded',
        rewardType: RewardType.coins,
        rewardAmount: 100,
        displayOrder: 2,
      ),
      const MilestoneDefinition(
        id: 'wins_10',
        name: 'Decathlon',
        description: 'Win 10 competitive games.',
        type: MilestoneType.win,
        category: MilestoneCategory.victory,
        threshold: 10,
        icon: 'military_tech_rounded',
        rewardType: RewardType.coins,
        rewardAmount: 500,
        displayOrder: 3,
      ),
      const MilestoneDefinition(
        id: 'wins_50',
        name: 'Half Century',
        description: 'Win 50 competitive games.',
        type: MilestoneType.win,
        category: MilestoneCategory.victory,
        threshold: 50,
        icon: 'workspace_premium_rounded',
        rewardType: RewardType.coins,
        rewardAmount: 2500,
        displayOrder: 4,
      ),
      const MilestoneDefinition(
        id: 'rank_gold',
        name: 'Golden Standard',
        description: 'Reach Gold tier.',
        type: MilestoneType.rank,
        category: MilestoneCategory.ranking,
        threshold: 1,
        icon: 'military_tech_rounded',
        rewardType: RewardType.coins,
        rewardAmount: 1000,
        displayOrder: 5,
      ),
      const MilestoneDefinition(
        id: 'rank_platinum',
        name: 'Platinum Soul',
        description: 'Reach Platinum tier.',
        type: MilestoneType.rank,
        category: MilestoneCategory.ranking,
        threshold: 1,
        icon: 'verified_user_rounded',
        rewardType: RewardType.coins,
        rewardAmount: 2000,
        displayOrder: 6,
      ),
      const MilestoneDefinition(
        id: 'rank_diamond',
        name: 'Diamond Heart',
        description: 'Reach Diamond tier.',
        type: MilestoneType.rank,
        category: MilestoneCategory.ranking,
        threshold: 1,
        icon: 'diamond_rounded',
        rewardType: RewardType.coins,
        rewardAmount: 5000,
        displayOrder: 7,
      ),
      const MilestoneDefinition(
        id: 'top_100',
        name: 'Global Elite',
        description: 'Finish a season in the top 100.',
        type: MilestoneType.position,
        category: MilestoneCategory.ranking,
        threshold: 100,
        icon: 'public_rounded',
        rewardType: RewardType.coins,
        rewardAmount: 10000,
        displayOrder: 8,
      ),
      const MilestoneDefinition(
        id: 'career_best',
        name: 'Peak Performance',
        description: 'Achieve a new career-best rank.',
        type: MilestoneType.careerBest,
        category: MilestoneCategory.ranking,
        threshold: 1,
        icon: 'auto_awesome_rounded',
        rewardType: RewardType.coins,
        rewardAmount: 500,
        displayOrder: 9,
      ),
      const MilestoneDefinition(
        id: 'streak_5',
        name: 'Hot Streak',
        description: 'Achieve a 5-win streak.',
        type: MilestoneType.streak,
        category: MilestoneCategory.victory,
        threshold: 5,
        icon: 'local_fire_department_rounded',
        rewardType: RewardType.coins,
        rewardAmount: 250,
        displayOrder: 10,
      ),
      const MilestoneDefinition(
        id: 'matches_25',
        name: 'Veteran',
        description: 'Complete 25 competitive matches.',
        type: MilestoneType.count,
        category: MilestoneCategory.participation,
        threshold: 25,
        icon: 'shield_rounded',
        rewardType: RewardType.coins,
        rewardAmount: 1000,
        displayOrder: 11,
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
