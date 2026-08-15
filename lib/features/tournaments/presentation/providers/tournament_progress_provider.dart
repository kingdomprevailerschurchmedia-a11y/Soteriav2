import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'tournament_gameplay_provider.dart';

class TournamentProgress {
  final int currentQuestion;
  final int totalQuestions;
  final int score;
  final double completionPercentage;

  TournamentProgress({
    required this.currentQuestion,
    required this.totalQuestions,
    required this.score,
    required this.completionPercentage,
  });
}

final tournamentProgressProvider = Provider.family<TournamentProgress, String>((
  ref,
  tournamentId,
) {
  final config = ref.watch(tournamentConfigProvider(tournamentId));
  final gameState = ref.watch(gameEngineProvider(config));

  return TournamentProgress(
    currentQuestion: gameState.currentQuestionIndex + 1,
    totalQuestions: gameState.questions.length,
    score: gameState.score,
    completionPercentage: gameState.questions.isEmpty
        ? 0
        : (gameState.currentQuestionIndex / gameState.questions.length),
  );
});
