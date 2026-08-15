import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import '../../data/repositories/tournament_repository_provider.dart';

class TournamentRegistrationNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  TournamentRegistrationNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> register(String tournamentId) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(tournamentRepositoryProvider);
      final user = ref.read(firebaseAuthServiceProvider).currentUser;

      if (user == null) throw Exception('User must be logged in');

      await repository.registerForTournament(
        tournamentId,
        user.uid,
        user.displayName ?? 'Anonymous',
        user.photoURL ?? '',
      );
      ref.invalidate(isRegisteredForTournamentProvider(tournamentId));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> unregister(String tournamentId) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(tournamentRepositoryProvider);
      final user = ref.read(firebaseAuthServiceProvider).currentUser;

      if (user == null) throw Exception('User must be logged in');

      await repository.unregisterFromTournament(tournamentId, user.uid);
      ref.invalidate(isRegisteredForTournamentProvider(tournamentId));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleRegistration(
    String tournamentId,
    bool currentlyRegistered,
  ) async {
    if (currentlyRegistered) {
      await unregister(tournamentId);
    } else {
      await register(tournamentId);
    }
  }
}

final tournamentRegistrationProvider =
    StateNotifierProvider.autoDispose<
      TournamentRegistrationNotifier,
      AsyncValue<void>
    >((ref) {
      return TournamentRegistrationNotifier(ref);
    });

final isRegisteredForTournamentProvider = FutureProvider.family<bool, String>((
  ref,
  tournamentId,
) async {
  final repository = ref.watch(tournamentRepositoryProvider);
  final user = ref.watch(firebaseAuthServiceProvider).currentUser;

  if (user == null) return false;

  return repository.isUserRegistered(tournamentId, user.uid);
});
