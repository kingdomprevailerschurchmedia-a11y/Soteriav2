import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/player_progression.dart';
import '../presentation/providers/progression_providers.dart';
import '../presentation/widgets/player_progression_card.dart';
import '../presentation/widgets/level_up_celebration.dart';
import '../domain/models/rank_change.dart';
import '../presentation/screens/rank_promotion_screen.dart';
import '../presentation/screens/rank_demotion_screen.dart';
import '../presentation/widgets/competitive_rank_badge.dart';

class ProgressionPreviewWrapper extends StatelessWidget {
  final Widget child;
  final PlayerProgression mockProgression;

  const ProgressionPreviewWrapper({
    super.key,
    required this.child,
    required this.mockProgression,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        competitiveProgressionProvider.overrideWith(
          (ref) => Stream.value(mockProgression),
        ),
      ],
      child: child,
    );
  }
}

class ProgressionPreviews {
  static PlayerProgression mock({
    int level = 1,
    int xp = 0,
    String rank = 'Unranked',
    String tier = 'none',
    int rankPoints = 0,
    double xpProgress = 0.0,
    double rankProgress = 0.0,
  }) {
    return PlayerProgression(
      userId: 'mock_user',
      currentLevel: level,
      currentXp: xp,
      lifetimeXp: xp + 5000,
      xpRequiredForCurrentLevel: 0,
      xpRequiredForNextLevel: 1000,
      xpProgress: xpProgress,
      currentRank: rank,
      currentRankTier: tier,
      rankPoints: rankPoints,
      rankProgress: rankProgress,
      seasonId: 'mock_season',
      seasonXp: xp,
      seasonRankPoints: rankPoints,
      lastUpdated: DateTime.now(),
    );
  }

  static Widget cardBronze() => ProgressionPreviewWrapper(
    mockProgression: mock(
      level: 5,
      xp: 450,
      rank: 'Bronze III',
      tier: 'bronze',
      xpProgress: 0.45,
      rankProgress: 0.2,
    ),
    child: PlayerProgressionCard(
      progression: mock(
        level: 5,
        xp: 450,
        rank: 'Bronze III',
        tier: 'bronze',
        xpProgress: 0.45,
        rankProgress: 0.2,
      ),
    ),
  );

  static Widget cardGold() => ProgressionPreviewWrapper(
    mockProgression: mock(
      level: 24,
      xp: 850,
      rank: 'Gold I',
      tier: 'gold',
      xpProgress: 0.85,
      rankProgress: 0.9,
    ),
    child: PlayerProgressionCard(
      progression: mock(
        level: 24,
        xp: 850,
        rank: 'Gold I',
        tier: 'gold',
        xpProgress: 0.85,
        rankProgress: 0.9,
      ),
    ),
  );

  static Widget levelUp() =>
      LevelUpCelebration(previousLevel: 14, newLevel: 15, onContinue: () {});

  static Widget promotion() => RankPromotionScreen(
    rankChange: RankChange(
      changeId: 'mock_promotion',
      userId: 'mock_user',
      seasonId: 'mock_season',
      previousRank: 'Silver I',
      newRank: 'Gold III',
      previousRankPoints: 980,
      newRankPoints: 1005,
      changeAmount: 25,
      type: RankChangeType.promotion,
      isTierChange: true,
      createdAt: DateTime.now(),
    ),
    onContinue: () {},
  );

  static Widget demotion() => RankDemotionScreen(
    rankChange: RankChange(
      changeId: 'mock_demotion',
      userId: 'mock_user',
      seasonId: 'mock_season',
      previousRank: 'Gold III',
      newRank: 'Silver I',
      previousRankPoints: 1010,
      newRankPoints: 995,
      changeAmount: -15,
      type: RankChangeType.demotion,
      createdAt: DateTime.now(),
    ),
    onContinue: () {},
  );

  static Widget rankBadges() => Scaffold(
    backgroundColor: const Color(0xFF0B012A),
    body: Center(
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: const [
          CompetitiveRankBadge(rankName: 'Unranked', tierId: 'none'),
          CompetitiveRankBadge(rankName: 'Bronze III', tierId: 'bronze'),
          CompetitiveRankBadge(rankName: 'Silver II', tierId: 'silver'),
          CompetitiveRankBadge(rankName: 'Gold I', tierId: 'gold'),
          CompetitiveRankBadge(rankName: 'Platinum IV', tierId: 'platinum'),
          CompetitiveRankBadge(rankName: 'Diamond III', tierId: 'diamond'),
          CompetitiveRankBadge(rankName: 'Master II', tierId: 'master'),
          CompetitiveRankBadge(rankName: 'Elite', tierId: 'elite'),
        ],
      ),
    ),
  );
}
