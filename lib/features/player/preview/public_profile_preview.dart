import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../presentation/screens/public_competitive_profile_screen.dart';
import '../presentation/screens/player_search_screen.dart';
import '../presentation/providers/public_profile_providers.dart';
import '../domain/models/public_competitive_profile.dart';
import '../domain/models/competitive_statistics.dart';
import '../domain/models/competitive_title.dart';

class PublicProfilePreviewWrapper extends StatelessWidget {
  final PublicCompetitiveProfile? profile;
  final List<PublicCompetitiveProfile>? searchResults;

  const PublicProfilePreviewWrapper({
    super.key,
    this.profile,
    this.searchResults,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        if (profile != null)
          publicProfileProvider(profile!.userId).overrideWith((ref) => profile),
        if (searchResults != null)
          playerSearchProvider.overrideWith((ref) => searchResults!),
      ],
      child: profile != null
          ? PublicCompetitiveProfileScreen(userId: profile!.userId)
          : const PlayerSearchScreen(),
    );
  }
}

class PublicProfilePreviews {
  static PublicCompetitiveProfile mockEliteProfile() {
    return _createMockProfile(
      name: 'Elite Scholar',
      rank: 'Elite',
      tier: 'Elite',
      points: 4500,
      title: 'Elite Competitor',
    );
  }

  static PublicCompetitiveProfile mockNewProfile() {
    return _createMockProfile(
      name: 'Newcomer',
      rank: 'Unranked',
      tier: 'None',
      points: 0,
    );
  }

  static Widget elite() => PublicProfilePreviewWrapper(profile: mockEliteProfile());
  static Widget newPlayer() => PublicProfilePreviewWrapper(profile: mockNewProfile());
  static Widget search() => PublicProfilePreviewWrapper(
        searchResults: [
          mockEliteProfile(),
          _createMockProfile(name: 'Pro Tester', rank: 'Diamond', tier: 'Diamond', points: 3200),
          mockNewProfile(),
        ],
      );

  static PublicCompetitiveProfile _createMockProfile({
    required String name,
    required String rank,
    required String tier,
    required int points,
    String? title,
  }) {
    return PublicCompetitiveProfile(
      userId: 'mock_${name.hashCode}',
      displayName: name,
      avatarId: 'socrates',
      currentRank: rank,
      rankTier: tier,
      rankPoints: points,
      division: 1,
      equippedTitle: title != null
          ? CompetitiveTitle(id: 't1', name: title, description: 'Desc')
          : null,
      careerHighlights: CareerStatistics(
        gamesPlayed: 100,
        gamesWon: 70,
        gamesLost: 30,
        winRate: 0.7,
        totalQuestionsAnswered: 1000,
        correctAnswers: 850,
        accuracy: 0.85,
        currentStreak: 5,
        highestStreak: 15,
        bestRank: rank,
        peakPosition: 12,
        seasonsPlayed: 5,
      ),
      updatedAt: DateTime.now(),
    );
  }
}
