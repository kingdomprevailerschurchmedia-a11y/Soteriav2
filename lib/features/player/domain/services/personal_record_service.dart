import 'package:uuid/uuid.dart';
import '../models/competitive_personal_record.dart';
import '../models/competitive_match.dart';
import '../models/competitive_streak.dart';
import '../models/player_progression.dart';
import '../repositories/personal_record_repository.dart';

class PersonalRecordService {
  final PersonalRecordRepository _repository;
  final _uuid = const Uuid();

  PersonalRecordService(this._repository);

  /// Evaluates a match result against current personal records.
  Future<void> evaluateMatch(CompetitiveMatch match) async {
    final result = match.result;
    final userId = result.userId;

    final currentRecords = await _repository.getCareerRecords(userId);

    // 1. Highest Score
    await _checkAndUpdate(
      userId: userId,
      type: CompetitiveRecordType.highestScore,
      value: result.score.toDouble(),
      displayValue: result.score.toString(),
      matchId: result.resultId,
      seasonId: result.seasonId,
      achievedAt: result.completedAt,
      currentRecords: currentRecords,
    );

    // 2. Best Accuracy
    if (match.quizResult != null) {
      await _checkAndUpdate(
        userId: userId,
        type: CompetitiveRecordType.bestAccuracy,
        value: match.quizResult!.accuracy,
        displayValue: '${(match.quizResult!.accuracy * 100).toStringAsFixed(1)}%',
        matchId: result.resultId,
        seasonId: result.seasonId,
        achievedAt: result.completedAt,
        currentRecords: currentRecords,
      );
    }

    // 3. Most Rank Points Gained
    if (match.rankChange != null && match.rankChange!.changeAmount > 0) {
      await _checkAndUpdate(
        userId: userId,
        type: CompetitiveRecordType.mostRankPointsGained,
        value: match.rankChange!.changeAmount.toDouble(),
        displayValue: '+${match.rankChange!.changeAmount}',
        matchId: result.resultId,
        seasonId: result.seasonId,
        achievedAt: result.completedAt,
        currentRecords: currentRecords,
      );
    }

    // 4. Best Mode Score
    await _checkAndUpdate(
      userId: userId,
      type: CompetitiveRecordType.bestModeScore,
      value: result.score.toDouble(),
      displayValue: result.score.toString(),
      matchId: result.resultId,
      seasonId: result.seasonId,
      mode: result.mode,
      achievedAt: result.completedAt,
      currentRecords: currentRecords,
      modeSpecific: true,
    );
  }

  /// Evaluates a win streak against personal records.
  Future<void> evaluateStreak(CompetitiveStreak streak) async {
    final userId = streak.userId;
    final currentRecords = await _repository.getCareerRecords(userId);

    await _checkAndUpdate(
      userId: userId,
      type: CompetitiveRecordType.longestWinStreak,
      value: streak.best.toDouble(),
      displayValue: streak.best.toString(),
      seasonId: streak.seasonId,
      achievedAt: streak.updatedAt,
      currentRecords: currentRecords,
    );
  }

  /// Evaluates rank and leaderboard position.
  Future<void> evaluateProgression({
    required String userId,
    required PlayerProgression progression,
    required int globalPosition,
    String? seasonId,
  }) async {
    final currentRecords = await _repository.getCareerRecords(userId);

    // Best Rank Reached
    await _checkAndUpdate(
      userId: userId,
      type: CompetitiveRecordType.bestRankReached,
      value: progression.rankPoints.toDouble(),
      displayValue: progression.currentRank,
      seasonId: seasonId,
      achievedAt: DateTime.now(),
      currentRecords: currentRecords,
    );

    // Best Leaderboard Position
    if (globalPosition > 0) {
      await _checkAndUpdate(
        userId: userId,
        type: CompetitiveRecordType.bestLeaderboardPosition,
        value: globalPosition.toDouble(),
        displayValue: '#$globalPosition',
        seasonId: seasonId,
        achievedAt: DateTime.now(), // Progression updates are current
        currentRecords: currentRecords,
      );
    }
  }

  Future<void> _checkAndUpdate({
    required String userId,
    required CompetitiveRecordType type,
    required double value,
    required String displayValue,
    String? matchId,
    String? seasonId,
    String? mode,
    required DateTime achievedAt,
    required List<CompetitivePersonalRecord> currentRecords,
    bool modeSpecific = false,
  }) async {
    // Find existing career record of this type (and mode if applicable)
    final existing = _findRecord(currentRecords, type, modeSpecific ? mode : null, true);

    if (_isBetter(type, value, existing?.value)) {
      // Idempotency: Don't update if this match/event was already recorded for this specific record
      if (matchId != null && existing?.matchId == matchId) return;

      // Out-of-order check
      if (existing != null && 
          achievedAt.isBefore(existing.achievedAt) && 
          !_isBetter(type, value, existing.value)) {
        return;
      }

      final newRecord = CompetitivePersonalRecord(
        id: _uuid.v4(),
        userId: userId,
        type: type,
        value: value,
        displayValue: displayValue,
        matchId: matchId,
        seasonId: seasonId,
        mode: mode,
        achievedAt: achievedAt,
        previousValue: existing?.value,
        isCareerRecord: true,
      );

      await _repository.updateRecord(newRecord);
    }
  }

  CompetitivePersonalRecord? _findRecord(
    List<CompetitivePersonalRecord> records,
    CompetitiveRecordType type,
    String? mode,
    bool isCareer,
  ) {
    try {
      return records.firstWhere(
        (r) => r.type == type && r.mode == mode && r.isCareerRecord == isCareer,
      );
    } catch (_) {
      return null;
    }
  }

  bool _isBetter(CompetitiveRecordType type, double newValue, double? oldValue) {
    if (oldValue == null) return true;

    switch (type) {
      case CompetitiveRecordType.bestLeaderboardPosition:
      case CompetitiveRecordType.bestSeasonPosition:
        // Lower is better (e.g., 1st is better than 10th)
        return newValue < oldValue;
      default:
        // Higher is better
        return newValue > oldValue;
    }
  }
}
