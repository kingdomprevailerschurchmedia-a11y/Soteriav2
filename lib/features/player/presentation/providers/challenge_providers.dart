import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/competitive_challenge.dart';
import '../../domain/repositories/challenge_repository.dart';
import '../../data/repositories/firebase_challenge_repository.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import '../../../auth/providers/auth_providers.dart';
import 'package:uuid/uuid.dart';

final challengeRepositoryProvider = Provider<ChallengeRepository>((ref) {
  return FirebaseChallengeRepository(ref.watch(firestoreProvider));
});

final incomingChallengesProvider = StreamProvider<List<CompetitiveChallenge>>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);
  return ref.watch(challengeRepositoryProvider).watchIncomingChallenges(userId);
});

final outgoingChallengesProvider = StreamProvider<List<CompetitiveChallenge>>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);
  return ref.watch(challengeRepositoryProvider).watchOutgoingChallenges(userId);
});

class ChallengeController extends StateNotifier<AsyncValue<void>> {
  ChallengeController(this.ref) : super(const AsyncValue.data(null));

  final Ref ref;

  Future<void> sendChallenge({
    required String challengedPlayerId,
    required Map<String, dynamic> configuration,
  }) async {
    state = const AsyncValue.loading();
    try {
      final challengerId = ref.read(authRepositoryProvider).currentUserId;
      if (challengerId == null) throw Exception('User not authenticated');

      final challenge = CompetitiveChallenge(
        challengeId: const Uuid().v4(),
        challengerId: challengerId,
        challengedPlayerId: challengedPlayerId,
        status: ChallengeStatus.pending,
        createdAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(hours: 24)),
        configuration: configuration,
      );

      await ref.read(challengeRepositoryProvider).sendChallenge(challenge);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> acceptChallenge(String challengeId) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(challengeRepositoryProvider).acceptChallenge(challengeId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> declineChallenge(String challengeId) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(challengeRepositoryProvider).declineChallenge(challengeId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> cancelChallenge(String challengeId) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(challengeRepositoryProvider).cancelChallenge(challengeId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final challengeControllerProvider =
    StateNotifierProvider<ChallengeController, AsyncValue<void>>((ref) {
  return ChallengeController(ref);
});
