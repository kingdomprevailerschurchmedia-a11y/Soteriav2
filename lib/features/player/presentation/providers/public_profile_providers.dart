import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/models/public_competitive_profile.dart';
import 'identity_providers.dart';

final publicProfileProvider = FutureProvider.family<PublicCompetitiveProfile?, String>((ref, userId) async {
  final repository = ref.watch(identityRepositoryProvider);
  return repository.getPublicProfile(userId);
});

final playerSearchQueryProvider = StateProvider<String>((ref) => '');

final playerSearchProvider = FutureProvider<List<PublicCompetitiveProfile>>((ref) async {
  final query = ref.watch(playerSearchQueryProvider);
  if (query.isEmpty) return [];
  
  // Debounce logic can be handled by the UI or by using a timer here if needed
  // For now, let's assume the UI handles debouncing or we do it simply
  
  final repository = ref.watch(identityRepositoryProvider);
  return repository.searchPlayers(query);
});
