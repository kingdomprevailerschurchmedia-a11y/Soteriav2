import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/tournaments/logic/tournament_settlement_engine.dart';
import 'package:soteria/features/tournaments/domain/models/tournament_raw_result.dart';

void main() {
  group('TournamentSettlementEngine Ranking Algorithm', () {
    final now = DateTime.now();

    test('should rank by score descending', () {
      final results = [
        TournamentRawResult(
          uid: 'p1',
          displayName: 'P1',
          photoUrl: '',
          score: 1000,
          accuracy: 0.8,
          completionTime: const Duration(minutes: 5),
          completionTimestamp: now,
        ),
        TournamentRawResult(
          uid: 'p2',
          displayName: 'P2',
          photoUrl: '',
          score: 2000,
          accuracy: 0.8,
          completionTime: const Duration(minutes: 5),
          completionTimestamp: now,
        ),
      ];

      final rankings = TournamentSettlementEngine.calculateFinalRanking(
        results,
      );

      expect(rankings[0].uid, 'p2');
      expect(rankings[0].rank, 1);
      expect(rankings[1].uid, 'p1');
      expect(rankings[1].rank, 2);
    });

    test('should rank by accuracy if scores are equal', () {
      final results = [
        TournamentRawResult(
          uid: 'p1',
          displayName: 'P1',
          photoUrl: '',
          score: 1000,
          accuracy: 0.9,
          completionTime: const Duration(minutes: 5),
          completionTimestamp: now,
        ),
        TournamentRawResult(
          uid: 'p2',
          displayName: 'P2',
          photoUrl: '',
          score: 1000,
          accuracy: 0.8,
          completionTime: const Duration(minutes: 5),
          completionTimestamp: now,
        ),
      ];

      final rankings = TournamentSettlementEngine.calculateFinalRanking(
        results,
      );

      expect(rankings[0].uid, 'p1');
      expect(rankings[1].uid, 'p2');
    });

    test('should rank by completion time if scores and accuracy are equal', () {
      final results = [
        TournamentRawResult(
          uid: 'p1',
          displayName: 'P1',
          photoUrl: '',
          score: 1000,
          accuracy: 0.9,
          completionTime: const Duration(minutes: 4),
          completionTimestamp: now,
        ),
        TournamentRawResult(
          uid: 'p2',
          displayName: 'P2',
          photoUrl: '',
          score: 1000,
          accuracy: 0.9,
          completionTime: const Duration(minutes: 5),
          completionTimestamp: now,
        ),
      ];

      final rankings = TournamentSettlementEngine.calculateFinalRanking(
        results,
      );

      expect(rankings[0].uid, 'p1');
      expect(rankings[1].uid, 'p2');
    });

    test(
      'should rank by completion timestamp if all else equal (tie-breaker)',
      () {
        final results = [
          TournamentRawResult(
            uid: 'p1',
            displayName: 'P1',
            photoUrl: '',
            score: 1000,
            accuracy: 0.9,
            completionTime: const Duration(minutes: 5),
            completionTimestamp: now,
          ),
          TournamentRawResult(
            uid: 'p2',
            displayName: 'P2',
            photoUrl: '',
            score: 1000,
            accuracy: 0.9,
            completionTime: const Duration(minutes: 5),
            completionTimestamp: now.subtract(const Duration(minutes: 1)),
          ),
        ];

        final rankings = TournamentSettlementEngine.calculateFinalRanking(
          results,
        );

        expect(rankings[0].uid, 'p2');
        expect(rankings[1].uid, 'p1');
      },
    );
  });
}
