import '../models/rank_tier.dart';

class ProgressionConfig {
  static const int maxLevel = 100;

  // Level Curve Constants (matching Gameplay Engine defaults for consistency)
  static const int baseLevelXP = 1000;
  static const double levelExponent = 1.2;
  static const int linearFactor = 200;

  static final List<RankTier> rankTiers = [
    const RankTier(
      id: 'unranked',
      name: 'Unranked',
      minPoints: 0,
      maxPoints: 99,
      displayOrder: 0,
      promotionThreshold: 100,
      demotionThreshold: 0,
      visualToken: 'assets/ranks/unranked.svg',
    ),
    const RankTier(
      id: 'bronze',
      name: 'Bronze',
      minPoints: 100,
      maxPoints: 499,
      displayOrder: 1,
      promotionThreshold: 500,
      demotionThreshold: 90,
      visualToken: 'assets/ranks/bronze.svg',
    ),
    const RankTier(
      id: 'silver',
      name: 'Silver',
      minPoints: 500,
      maxPoints: 999,
      displayOrder: 2,
      promotionThreshold: 1000,
      demotionThreshold: 450,
      visualToken: 'assets/ranks/silver.svg',
    ),
    const RankTier(
      id: 'gold',
      name: 'Gold',
      minPoints: 1000,
      maxPoints: 1999,
      displayOrder: 3,
      promotionThreshold: 2000,
      demotionThreshold: 950,
      visualToken: 'assets/ranks/gold.svg',
    ),
    const RankTier(
      id: 'platinum',
      name: 'Platinum',
      minPoints: 2000,
      maxPoints: 3499,
      displayOrder: 4,
      promotionThreshold: 3500,
      demotionThreshold: 1900,
      visualToken: 'assets/ranks/platinum.svg',
    ),
    const RankTier(
      id: 'diamond',
      name: 'Diamond',
      minPoints: 3500,
      maxPoints: 4999,
      displayOrder: 5,
      promotionThreshold: 5000,
      demotionThreshold: 3400,
      visualToken: 'assets/ranks/diamond.svg',
    ),
    const RankTier(
      id: 'master',
      name: 'Master',
      minPoints: 5000,
      maxPoints: 7499,
      displayOrder: 6,
      promotionThreshold: 7500,
      demotionThreshold: 4800,
      visualToken: 'assets/ranks/master.svg',
    ),
    const RankTier(
      id: 'elite',
      name: 'Elite',
      minPoints: 7500,
      maxPoints: 999999,
      displayOrder: 7,
      promotionThreshold: 999999,
      demotionThreshold: 7200,
      visualToken: 'assets/ranks/elite.svg',
    ),
  ];

  static int xpRequiredForLevel(int level) {
    if (level <= 1) return 0;
    // Simplified progression curve for the Story
    // In a real scenario, this would match LevelConfig exactly or be served by API
    return (baseLevelXP * (level - 1) * levelExponent +
            linearFactor * (level - 1))
        .toInt();
  }
}
