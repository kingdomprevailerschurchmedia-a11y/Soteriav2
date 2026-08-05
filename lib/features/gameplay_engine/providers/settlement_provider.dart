import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/competitive_settlement.dart';
import '../models/game_result.dart';
import '../models/competitive_session.dart';
import '../domain/repositories/competitive_settlement_repository.dart';
import '../domain/repositories/competitive_stats_repository.dart';
import '../data/repositories/firestore_competitive_settlement_repository.dart';
import '../data/repositories/firestore_competitive_stats_repository.dart';
import '../../../core/firebase/providers/firebase_providers.dart';
import '../logic/competitive_settlement_engine.dart';

final competitiveSettlementRepositoryProvider =
    Provider<CompetitiveSettlementRepository>((ref) {
      return FirestoreCompetitiveSettlementRepository(
        ref.watch(firestoreDatabaseServiceProvider),
      );
    });

final competitiveStatsRepositoryProvider = Provider<CompetitiveStatsRepository>(
  (ref) {
    return FirestoreCompetitiveStatsRepository(
      ref.watch(firestoreDatabaseServiceProvider),
    );
  },
);

final settlementProvider =
    StateNotifierProvider<
      SettlementNotifier,
      AsyncValue<CompetitiveSettlement?>
    >((ref) {
      return SettlementNotifier(
        settlementRepo: ref.watch(competitiveSettlementRepositoryProvider),
        statsRepo: ref.watch(competitiveStatsRepositoryProvider),
        ref: ref,
      );
    });

class SettlementNotifier
    extends StateNotifier<AsyncValue<CompetitiveSettlement?>> {
  final CompetitiveSettlementRepository settlementRepo;
  final CompetitiveStatsRepository statsRepo;
  final Ref ref;

  SettlementNotifier({
    required this.settlementRepo,
    required this.statsRepo,
    required this.ref,
  }) : super(const AsyncValue.data(null));

  Future<void> finalizeSession({
    required CompetitiveSession session,
    required GameResult result,
    required String uid,
  }) async {
    state = const AsyncValue.loading();

    try {
      // 1. Validate
      if (!CompetitiveSettlementEngine.validateResult(session, result)) {
        throw Exception(
          'Competitive result validation failed. Integrity mismatch.',
        );
      }

      // 2. Calculate Rewards
      final rewards = CompetitiveSettlementEngine.calculateRewards(
        session: session,
        result: result,
      );

      // 3. Prepare Settlement
      final settlement = CompetitiveSettlement(
        settlementId: settlementRepo.generateSettlementId(),
        sessionId: session.sessionId,
        uid: uid,
        result: result,
        status: SettlementStatus.pending,
        coinsWagered: session.reservedFee,
        coinsWon: rewards.baseCoins,
        xpEarned: rewards.totalXP,
        timestamp: DateTime.now(),
      );

      // 4. Atomic Commit
      await settlementRepo.finalizeSettlement(settlement);

      // 5. Update Stats
      await statsRepo.updatePlayerStats(
        uid,
        result,
        rewards.baseCoins - session.reservedFee,
      );

      state = AsyncValue.data(
        settlement.copyWith(status: SettlementStatus.completed),
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      // Logic for offline retry could be added here
    }
  }
}
