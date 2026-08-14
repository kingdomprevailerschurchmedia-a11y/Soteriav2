import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';
import 'package:soteria/features/social/presentation/providers/social_providers.dart';
import 'package:soteria/features/player/domain/models/player_presence.dart';
import 'package:soteria/features/player/domain/repositories/presence_repository.dart';
import 'package:soteria/features/player/data/repositories/firebase_presence_repository.dart';

final presenceRepositoryProvider = Provider<PresenceRepository>((ref) {
  return FirebasePresenceRepository(ref.watch(firestoreProvider));
});

final playerPresenceProvider = StreamProvider.family<PlayerPresence?, String>((ref, userId) {
  return ref.watch(presenceRepositoryProvider).watchPresence(userId);
});

final socialPresenceProvider = StreamProvider<Map<String, PlayerPresence>>((ref) {
  final friendsAsync = ref.watch(friendsProvider);
  
  return friendsAsync.when(
    data: (friends) {
      if (friends.isEmpty) return Stream.value({});
      final currentUserId = ref.watch(authRepositoryProvider).currentUserId ?? '';
      final friendIds = friends.map((f) {
        return f.userIds.firstWhere((id) => id != currentUserId, orElse: () => '');
      }).where((id) => id.isNotEmpty).toList();
      return ref.watch(presenceRepositoryProvider).watchPresenceMultiple(friendIds.cast<String>());
    },
    loading: () => Stream.value({}),
    error: (_, __) => Stream.value({}),
  );
});

final currentPresenceProvider = StreamProvider<PlayerPresence?>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value(null);
  return ref.watch(presenceRepositoryProvider).watchPresence(userId);
});
