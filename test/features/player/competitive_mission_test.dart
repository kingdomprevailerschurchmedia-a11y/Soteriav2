import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/competitive_mission.dart';
import 'package:soteria/features/player/domain/models/season_reward_definition.dart';

void main() {
  group('CompetitiveMission Model', () {
    test('should calculate progress percentage correctly', () {
      final definition = const MissionDefinition(
        id: 'm1',
        type: MissionType.playMatches,
        period: MissionPeriod.daily,
        title: 'Title',
        description: 'Desc',
        target: 10,
        difficulty: MissionDifficulty.easy,
        rewardType: RewardType.xp,
        rewardAmount: 100,
      );
      
      final state = UserMissionState(
        userId: 'u1',
        missionId: 'm1',
        progress: 5,
        status: MissionStatus.active,
        startAt: DateTime.now(),
        endAt: DateTime.now().add(const Duration(hours: 1)),
      );
      
      final mission = CompetitiveMission(definition: definition, state: state);
      
      expect(mission.progressPercentage, 0.5);
      expect(mission.remaining, 5.0);
      expect(mission.isCompleted, false);
    });

    test('should identify completed status', () {
      final definition = const MissionDefinition(
        id: 'm1',
        type: MissionType.playMatches,
        period: MissionPeriod.daily,
        title: 'Title',
        description: 'Desc',
        target: 10,
        difficulty: MissionDifficulty.easy,
        rewardType: RewardType.xp,
        rewardAmount: 100,
      );
      
      final state = UserMissionState(
        userId: 'u1',
        missionId: 'm1',
        progress: 10,
        status: MissionStatus.completed,
        startAt: DateTime.now(),
        endAt: DateTime.now().add(const Duration(hours: 1)),
      );
      
      final mission = CompetitiveMission(definition: definition, state: state);
      
      expect(mission.isCompleted, true);
      expect(mission.progressPercentage, 1.0);
    });

    test('should identify expiring soon missions', () {
      final definition = const MissionDefinition(
        id: 'm1',
        type: MissionType.playMatches,
        period: MissionPeriod.daily,
        title: 'Title',
        description: 'Desc',
        target: 10,
        difficulty: MissionDifficulty.easy,
        rewardType: RewardType.xp,
        rewardAmount: 100,
      );
      
      final state = UserMissionState(
        userId: 'u1',
        missionId: 'm1',
        progress: 2,
        status: MissionStatus.active,
        startAt: DateTime.now().subtract(const Duration(hours: 20)),
        endAt: DateTime.now().add(const Duration(hours: 2)), // 2 hours left
      );
      
      final mission = CompetitiveMission(definition: definition, state: state);
      
      expect(mission.isExpiringSoon, true);
    });
  });
}
