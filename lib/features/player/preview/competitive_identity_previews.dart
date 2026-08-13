import 'package:flutter/material.dart';
import '../domain/models/competitive_identity.dart';
import '../domain/models/player_profile.dart';
import '../domain/models/player_progression.dart';
import '../domain/models/rank_progress.dart';
import '../domain/models/rank_tier.dart';
import '../domain/models/competitive_title.dart';
import '../domain/models/competitive_badge.dart';
import '../presentation/widgets/identity/identity_showcase_header.dart';
import '../presentation/widgets/identity/featured_badges_row.dart';
import '../presentation/widgets/identity/competitive_title_widget.dart';
import '../presentation/screens/competitive_showcase_screen.dart';

class CompetitiveIdentityPreviews extends StatelessWidget {
  const CompetitiveIdentityPreviews({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Section(
            title: 'Identity Header',
            child: IdentityShowcaseHeader(identity: _mockIdentity()),
          ),
          const SizedBox(height: 32),
          _Section(
            title: 'Title Widget (Large)',
            child: const CompetitiveTitleWidget(
              title: CompetitiveTitle(
                id: 'elite',
                name: 'Elite Competitor',
                description: 'Ranked in the top 1%',
              ),
              isLarge: true,
            ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: 'Featured Badges',
            child: FeaturedBadgesRow(
              badges: [
                _mockBadge('rank_gold', 'Gold Achievement'),
                _mockBadge('first_win', 'First Blood'),
                _mockBadge('streak_10', 'Decathlon'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _Section(
            title: 'Full Showcase (Preview Button)',
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CompetitiveShowcaseScreen(),
                  ),
                ),
                child: const Text('Open Full Showcase'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CompetitiveIdentity _mockIdentity() {
    final now = DateTime.now();
    final profile = PlayerProfile(
      uid: 'u1',
      displayName: 'Joseph',
      email: 'joseph@soteria.com',
      createdAt: now,
      lastLogin: now,
      updatedAt: now,
      gamesWon: 142,
    );

    return CompetitiveIdentity(
      userId: 'u1',
      profile: profile,
      progression: PlayerProgression(
        userId: 'u1',
        currentLevel: 42,
        currentXp: 1200,
        lifetimeXp: 45000,
        xpRequiredForCurrentLevel: 40000,
        xpRequiredForNextLevel: 42000,
        xpProgress: 0.6,
        currentRank: 'Gold II',
        currentRankTier: 'gold',
        rankPoints: 2450,
        rankProgress: 0.45,
        seasonId: 'season_5',
        seasonXp: 5000,
        seasonRankPoints: 450,
        lastUpdated: now,
      ),
      rankProgress: const RankProgress(
        currentRP: 2450,
        minimumRP: 2000,
        maximumRP: 3000,
        progressPercentage: 0.45,
        currentRank: 'Gold II',
        division: 2,
        tier: RankTier(
          id: 'gold',
          name: 'Gold',
          minPoints: 2000,
          maxPoints: 3000,
          displayOrder: 3,
          visualToken: 'gold_token',
          promotionThreshold: 3000,
          demotionThreshold: 2000,
        ),
      ),
      equippedTitle: const CompetitiveTitle(
        id: 'elite_competitor',
        name: 'Elite Competitor',
        description: 'Reached Elite rank.',
      ),
      featuredBadges: [
        _mockBadge('rank_gold', 'Gold Achievement'),
        _mockBadge('first_win', 'First Blood'),
      ],
    );
  }

  CompetitiveBadge _mockBadge(String id, String name) {
    return CompetitiveBadge(
      id: id,
      name: name,
      description: 'Achievement description',
      iconAsset: 'assets/badges/$id.png',
      category: BadgeCategory.achievement,
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
