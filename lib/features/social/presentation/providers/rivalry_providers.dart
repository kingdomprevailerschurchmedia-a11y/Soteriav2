import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/player/domain/models/competitive_match.dart';
import 'package:soteria/features/player/presentation/providers/match_history_providers.dart';
import 'package:soteria/features/player/presentation/providers/progression_providers.dart';
import 'package:soteria/features/social/domain/models/player_rivalry.dart';
import 'package:soteria/features/social/domain/repositories/rivalry_repository.dart';
import 'package:soteria/features/social/data/repositories/firebase_rivalry_repository.dart';
import 'package:soteria/features/social/presentation/providers/social_providers.dart';

final rivalryRepositoryProvider = Provider<RivalryRepository>((ref) {
  return FirebaseRivalryRepository(ref.watch(competitiveResultRepositoryProvider));
});

final topRivalriesProvider = FutureProvider<List<PlayerRivalry>>((ref) async {
  final currentUserId = ref.watch(authRepositoryProvider).currentUserId;
  if (currentUserId == null) return [];
  
  return ref.watch(rivalryRepositoryProvider).getTopRivalries(currentUserId);
});

final headToHeadProvider = FutureProvider.family<PlayerRivalry, String>((ref, rivalId) async {
  final currentUserId = ref.watch(authRepositoryProvider).currentUserId;
  if (currentUserId == null) throw Exception('Not authenticated');

  return ref.watch(rivalryRepositoryProvider).getRivalry(currentUserId, rivalId);
});

final headToHeadMatchesProvider = FutureProvider.family<List<CompetitiveMatch>, String>((ref, opponentId) async {
  final currentUserId = ref.watch(authRepositoryProvider).currentUserId;
  if (currentUserId == null) return [];

  return ref.watch(matchHistoryRepositoryProvider).getHeadToHeadMatches(currentUserId, opponentId);
});
