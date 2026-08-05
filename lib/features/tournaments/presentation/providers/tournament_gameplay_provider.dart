import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:soteria/core/firebase/providers/firebase_providers.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/question_content/presentation/providers/question_providers.dart';
import '../../domain/models/tournament_status.dart';
import 'tournament_realtime_provider.dart';
import '../../data/repositories/tournament_repository_provider.dart';

enum TournamentGameplayState { waiting, starting, playing, completed, error }

class TournamentGameplayNotifier
    extends StateNotifier<TournamentGameplayState> {
  final String tournamentId;
  final Ref ref;
  ProviderSubscription? _statusSubscription;

  TournamentGameplayNotifier({required this.tournamentId, required this.ref})
    : super(TournamentGameplayState.waiting) {
    _init();
  }

  void _init() {
    _statusSubscription = ref.listen(tournamentRealtimeProvider(tournamentId), (
      prev,
      next,
    ) {
      next.whenData((tournament) {
        if (tournament == null) return;

        if (tournament.status == TournamentStatus.live &&
            state == TournamentGameplayState.waiting) {
          _startTournament();
        } else if (tournament.status == TournamentStatus.completed) {
          state = TournamentGameplayState.completed;
        }
      });
    });
  }

  Future<void> _startTournament() async {
    state = TournamentGameplayState.starting;

    try {
      // 1. Fetch Questions for the tournament
      final questions = await ref
          .read(questionRepositoryProvider)
          .getQuestions();

      final user = ref.read(firebaseAuthProvider).currentUser;
      if (user == null) throw Exception('User not authenticated');

      // 2. Initialize the Game Engine with Tournament Config
      final config = GameConfiguration(
        mode: GameMode.tournament,
        questionCount: questions.length,
        initialLives: 3,
        allowLifelines: false,
        questionTimer: const Duration(seconds: 15),
        metadata: {'tournamentId': tournamentId},
      );

      // 3. Record session start in repository
      await ref
          .read(tournamentRepositoryProvider)
          .startTournamentSession(tournamentId, user.uid);

      // 4. Listen to Engine state for Checkpoints & Completion
      ref.listen(gameEngineProvider(config), (prev, next) {
        final previousIndex = prev?.currentQuestionIndex;
        if (next.currentQuestionIndex != previousIndex) {
          ref
              .read(tournamentRepositoryProvider)
              .checkpointTournamentProgress(
                tournamentId,
                user.uid,
                next.currentQuestionIndex,
                next.score,
              );
        }

        if (next.lifecycle.isEndState) {
          ref
              .read(tournamentRepositoryProvider)
              .completeTournamentSession(tournamentId, user.uid, next.score);
          state = TournamentGameplayState.completed;
        }
      });

      // 5. Start the engine
      await ref
          .read(gameEngineProvider(config).notifier)
          .startSession(questions);

      state = TournamentGameplayState.playing;
    } catch (e) {
      state = TournamentGameplayState.error;
    }
  }

  @override
  void dispose() {
    _statusSubscription?.close();
    super.dispose();
  }
}

final tournamentGameplayProvider =
    StateNotifierProvider.family<
      TournamentGameplayNotifier,
      TournamentGameplayState,
      String
    >((ref, id) {
      return TournamentGameplayNotifier(tournamentId: id, ref: ref);
    });
