import '../models/competitive_streak.dart';
import '../models/momentum.dart';

abstract interface class StreakRepository {
  /// Watches the win streak for a user.
  Stream<CompetitiveStreak?> watchWinStreak(String userId);

  /// Watches the current momentum for a user.
  Stream<CompetitiveMomentum?> watchMomentum(String userId);

  /// Fetches the current streak state.
  Future<CompetitiveStreak?> getWinStreak(String userId);

  /// Updates the streak state.
  Future<void> updateWinStreak(CompetitiveStreak streak);

  /// Updates the momentum state.
  Future<void> updateMomentum(CompetitiveMomentum momentum);
}
