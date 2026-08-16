import '../models/achievement.dart';

class AchievementRegistry {
  static const List<AchievementDefinition> definitions = [
    // Score Milestones
    AchievementDefinition(
      id: 'score_1k',
      title: 'Centurion',
      description: 'Reach a total score of 1,000 points.',
      category: AchievementCategory.general,
      icon: 'stars_rounded',
      requirementType: AchievementRequirementType.score,
      threshold: 1000,
      rarity: AchievementRarity.common,
      xpReward: 50,
      displayOrder: 1,
    ),
    AchievementDefinition(
      id: 'score_5k',
      title: 'High Scorer',
      description: 'Reach a total score of 5,000 points.',
      category: AchievementCategory.general,
      icon: 'military_tech_rounded',
      requirementType: AchievementRequirementType.score,
      threshold: 5000,
      rarity: AchievementRarity.uncommon,
      xpReward: 250,
      displayOrder: 2,
    ),
    AchievementDefinition(
      id: 'score_10k',
      title: 'Master Scorer',
      description: 'Reach a total score of 10,000 points.',
      category: AchievementCategory.general,
      icon: 'workspace_premium_rounded',
      requirementType: AchievementRequirementType.score,
      threshold: 10000,
      rarity: AchievementRarity.rare,
      xpReward: 500,
      displayOrder: 3,
    ),

    // Streak Milestones
    AchievementDefinition(
      id: 'streak_10',
      title: 'Hot Streak',
      description: 'Achieve a 10-question correct streak.',
      category: AchievementCategory.streak,
      icon: 'local_fire_department_rounded',
      requirementType: AchievementRequirementType.streak,
      threshold: 10,
      rarity: AchievementRarity.common,
      xpReward: 50,
      displayOrder: 10,
    ),
    AchievementDefinition(
      id: 'streak_50',
      title: 'Unstoppable',
      description: 'Achieve a 50-question correct streak.',
      category: AchievementCategory.streak,
      icon: 'bolt_rounded',
      requirementType: AchievementRequirementType.streak,
      threshold: 50,
      rarity: AchievementRarity.rare,
      xpReward: 500,
      displayOrder: 11,
    ),

    // Level Milestones
    AchievementDefinition(
      id: 'level_10',
      title: 'Decathlon',
      description: 'Reach Level 10.',
      category: AchievementCategory.ranking,
      icon: 'trending_up_rounded',
      requirementType: AchievementRequirementType.level,
      threshold: 10,
      rarity: AchievementRarity.common,
      xpReward: 100,
      displayOrder: 20,
    ),
    AchievementDefinition(
      id: 'level_25',
      title: 'Veteran',
      description: 'Reach Level 25.',
      category: AchievementCategory.ranking,
      icon: 'shield_rounded',
      requirementType: AchievementRequirementType.level,
      threshold: 25,
      rarity: AchievementRarity.uncommon,
      xpReward: 500,
      displayOrder: 21,
    ),

    // Participation
    AchievementDefinition(
      id: 'first_game',
      title: 'First Step',
      description: 'Complete your first game.',
      category: AchievementCategory.participation,
      icon: 'play_arrow_rounded',
      requirementType: AchievementRequirementType.gamesPlayed,
      threshold: 1,
      rarity: AchievementRarity.common,
      xpReward: 25,
      displayOrder: 30,
    ),
    AchievementDefinition(
      id: 'games_50',
      title: 'Enthusiast',
      description: 'Complete 50 games.',
      category: AchievementCategory.participation,
      icon: 'sports_esports_rounded',
      requirementType: AchievementRequirementType.gamesPlayed,
      threshold: 50,
      rarity: AchievementRarity.uncommon,
      xpReward: 250,
      displayOrder: 31,
    ),

    // Wins
    AchievementDefinition(
      id: 'first_win',
      title: 'First Blood',
      description: 'Win your first competitive game.',
      category: AchievementCategory.victory,
      icon: 'emoji_events_rounded',
      requirementType: AchievementRequirementType.gamesWon,
      threshold: 1,
      rarity: AchievementRarity.common,
      xpReward: 100,
      displayOrder: 40,
    ),

    // Special
    AchievementDefinition(
      id: 'logic_master',
      title: 'Logic Master',
      description: 'Answer 10 logic questions correctly.',
      category: AchievementCategory.special,
      icon: 'psychology_rounded',
      requirementType: AchievementRequirementType.categoryMastery,
      threshold: 10,
      rarity: AchievementRarity.uncommon,
      xpReward: 200,
      metadata: {'category': 'logic'},
      displayOrder: 50,
    ),
    AchievementDefinition(
      id: 'century',
      title: 'Century',
      description: 'Score 100 points in a single match.',
      category: AchievementCategory.special,
      icon: 'auto_awesome_rounded',
      requirementType: AchievementRequirementType.score,
      threshold: 100,
      rarity: AchievementRarity.common,
      xpReward: 50,
      metadata: {'singleMatch': true},
      displayOrder: 51,
    ),
  ];

  static AchievementDefinition? getById(String id) {
    for (final def in definitions) {
      if (def.id == id) return def;
    }
    return null;
  }

  static List<AchievementDefinition> getByCategory(AchievementCategory category) {
    return definitions.where((d) => d.category == category).toList();
  }
}
