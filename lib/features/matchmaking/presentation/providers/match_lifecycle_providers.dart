import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import '../../../gameplay_engine/models/versus_match.dart';
import '../../domain/repositories/versus_match_repository.dart';
import '../../data/repositories/firebase_versus_match_repository.dart';
import '../../../auth/providers/auth_providers.dart';
import '../../../quiz/presentation/providers/quiz_providers.dart';

final versusMatchRepositoryProvider = Provider<VersusMatchRepository>((ref) {
  return FirebaseVersusMatchRepository(ref.watch(firestoreProvider));
});

final activeMatchIdProvider = StateProvider<String?>((ref) => null);

final activeMatchProvider = StreamProvider<VersusMatch?>((ref) {
  final matchId = ref.watch(activeMatchIdProvider);
  if (matchId == null) return Stream.value(null);

  return ref.watch(versusMatchRepositoryProvider).observeMatch(matchId);
});

class MatchLifecycleNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> setReady() async {
    final matchId = ref.read(activeMatchIdProvider);
    final userId = ref.read(authRepositoryProvider).currentUserId;
    if (matchId == null || userId == null) return;

    await ref.read(versusMatchRepositoryProvider).setReady(matchId, userId);
  }

  Future<void> abandon() async {
    final matchId = ref.read(activeMatchIdProvider);
    final userId = ref.read(authRepositoryProvider).currentUserId;
    if (matchId == null || userId == null) return;

    await ref.read(versusMatchRepositoryProvider).abandonMatch(matchId, userId);
  }

  Future<void> complete() async {
    final matchId = ref.read(activeMatchIdProvider);
    final userId = ref.read(authRepositoryProvider).currentUserId;
    if (matchId == null || userId == null) return;

    await ref.read(versusMatchRepositoryProvider).completeMatch(matchId, userId);
  }
}

final matchLifecycleControllerProvider =
    AutoDisposeAsyncNotifierProvider<MatchLifecycleNotifier, void>(
  MatchLifecycleNotifier.new,
);

final matchCountdownProvider = StreamProvider.autoDispose<int>((ref) {
  final match = ref.watch(activeMatchProvider).value;
  if (match == null || match.status != MatchStatus.countdown) {
    return Stream.value(0);
  }

  // Simplified countdown from 3
  return Stream.periodic(const Duration(seconds: 1), (count) => 3 - count)
      .take(4);
});

final versusProgressSyncProvider = Provider.autoDispose<void>((ref) {
  final matchId = ref.watch(activeMatchIdProvider);
  if (matchId == null) return;

  final userId = ref.read(authRepositoryProvider).currentUserId;
  if (userId == null) return;

  final repository = ref.read(versusMatchRepositoryProvider);

  // Sync Score
  ref.listen(quizControllerProvider.select((s) => s.score), (prev, next) {
    repository.updateScore(matchId, userId, next);
  });

  // Sync Progress
  ref.listen(quizControllerProvider.select((s) => s.currentIndex), (prev, next) {
    repository.updateProgress(matchId, userId, next);
  });

  // Handle Completion
  ref.listen(quizControllerProvider.select((s) => s.status), (prev, next) {
    if (next == QuizStatus.completed) {
      repository.completeMatch(matchId, userId);
    }
  });
});
