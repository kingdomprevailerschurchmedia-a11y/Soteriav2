import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/models/competitive_identity.dart';
import '../../domain/models/competitive_title.dart';
import '../../domain/models/competitive_badge.dart';
import '../../domain/models/rank_progress.dart';
import '../../domain/repositories/identity_repository.dart';
import '../../data/repositories/firebase_identity_repository.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import '../../domain/repositories/player_repository.dart';
import 'progression_providers.dart';
import 'rank_providers.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../providers/player_providers.dart';

final identityRepositoryProvider = Provider<IdentityRepository>((ref) {
  return FirebaseIdentityRepository(ref.watch(firestoreProvider));
});

final titleDefinitionsProvider = FutureProvider<List<CompetitiveTitle>>((ref) {
  return ref.watch(identityRepositoryProvider).getTitleDefinitions();
});

final badgeDefinitionsProvider = FutureProvider<List<CompetitiveBadge>>((ref) {
  return ref.watch(identityRepositoryProvider).getBadgeDefinitions();
});

final competitiveIdentityProvider = FutureProvider<CompetitiveIdentity?>((ref) async {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return null;

  final profile = await ref.watch(currentPlayerStreamProvider.future);
  if (profile == null) return null;

  final progression = await ref.watch(competitiveProgressionProvider.future);
  final rankProgressAsync = ref.watch(rankProgressProvider);
  
  if (rankProgressAsync is! AsyncData<RankProgress>) return null;
  final rankProgress = rankProgressAsync.value;

  final titles = await ref.watch(titleDefinitionsProvider.future);
  final badges = await ref.watch(badgeDefinitionsProvider.future);

  final equippedTitle = profile.equippedTitleId != null
      ? titles.where((t) => t.id == profile.equippedTitleId).firstOrNull
      : null;

  final featuredBadges = badges
      .where((b) => profile.featuredBadgeIds.contains(b.id))
      .toList();

  final allOwnedBadges = badges
      .where((b) => profile.badges.contains(b.id))
      .toList();

  final allOwnedTitles = titles
      .where((t) => profile.achievements.contains(t.id)) 
      .toList();

  return CompetitiveIdentity(
    userId: userId,
    profile: profile,
    progression: progression,
    rankProgress: rankProgress,
    equippedTitle: equippedTitle,
    featuredBadges: featuredBadges,
    allOwnedBadges: allOwnedBadges,
    allOwnedTitles: allOwnedTitles,
  );
});

class CompetitiveIdentityController extends StateNotifier<AsyncValue<void>> {
  CompetitiveIdentityController(this.ref) : super(const AsyncValue.data(null));

  final Ref ref;

  Future<void> equipTitle(String? titleId) async {
    state = const AsyncValue.loading();
    try {
      final profile = await ref.read(currentPlayerStreamProvider.future);
      if (profile == null) throw Exception('Profile not found');

      final updatedProfile = profile.copyWith(equippedTitleId: titleId);
      await ref.read(playerRepositoryProvider).updatePlayerProfile(updatedProfile);
      
      ref.invalidate(competitiveIdentityProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateFeaturedBadges(List<String> badgeIds) async {
    if (badgeIds.length > 5) throw Exception('Maximum 5 featured badges allowed');
    
    state = const AsyncValue.loading();
    try {
      final profile = await ref.read(currentPlayerStreamProvider.future);
      if (profile == null) throw Exception('Profile not found');

      final updatedProfile = profile.copyWith(featuredBadgeIds: badgeIds);
      await ref.read(playerRepositoryProvider).updatePlayerProfile(updatedProfile);
      
      ref.invalidate(competitiveIdentityProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final competitiveIdentityControllerProvider =
    StateNotifierProvider<CompetitiveIdentityController, AsyncValue<void>>((ref) {
  return CompetitiveIdentityController(ref);
});
