import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/player/domain/models/leaderboard_entry.dart';
import 'package:soteria/features/player/presentation/providers/leaderboard_providers.dart';
import 'package:soteria/features/social/presentation/providers/social_providers.dart';

final friendsLeaderboardProvider = StreamProvider<List<LeaderboardEntry>>((ref) {
  final friendsAsync = ref.watch(friendsProvider);
  
  return friendsAsync.when(
    data: (friends) {
      if (friends.isEmpty) return Stream.value([]);

      final currentUserId = ref.watch(authRepositoryProvider).currentUserId;
      final friendIds = friends.expand((f) => f.userIds).where((id) => id != currentUserId).toList();
      
      if (currentUserId != null) {
        friendIds.add(currentUserId);
      }

      final seasonId = ref.watch(currentSeasonIdProvider);
      final repository = ref.watch(leaderboardRepositoryProvider);
      
      return repository.watchEntriesByUserIds(friendIds, seasonId: seasonId).map((entries) {
        // Authoritative sorting by RP
        return entries..sort((a, b) => b.rankPoints.compareTo(a.rankPoints));
      });
    },
    loading: () => const Stream.empty(),
    error: (e, st) => Stream.error(e, st),
  );
});

final friendRankPositionProvider = Provider.family<int, String>((ref, userId) {
  final leaderboard = ref.watch(friendsLeaderboardProvider).value ?? [];
  final index = leaderboard.indexWhere((e) => e.userId == userId);
  return index != -1 ? index + 1 : -1;
});
