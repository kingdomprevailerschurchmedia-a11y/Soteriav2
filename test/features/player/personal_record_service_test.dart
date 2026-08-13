import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/domain/models/competitive_personal_record.dart';
import 'package:soteria/features/player/domain/models/competitive_match.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import 'package:soteria/features/player/domain/models/competitive_streak.dart';
import 'package:soteria/features/player/domain/repositories/personal_record_repository.dart';
import 'package:soteria/features/player/domain/services/personal_record_service.dart';
import 'package:soteria/features/quiz/domain/models/quiz_result.dart';
import 'package:soteria/features/quiz/domain/models/quiz_enums.dart';

class ManualMockPersonalRecordRepository implements PersonalRecordRepository {
  List<CompetitivePersonalRecord> records = [];
  CompetitivePersonalRecord? lastUpdated;

  @override
  Future<List<CompetitivePersonalRecord>> getCareerRecords(String userId) async {
    return records.where((r) => r.isCareerRecord).toList();
  }

  @override
  Future<List<CompetitivePersonalRecord>> getSeasonRecords(String userId, String seasonId) async {
    return records.where((r) => r.seasonId == seasonId).toList();
  }

  @override
  Stream<List<CompetitivePersonalRecord>> watchPersonalRecords(String userId) {
    return Stream.value(records);
  }

  @override
  Future<void> updateRecord(CompetitivePersonalRecord record) async {
    lastUpdated = record;
    records.removeWhere((r) => r.type == record.type && r.mode == record.mode && r.isCareerRecord == record.isCareerRecord);
    records.add(record);
  }
}

