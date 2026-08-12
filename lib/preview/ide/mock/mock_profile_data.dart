import '../../../features/player/domain/models/competitive_profile.dart';
import '../../../features/player/domain/models/player_profile.dart';
import '../../../features/player/domain/models/player_progression.dart';
import '../../../features/player/domain/models/season_result.dart';
import '../../../features/player/domain/models/competitive_season.dart';

class MockProfileData {
  static PlayerProfile get mockPlayer => PlayerProfile(
    uid: 'mock_user',
    displayName: 'SoteriaPlayer',
    email: 'player@soteria.app',
    createdAt: DateTime.now(),
    lastLogin: DateTime.now(),
    updatedAt: DateTime.now(),
    level: 5,
    xp: 2500,
    coins: 500,
    accuracy: 0.85,
    gamesPlayed: 50,
    gamesWon: 35,
  );

  static PlayerProgression get mockProgression => PlayerProgression(
    userId: 'mock_user',
    currentLevel: 5,
    currentXp: 500,
    lifetimeXp: 2500,
    xpRequiredForCurrentLevel: 2000,
    xpRequiredForNextLevel: 3000,
    xpProgress: 0.5,
    currentRank: 'Diamond II',
    currentRankTier: 'diamond',
    rankPoints: 1250,
    rankProgress: 0.75,
    seasonId: 'season_8',
    seasonXp: 1200,
    seasonRankPoints: 1250,
    lastUpdated: DateTime.now(),
  );

  static CompetitiveProfile get mockProfile => CompetitiveProfile(
    identity: mockPlayer,
    progression: mockProgression,
    currentSeason: CompetitiveSeason(
      seasonId: 'season_8',
      name: 'Season 8: Ascendance',
      startAt: DateTime.now().subtract(const Duration(days: 30)),
      endAt: DateTime.now().add(const Duration(days: 60)),
      status: SeasonStatus.active,
      seasonNumber: 8,
      createdAt: DateTime.now().subtract(const Duration(days: 40)),
      updatedAt: DateTime.now(),
    ),
    globalPosition: 42,
    history: CompetitiveHistory(userId: 'mock_user', results: []),
    recentRewards: [],
    totalRewards: 12,
    completedMilestones: [],
    totalMilestones: 25,
  );
}
