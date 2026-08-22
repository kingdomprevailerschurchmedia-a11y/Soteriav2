import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/features/player/domain/models/competitive_mission.dart';
import 'package:soteria/features/player/domain/models/season_reward_definition.dart';
import 'package:soteria/features/player/domain/repositories/mission_repository.dart';

class FirebaseMissionRepository implements MissionRepository {
  final FirebaseFirestore _firestore;

  FirebaseMissionRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> _userMissionsCollection(String userId) =>
      _firestore.collection('users').doc(userId).collection('missions');

  @override
  Stream<List<CompetitiveMission>> watchActiveMissions(String userId) {
    return _userMissionsCollection(userId)
        .where('status', whereIn: ['active', 'completed'])
        .snapshots()
        .asyncMap((snapshot) async {
          final definitions = await getMissionDefinitions();
          final missions = <CompetitiveMission>[];
          
          for (final doc in snapshot.docs) {
            final state = UserMissionState.fromJson(doc.data());
            final definition = definitions.firstWhere(
              (d) => d.id == state.missionId,
              orElse: () => _unknownDefinition(state.missionId),
            );
            missions.add(CompetitiveMission(definition: definition, state: state));
          }
          
          return missions;
        });
  }

  @override
  Stream<List<CompetitiveMission>> watchMissionsByPeriod(
    String userId,
    MissionPeriod period,
  ) {
    // In a real app, we might store the period in the user mission state
    // for easier querying. For now, we'll filter on the client after fetching active.
    return watchActiveMissions(userId).map((missions) {
      return missions.where((m) => m.definition.period == period).toList();
    });
  }

  @override
  Future<List<CompetitiveMission>> getMissionHistory(String userId) async {
    final snapshot = await _userMissionsCollection(userId)
        .where('status', whereIn: ['claimed', 'expired'])
        .orderBy('endAt', descending: true)
        .limit(50)
        .get();

    final definitions = await getMissionDefinitions();
    return snapshot.docs.map((doc) {
      final state = UserMissionState.fromJson(doc.data());
      final definition = definitions.firstWhere(
        (d) => d.id == state.missionId,
        orElse: () => _unknownDefinition(state.missionId),
      );
      return CompetitiveMission(definition: definition, state: state);
    }).toList();
  }

  @override
  Future<CompetitiveMission?> getMission(String userId, String missionId) async {
    final doc = await _userMissionsCollection(userId).doc(missionId).get();
    if (!doc.exists) return null;
    
    final state = UserMissionState.fromJson(doc.data()!);
    final definitions = await getMissionDefinitions();
    final definition = definitions.firstWhere(
      (d) => d.id == state.missionId,
      orElse: () => _unknownDefinition(state.missionId),
    );
    
    return CompetitiveMission(definition: definition, state: state);
  }

  @override
  Future<void> claimReward(String userId, String missionId) async {
    // Server-side logic would handle the actual reward granting.
    // Here we just update the status to claimed.
    await _userMissionsCollection(userId).doc(missionId).update({
      'status': MissionStatus.claimed.name,
      'claimedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> refreshMissions(String userId) async {
    final now = DateTime.now();
    final definitions = await getMissionDefinitions();
    
    for (final definition in definitions) {
      final missionId = _generateMissionId(definition, now);
      final doc = await _userMissionsCollection(userId).doc(missionId).get();
      
      if (!doc.exists) {
        final period = _calculatePeriod(definition.period, now);
        final state = UserMissionState(
          userId: userId,
          missionId: definition.id,
          progress: 0,
          status: MissionStatus.active,
          startAt: period.start,
          endAt: period.end,
        );
        await _userMissionsCollection(userId).doc(missionId).set(state.toJson());
      }
    }
  }

  Future<List<MissionDefinition>> getMissionDefinitions() async {
    // Deterministic definitions as per requirements
    return [
      const MissionDefinition(
        id: 'daily_play_2',
        type: MissionType.playMatches,
        period: MissionPeriod.daily,
        title: 'Daily Challenger',
        description: 'Play 2 competitive matches today.',
        target: 2,
        difficulty: MissionDifficulty.easy,
        rewardType: RewardType.xp,
        rewardAmount: 100,
        icon: 'play_circle_filled',
      ),
      const MissionDefinition(
        id: 'daily_win_1',
        type: MissionType.winMatches,
        period: MissionPeriod.daily,
        title: 'Winner\'s Touch',
        description: 'Win 1 competitive match.',
        target: 1,
        difficulty: MissionDifficulty.easy,
        rewardType: RewardType.xp,
        rewardAmount: 150,
        icon: 'emoji_events',
      ),
      const MissionDefinition(
        id: 'weekly_win_10',
        type: MissionType.winMatches,
        period: MissionPeriod.weekly,
        title: 'Weekly Warrior',
        description: 'Win 10 competitive matches this week.',
        target: 10,
        difficulty: MissionDifficulty.medium,
        rewardType: RewardType.xp,
        rewardAmount: 500,
        icon: 'military_tech',
      ),
      const MissionDefinition(
        id: 'weekly_xp_1000',
        type: MissionType.earnXp,
        period: MissionPeriod.weekly,
        title: 'Experience Hunter',
        description: 'Earn 1,000 XP in competitive modes.',
        target: 1000,
        difficulty: MissionDifficulty.medium,
        rewardType: RewardType.xp,
        rewardAmount: 250,
        icon: 'trending_up',
      ),
      const MissionDefinition(
        id: 'seasonal_gold',
        type: MissionType.earnRp,
        period: MissionPeriod.seasonal,
        title: 'Gold Pursuit',
        description: 'Reach Gold I rank this season.',
        target: 3000,
        difficulty: MissionDifficulty.hard,
        rewardType: RewardType.xp,
        rewardAmount: 1000,
        icon: 'workspace_premium',
      ),
    ];
  }

  String _generateMissionId(MissionDefinition definition, DateTime now) {
    final period = _calculatePeriod(definition.period, now);
    return '${definition.id}_${period.start.millisecondsSinceEpoch}';
  }

  _Period _calculatePeriod(MissionPeriod period, DateTime now) {
    switch (period) {
      case MissionPeriod.daily:
        final start = DateTime(now.year, now.month, now.day);
        return _Period(start, start.add(const Duration(days: 1)));
      case MissionPeriod.weekly:
        final start = now.subtract(Duration(days: now.weekday - 1));
        final mondayStart = DateTime(start.year, start.month, start.day);
        return _Period(mondayStart, mondayStart.add(const Duration(days: 7)));
      case MissionPeriod.seasonal:
        // Simplified: seasons are monthly for now
        final start = DateTime(now.year, now.month, 1);
        final end = DateTime(now.year, now.month + 1, 1);
        return _Period(start, end);
      case MissionPeriod.career:
        return _Period(DateTime(2020), DateTime(2099));
    }
  }

  MissionDefinition _unknownDefinition(String id) {
    return MissionDefinition(
      id: id,
      type: MissionType.playMatches,
      period: MissionPeriod.daily,
      title: 'Unknown Mission',
      description: 'Mission details unavailable.',
      target: 1,
      difficulty: MissionDifficulty.easy,
      rewardType: RewardType.xp,
      rewardAmount: 0,
    );
  }
}

class _Period {
  final DateTime start;
  final DateTime end;
  _Period(this.start, this.end);
}