void main() {
  late ManualMockPersonalRecordRepository mockRepo;
  late PersonalRecordService service;
  const userId = 'u1';

  setUp(() {
    mockRepo = ManualMockPersonalRecordRepository();
    service = PersonalRecordService(mockRepo);
  });

  group('PersonalRecordService - Match Evaluation', () {
    test('should create new record if none exists', () async {
      final match = CompetitiveMatch(
        result: CompetitiveResult(
          resultId: 'm1',
          userId: userId,
          seasonId: 's5',
          outcome: CompetitiveOutcome.win,
          mode: 'classic',
          score: 5000,
          completedAt: DateTime.now(),
        ),
      );

      await service.evaluateMatch(match);

      final scoreRecord = mockRepo.records.firstWhere((r) => r.type == CompetitiveRecordType.highestScore);
      expect(scoreRecord.value, 5000);
    });

    test('should update record if new score is higher', () async {
      mockRepo.records.add(CompetitivePersonalRecord(
        id: 'old',
        userId: userId,
        type: CompetitiveRecordType.highestScore,
        value: 4000,
        displayValue: '4000',
        achievedAt: DateTime.now().subtract(const Duration(days: 1)),
        isCareerRecord: true,
      ));

      final match = CompetitiveMatch(
        result: CompetitiveResult(
          resultId: 'm1',
          userId: userId,
          seasonId: 's5',
          outcome: CompetitiveOutcome.win,
          mode: 'classic',
          score: 5000,
          completedAt: DateTime.now(),
        ),
      );

      await service.evaluateMatch(match);

      final scoreRecord = mockRepo.records.firstWhere((r) => r.type == CompetitiveRecordType.highestScore);
      expect(scoreRecord.value, 5000);
      expect(scoreRecord.previousValue, 4000);
    });

    test('should NOT update record if new score is lower', () async {
      final initialRecord = CompetitivePersonalRecord(
        id: 'old',
        userId: userId,
        type: CompetitiveRecordType.highestScore,
        value: 6000,
        displayValue: '6000',
        achievedAt: DateTime.now().subtract(const Duration(days: 1)),
        isCareerRecord: true,
      );
      mockRepo.records.add(initialRecord);

      final match = CompetitiveMatch(
        result: CompetitiveResult(
          resultId: 'm1',
          userId: userId,
          seasonId: 's5',
          outcome: CompetitiveOutcome.win,
          mode: 'classic',
          score: 5000,
          completedAt: DateTime.now(),
        ),
      );

      await service.evaluateMatch(match);

      final scoreRecord = mockRepo.records.firstWhere((r) => r.type == CompetitiveRecordType.highestScore);
      expect(scoreRecord.value, 6000);
      expect(scoreRecord.id, 'old');
    });

    test('should handle accuracy records', () async {
      final match = CompetitiveMatch(
        result: CompetitiveResult(
          resultId: 'm1',
          userId: userId,
          seasonId: 's5',
          outcome: CompetitiveOutcome.win,
          mode: 'classic',
          score: 5000,
          completedAt: DateTime.now(),
        ),
        quizResult: QuizResult(
          sessionId: 'm1',
          playerId: userId,
          gameMode: GameMode.pro,
          category: 'All',
          difficulty: Difficulty.medium,
          totalQuestions: 10,
          answeredQuestions: 10,
          correctAnswers: 9,
          wrongAnswers: 1,
          skipped: 0,
          timedOut: 0,
          accuracy: 0.9,
          finalScore: 5000,
          xpEarned: 100,
          longestStreak: 5,
          finalStreak: 3,
          averageResponseTime: Duration.zero,
          fastestResponseTime: Duration.zero,
          slowestResponseTime: Duration.zero,
          questionResults: [],
          completedAt: DateTime.now(),
          completionTime: Duration.zero,
          performanceRating: 'Great',
        ),
      );

      await service.evaluateMatch(match);

      final accuracyRecord = mockRepo.records.firstWhere((r) => r.type == CompetitiveRecordType.bestAccuracy);
      expect(accuracyRecord.value, 0.9);
      expect(accuracyRecord.displayValue, '90.0%');
    });
  });

  group('PersonalRecordService - Streak Evaluation', () {
    test('should update longest win streak', () async {
      final streak = CompetitiveStreak(
        userId: userId,
        type: StreakType.win,
        current: 5,
        best: 10,
        seasonBest: 5,
        startedAt: DateTime.now(),
        lastQualifiedAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await service.evaluateStreak(streak);

      expect(mockRepo.lastUpdated!.type, CompetitiveRecordType.longestWinStreak);
      expect(mockRepo.lastUpdated!.value, 10);
    });
  });

  group('PersonalRecordService - Idempotency & Out-of-order', () {
    test('should not update if matchId is identical to existing record', () async {
      final initialRecord = CompetitivePersonalRecord(
        id: 'r1',
        userId: userId,
        type: CompetitiveRecordType.highestScore,
        value: 5000,
        displayValue: '5000',
        matchId: 'm1',
        achievedAt: DateTime.now().subtract(const Duration(minutes: 5)),
        isCareerRecord: true,
      );
      mockRepo.records.add(initialRecord);

      final match = CompetitiveMatch(
        result: CompetitiveResult(
          resultId: 'm1',
          userId: userId,
          seasonId: 's5',
          outcome: CompetitiveOutcome.win,
          mode: 'classic',
          score: 5000,
          completedAt: DateTime.now(),
        ),
      );

      await service.evaluateMatch(match);

      final scoreRecord = mockRepo.records.firstWhere((r) => r.type == CompetitiveRecordType.highestScore);
      expect(scoreRecord.id, 'r1');
    });

    test('should not update if existing record is newer AND better than incoming delayed result', () async {
      final now = DateTime.now();
      
      final initialRecord = CompetitivePersonalRecord(
        id: 'r1',
        userId: userId,
        type: CompetitiveRecordType.highestScore,
        value: 8000,
        displayValue: '8000',
        matchId: 'm2',
        achievedAt: now,
        isCareerRecord: true,
      );
      mockRepo.records.add(initialRecord);

      final delayedMatch = CompetitiveMatch(
        result: CompetitiveResult(
          resultId: 'm1',
          userId: userId,
          seasonId: 's5',
          outcome: CompetitiveOutcome.win,
          mode: 'classic',
          score: 7000,
          completedAt: now.subtract(const Duration(hours: 1)),
        ),
      );

      await service.evaluateMatch(delayedMatch);

      final scoreRecord = mockRepo.records.firstWhere((r) => r.type == CompetitiveRecordType.highestScore);
      expect(scoreRecord.value, 8000);
      expect(scoreRecord.id, 'r1');
    });
  });
}
