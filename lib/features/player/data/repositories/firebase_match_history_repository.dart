import 'package:soteria/features/player/domain/models/competitive_match.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import 'package:soteria/features/player/domain/repositories/match_history_repository.dart';
import 'package:soteria/features/player/domain/repositories/competitive_result_repository.dart';
import 'package:soteria/features/player/domain/repositories/rank_history_repository.dart';
import 'package:soteria/features/quiz/domain/repositories/quiz_history_repository.dart';

class FirebaseMatchHistoryRepository implements MatchHistoryRepository {
  final CompetitiveResultRepository _resultRepository;
  final RankHistoryRepository _rankRepository;
  final QuizHistoryRepository _quizRepository;

  FirebaseMatchHistoryRepository({
    required CompetitiveResultRepository resultRepository,
    required RankHistoryRepository rankRepository,
    required QuizHistoryRepository quizRepository,
  }) : _resultRepository = resultRepository,
       _rankRepository = rankRepository,
       _quizRepository = quizRepository;

  @override
  Future<List<CompetitiveMatch>> getMatchHistory(
    String userId, {
    int limit = 20,
    CompetitiveMatch? lastMatch,
    String? seasonId,
    String? mode,
    CompetitiveOutcome? outcome,
  }) async {
    final results = await _resultRepository.getResults(
      userId,
      limit: limit,
      lastResult: lastMatch?.result,
      seasonId: seasonId,
      mode: mode,
      outcome: outcome,
    );

    if (results.isEmpty) return [];

    // Fetch RankChanges for these results.
    // We fetch a bit more than limit to increase chances of finding all related changes.
    final rankChanges = await _rankRepository.getRankHistory(
      userId,
      limit: limit * 2,
    );
    final rankChangesMap = {
      for (var rc in rankChanges)
        if (rc.referenceResultId != null) rc.referenceResultId!: rc,
    };

    // Fetch QuizResults. Since we don't have batch get, we do parallel requests.
    // In production, we'd want a batch get in QuizHistoryRepository.
    final matches = await Future.wait(
      results.map((result) async {
        final quizResult = await _quizRepository.getResult(result.resultId);

        return CompetitiveMatch(
          result: result,
          rankChange: rankChangesMap[result.resultId],
          quizResult: quizResult,
        );
      }),
    );

    return matches;
  }

  @override
  Future<CompetitiveMatch?> getMatchDetail(
    String userId,
    String resultId,
  ) async {
    final result = await _resultRepository
        .getResults(userId, limit: 1)
        .then(
          (results) => results.firstWhere(
            (r) => r.resultId == resultId,
            orElse: () => null as dynamic,
          ),
        )
        .catchError((_) => null);

    if (result == null) return null;

    final rankChange = await _rankRepository
        .getRankHistory(userId, limit: 50)
        .then(
          (history) => history.firstWhere(
            (rc) => rc.referenceResultId == resultId,
            orElse: () => null as dynamic,
          ),
        )
        .catchError((_) => null);

    final quizResult = await _quizRepository.getResult(resultId);

    return CompetitiveMatch(
      result: result,
      rankChange: rankChange,
      quizResult: quizResult,
    );
  }

  @override
  Future<List<CompetitiveMatch>> getHeadToHeadMatches(
    String userId,
    String opponentId, {
    int limit = 50,
  }) async {
    final results = await _resultRepository.getResults(
      userId,
      limit: limit,
      opponentId: opponentId,
    );

    if (results.isEmpty) return [];

    // For H2H, we might not always need full rank change details, but let's be consistent.
    final rankChanges = await _rankRepository.getRankHistory(userId, limit: limit * 2);
    final rankChangesMap = {
      for (var rc in rankChanges)
        if (rc.referenceResultId != null) rc.referenceResultId!: rc,
    };

    final matches = await Future.wait(
      results.map((result) async {
        final quizResult = await _quizRepository.getResult(result.resultId);
        return CompetitiveMatch(
          result: result,
          rankChange: rankChangesMap[result.resultId],
          quizResult: quizResult,
        );
      }),
    );

    return matches;
  }
}
