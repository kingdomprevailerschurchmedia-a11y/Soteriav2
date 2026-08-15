import '../models/goal.dart';
import '../models/season_reward_definition.dart';

class GoalRegistry {
  static const List<GoalDefinition> definitions = [
    GoalDefinition(
      id: 'daily_games_3',
      title: 'Daily Participation',
      description: 'Play 3 competitive games today.',
      type: GoalType.daily,
      category: GoalCategory.gameCount,
      target: 3,
      icon: 'sports_esports_rounded',
      rewardType: RewardType.xp,
      rewardAmount: 250,
      displayOrder: 1,
    ),
    GoalDefinition(
      id: 'daily_wins_2',
      title: 'Winning Streak',
      description: 'Win 2 competitive games today.',
      type: GoalType.daily,
      category: GoalCategory.win,
      target: 2,
      icon: 'emoji_events_rounded',
      rewardType: RewardType.xp,
      rewardAmount: 500,
      displayOrder: 2,
    ),
    GoalDefinition(
      id: 'weekly_games_20',
      title: 'Weekly Warrior',
      description: 'Play 20 competitive games this week.',
      type: GoalType.weekly,
      category: GoalCategory.gameCount,
      target: 20,
      icon: 'military_tech_rounded',
      rewardType: RewardType.xp,
      rewardAmount: 2000,
      displayOrder: 3,
    ),
    GoalDefinition(
      id: 'weekly_wins_10',
      title: 'Weekly Champion',
      description: 'Win 10 competitive games this week.',
      type: GoalType.weekly,
      category: GoalCategory.win,
      target: 10,
      icon: 'workspace_premium_rounded',
      rewardType: RewardType.xp,
      rewardAmount: 5000,
      displayOrder: 4,
    ),
  ];

  static GoalDefinition? getById(String id) {
    try {
      return definitions.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<GoalDefinition> getByType(GoalType type) {
    return definitions.where((d) => d.type == type).toList();
  }
}
