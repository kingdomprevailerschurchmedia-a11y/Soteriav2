import '../models/player_profile.dart';
import '../models/progression.dart';

class ProgressionService {
  /// XP Formula: XP for Level N = 1000 * N
  /// Total XP to reach Level N = 500 * (N-1) * N

  Progression calculateProgression(PlayerProfile? player) {
    if (player == null) return Progression.initial();

    int totalXp = player.xp;
    if (totalXp < 0) totalXp = 0;

    int level = 1;
    int xpRemaining = totalXp;

    // Find level
    while (true) {
      int xpForNext = calculateXpForLevel(level);
      if (xpRemaining < xpForNext) {
        break;
      }
      xpRemaining -= xpForNext;
      level++;
    }

    final int nextLevelXpThreshold = calculateXpForLevel(level);
    final double progress = (xpRemaining / nextLevelXpThreshold).clamp(
      0.0,
      1.0,
    );

    return Progression(
      level: level,
      currentXp: totalXp,
      nextLevelXp: nextLevelXpThreshold,
      xpInCurrentLevel: xpRemaining,
      progressPercentage: progress,
      xpRemaining: nextLevelXpThreshold - xpRemaining,
      profileCompletion: calculateProfileCompletion(player),
    );
  }

  double calculateProfileCompletion(PlayerProfile? player) {
    if (player == null) return 0.0;

    int totalFields = 5;
    int filledFields = 0;

    if (player.displayName.isNotEmpty && player.displayName != 'Scholar')
      filledFields++;
    if (player.photoUrl.isNotEmpty) filledFields++;
    if (player.favoriteCategories.isNotEmpty) filledFields++;
    if (player.email.isNotEmpty) filledFields++;
    if (player.avatarFrame != 'default') filledFields++;

    return (filledFields / totalFields).clamp(0.0, 1.0);
  }

  int calculateXpForLevel(int level) {
    // 1 -> 2: 1000
    // 2 -> 3: 2000
    // 3 -> 4: 3000
    return level * 1000;
  }
}
