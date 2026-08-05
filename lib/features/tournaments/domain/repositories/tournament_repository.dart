import '../models/tournament.dart';
import '../models/tournament_participant.dart';
import '../models/tournament_ranking.dart';

abstract class TournamentRepository {
  Future<List<Tournament>> getTournaments();
  Stream<List<Tournament>> watchTournaments();
  Future<Tournament?> getTournament(String id);
  Stream<Tournament?> watchTournament(String id);
  Future<void> registerForTournament(
    String tournamentId,
    String uid,
    String displayName,
    String photoUrl,
  );
  Future<void> unregisterFromTournament(String tournamentId, String uid);
  Future<bool> isUserRegistered(String tournamentId, String uid);
  Future<List<TournamentParticipant>> getParticipants(String tournamentId);

  // Gameplay
  Future<void> startTournamentSession(String tournamentId, String uid);
  Future<void> submitTournamentAnswer(
    String tournamentId,
    String uid,
    String questionId,
    List<String> answerIds,
    Duration responseTime,
  );
  Future<void> checkpointTournamentProgress(
    String tournamentId,
    String uid,
    int questionIndex,
    int score,
  );
  Future<void> completeTournamentSession(
    String tournamentId,
    String uid,
    int finalScore,
  );

  // Settlement & Leaderboards
  Future<List<TournamentRanking>> generateLeaderboard(String tournamentId);
  Future<void> distributeTournamentPrizes(
    String tournamentId,
    List<TournamentRanking> rankings,
  );
  Future<void> archiveTournament(String tournamentId);
  Future<TournamentRanking?> getPlayerRanking(String tournamentId, String uid);
}
