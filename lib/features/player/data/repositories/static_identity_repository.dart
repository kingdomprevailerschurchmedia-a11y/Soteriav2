import '../../domain/models/competitive_title.dart';
import '../../domain/models/competitive_badge.dart';
import '../../domain/repositories/identity_repository.dart';

class StaticIdentityRepository implements IdentityRepository {
  @override
  Future<List<CompetitiveTitle>> getTitleDefinitions() async {
    return [
      const CompetitiveTitle(
        id: 'rising_competitor',
        name: 'Rising Competitor',
        description: 'Complete 5 competitive matches.',
        priority: 1,
      ),
      const CompetitiveTitle(
        id: 'platinum_competitor',
        name: 'Platinum Competitor',
        description: 'Reach Platinum rank.',
        priority: 2,
      ),
      const CompetitiveTitle(
        id: 'elite_competitor',
        name: 'Elite Competitor',
        description: 'Reach Elite rank.',
        priority: 3,
      ),
      const CompetitiveTitle(
        id: 'tournament_winner',
        name: 'Tournament Winner',
        description: 'Win a competitive tournament.',
        priority: 4,
      ),
      const CompetitiveTitle(
        id: 'season_champion',
        name: 'Season Champion',
        description: 'Finish a season in rank #1.',
        priority: 5,
      ),
      const CompetitiveTitle(
        id: 'top_10',
        name: 'Top 10',
        description: 'Finish a season in the top 10.',
        priority: 4,
      ),
      const CompetitiveTitle(
        id: 'career_legend',
        name: 'Career Legend',
        description: 'Achieve 500 competitive wins.',
        priority: 10,
      ),
    ];
  }

  @override
  Future<List<CompetitiveBadge>> getBadgeDefinitions() async {
    return [
      const CompetitiveBadge(
        id: 'rank_gold',
        name: 'Gold Achievement',
        description: 'Reached Gold Tier',
        iconAsset: 'assets/badges/rank_gold.png',
        category: BadgeCategory.rank,
        displayOrder: 1,
      ),
      const CompetitiveBadge(
        id: 'rank_platinum',
        name: 'Platinum Achievement',
        description: 'Reached Platinum Tier',
        iconAsset: 'assets/badges/rank_platinum.png',
        category: BadgeCategory.rank,
        displayOrder: 2,
      ),
      const CompetitiveBadge(
        id: 'rank_diamond',
        name: 'Diamond Achievement',
        description: 'Reached Diamond Tier',
        iconAsset: 'assets/badges/rank_diamond.png',
        category: BadgeCategory.rank,
        displayOrder: 3,
      ),
      const CompetitiveBadge(
        id: 'first_win',
        name: 'First Blood',
        description: 'Won first competitive match',
        iconAsset: 'assets/badges/first_win.png',
        category: BadgeCategory.career,
        displayOrder: 10,
      ),
      const CompetitiveBadge(
        id: 'streak_10',
        name: 'Decathlon',
        description: 'Achieved a 10-win streak',
        iconAsset: 'assets/badges/streak_10.png',
        category: BadgeCategory.career,
        displayOrder: 11,
      ),
      const CompetitiveBadge(
        id: 'tournament_winner',
        name: 'Champion',
        description: 'Won a tournament',
        iconAsset: 'assets/badges/tournament_winner.png',
        category: BadgeCategory.tournament,
        displayOrder: 20,
      ),
    ];
  }

  @override
  Future<CompetitiveTitle?> getTitle(String titleId) async {
    final titles = await getTitleDefinitions();
    return titles.where((t) => t.id == titleId).firstOrNull;
  }

  @override
  Future<CompetitiveBadge?> getBadge(String badgeId) async {
    final badges = await getBadgeDefinitions();
    return badges.where((b) => b.id == badgeId).firstOrNull;
  }
}
