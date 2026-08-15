import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/models/friendship.dart';
import '../../domain/models/friend_request.dart';
import '../../domain/models/follow.dart';
import '../../domain/models/relationship_status.dart';
import '../../domain/repositories/social_repository.dart';
import '../../data/repositories/firebase_social_repository.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import 'package:soteria/features/auth/providers/auth_providers.dart';

final socialRepositoryProvider = Provider<SocialRepository>((ref) {
  return FirebaseSocialRepository(ref.watch(firestoreProvider));
});

final incomingRequestsProvider = StreamProvider<List<FriendRequest>>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);
  return ref.watch(socialRepositoryProvider).observeIncomingRequests(userId);
});

final outgoingRequestsProvider = StreamProvider<List<FriendRequest>>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);
  return ref.watch(socialRepositoryProvider).observeOutgoingRequests(userId);
});

final friendsProvider = StreamProvider<List<Friendship>>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);
  return ref.watch(socialRepositoryProvider).observeFriends(userId);
});

final relationshipStatusProvider = FutureProvider.family<RelationshipStatus, String>((ref, otherUserId) async {
  final currentUserId = ref.watch(authRepositoryProvider).currentUserId;
  if (currentUserId == null) return RelationshipStatus.none;
  if (currentUserId == otherUserId) return RelationshipStatus.none;

  return ref.watch(socialRepositoryProvider).getRelationshipStatus(currentUserId, otherUserId);
});

class SocialController extends StateNotifier<AsyncValue<void>> {
  SocialController(this.ref) : super(const AsyncValue.data(null));

  final Ref ref;

  Future<void> sendRequest(String receiverId) async {
    state = const AsyncValue.loading();
    try {
      final senderId = ref.read(authRepositoryProvider).currentUserId;
      if (senderId == null) throw Exception('Not authenticated');
      await ref.read(socialRepositoryProvider).sendFriendRequest(senderId, receiverId);
      ref.invalidate(relationshipStatusProvider(receiverId));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> acceptRequest(String requestId, String otherUserId) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(socialRepositoryProvider).acceptFriendRequest(requestId);
      ref.invalidate(relationshipStatusProvider(otherUserId));
      ref.invalidate(friendsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> declineRequest(String requestId, String otherUserId) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(socialRepositoryProvider).declineFriendRequest(requestId);
      ref.invalidate(relationshipStatusProvider(otherUserId));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> removeFriend(String otherUserId) async {
    state = const AsyncValue.loading();
    try {
      final currentUserId = ref.read(authRepositoryProvider).currentUserId;
      if (currentUserId == null) throw Exception('Not authenticated');
      await ref.read(socialRepositoryProvider).removeFriend(currentUserId, otherUserId);
      ref.invalidate(relationshipStatusProvider(otherUserId));
      ref.invalidate(friendsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final socialControllerProvider = StateNotifierProvider<SocialController, AsyncValue<void>>((ref) {
  return SocialController(ref);
});
