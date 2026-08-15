import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
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

final activeChallengesProvider = StreamProvider<List<CompetitiveChallenge>>((ref) {
  final userId = ref.watch(authRepositoryProvider).currentUserId;
  if (userId == null) return Stream.value([]);
  return ref.watch(challengeRepositoryProvider).watchActiveChallenges(userId);
});

final challengeHistoryProvider = FutureProvider<List<CompetitiveChallenge>>((ref) async {
  final currentUserId = ref.watch(authRepositoryProvider).currentUserId;
  if (currentUserId == null) return [];
  return ref.watch(challengeRepositoryProvider).getChallengeHistory(currentUserId);
});

class ChallengeController extends StateNotifier<AsyncValue<void>> {
  ChallengeController(this.ref) : super(const AsyncValue.data(null));

  final Ref ref;

  Future<void> sendChallenge({
    required String challengedPlayerId,
    required ChallengeType type,
    required double target,
    required Duration duration,
    Map<String, dynamic> configuration = const {},
  }) async {
    state = const AsyncValue.loading();
    try {
      final challengerId = ref.read(authRepositoryProvider).currentUserId;
      if (challengerId == null) throw Exception('User not authenticated');
      if (challengerId == challengedPlayerId) throw Exception('You cannot challenge yourself');

      final challenge = CompetitiveChallenge(
        challengeId: const Uuid().v4(),
        challengerId: challengerId,
        challengedPlayerId: challengedPlayerId,
        type: type,
        target: target,
        status: ChallengeStatus.pending,
        createdAt: DateTime.now(),
        expiresAt: DateTime.now().add(duration),
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
