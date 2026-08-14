import 'package:soteria/features/player/domain/models/competitive_mission.dart';
import 'package:soteria/features/player/domain/models/season_reward_definition.dart';

class MissionFixtures {
  static MissionDefinition dailyPlay = const MissionDefinition(
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
  );

  static MissionDefinition dailyWin = const MissionDefinition(
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
  );

  static MissionDefinition weeklyWin = const MissionDefinition(
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
  );

  static MissionDefinition seasonalGold = const MissionDefinition(
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
  );

  static CompetitiveMission activeDaily() => CompetitiveMission(
        definition: dailyPlay,
        state: UserMissionState(
          userId: 'user_1',
          missionId: dailyPlay.id,
          progress: 1,
          status: MissionStatus.active,
          startAt: DateTime.now().subtract(const Duration(hours: 2)),
          endAt: DateTime.now().add(const Duration(hours: 22)),
        ),
      );

  static CompetitiveMission completedDaily() => CompetitiveMission(
        definition: dailyWin,
        state: UserMissionState(
          userId: 'user_1',
          missionId: dailyWin.id,
          progress: 1,
          status: MissionStatus.completed,
          startAt: DateTime.now().subtract(const Duration(hours: 5)),
          endAt: DateTime.now().add(const Duration(hours: 19)),
          completedAt: DateTime.now().subtract(const Duration(minutes: 10)),
        ),
      );

  static CompetitiveMission activeWeekly() => CompetitiveMission(
        definition: weeklyWin,
        state: UserMissionState(
          userId: 'user_1',
          missionId: weeklyWin.id,
          progress: 7,
          status: MissionStatus.active,
          startAt: DateTime.now().subtract(const Duration(days: 2)),
          endAt: DateTime.now().add(const Duration(days: 5)),
        ),
      );

  static CompetitiveMission activeSeasonal() => CompetitiveMission(
        definition: seasonalGold,
        state: UserMissionState(
          userId: 'user_1',
          missionId: seasonalGold.id,
          progress: 2850,
          status: MissionStatus.active,
          startAt: DateTime.now().subtract(const Duration(days: 15)),
          endAt: DateTime.now().add(const Duration(days: 15)),
        ),
      );
      
  static CompetitiveMission claimedHistory() => CompetitiveMission(
        definition: dailyPlay,
        state: UserMissionState(
          userId: 'user_1',
          missionId: dailyPlay.id,
          progress: 2,
          status: MissionStatus.claimed,
          startAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
          endAt: DateTime.now().subtract(const Duration(hours: 2)),
          completedAt: DateTime.now().subtract(const Duration(days: 1)),
          claimedAt: DateTime.now().subtract(const Duration(hours: 23)),
        ),
      );

  static List<CompetitiveMission> allActive() => [
        activeDaily(),
        completedDaily(),
        activeWeekly(),
        activeSeasonal(),
      ];
}
