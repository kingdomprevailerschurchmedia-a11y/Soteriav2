import '../models/competitive_match.dart';
import '../models/competitive_result.dart';
import '../repositories/match_history_repository.dart';

class FetchMatchHistoryUseCase {
  final MatchHistoryRepository _repository;

  FetchMatchHistoryUseCase(this._repository);

  Future<List<CompetitiveMatch>> execute(
    String userId, {
    int limit = 20,
    CompetitiveMatch? lastMatch,
    String? seasonId,
    String? mode,
    CompetitiveOutcome? outcome,
  }) async {
    return _repository.getMatchHistory(
      userId,
      limit: limit,
      lastMatch: lastMatch,
      seasonId: seasonId,
      mode: mode,
      outcome: outcome,
    );
  }
}
