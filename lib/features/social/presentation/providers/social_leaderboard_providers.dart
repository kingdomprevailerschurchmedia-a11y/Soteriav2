import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/player/domain/models/leaderboard_entry.dart';
import 'package:soteria/features/player/presentation/providers/leaderboard_providers.dart';
import 'package:soteria/features/social/presentation/providers/social_providers.dart';

final friendsLeaderboardProvider = FutureProvider<List<LeaderboardEntry>>((ref) async {
  final friends = await ref.watch(friendsProvider.future);
  if (friends.isEmpty) return [];

  final currentUserId = ref.watch(authRepositoryProvider).currentUserId;
  final friendIds = friends.expand((f) => f.userIds).where((id) => id != currentUserId).toList();
  
  if (currentUserId != null) {
    friendIds.add(currentUserId);
  }

  final seasonId = ref.watch(currentSeasonIdProvider);
  final repository = ref.watch(leaderboardRepositoryProvider);
  
  final entries = await repository.getEntriesByUserIds(friendIds, seasonId: seasonId);
  
  // Authoritative sorting by RP
  return entries..sort((a, b) => b.rankPoints.compareTo(a.rankPoints));
});

final friendRankPositionProvider = Provider.family<int, String>((ref, userId) {
  final leaderboard = ref.watch(friendsLeaderboardProvider).value ?? [];
  final index = leaderboard.indexWhere((e) => e.userId == userId);
  return index != -1 ? index + 1 : -1;
});
