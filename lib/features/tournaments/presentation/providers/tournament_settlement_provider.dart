import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/models/tournament_settlement.dart';
import '../../data/repositories/tournament_repository_provider.dart';
import '../providers/tournament_details_provider.dart';
import '../../logic/tournament_settlement_engine.dart';

class TournamentSettlementNotifier
    extends StateNotifier<AsyncValue<TournamentSettlement?>> {
  final Ref ref;

  TournamentSettlementNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> finalizeTournament(String tournamentId) async {
    state = const AsyncValue.loading();

    try {
      final repository = ref.read(tournamentRepositoryProvider);

      // 1. Fetch Tournament metadata
      final tournament = await ref
          .read(tournamentRepositoryProvider)
          .getTournament(tournamentId);
      if (tournament == null) throw Exception('Tournament not found');

      // 2. Generate Rankings (this also persists to leaderboard sub-collection)
      final rankings = await repository.generateLeaderboard(tournamentId);

      // 3. Distribute Prizes
      final rankingsWithPrizes = TournamentSettlementEngine.distributePrizes(
        tournament,
        rankings,
      );
      await repository.distributeTournamentPrizes(
        tournamentId,
        rankingsWithPrizes,
      );

      // 4. Archive Tournament
      await repository.archiveTournament(tournamentId);

      final settlement = TournamentSettlement(
        tournamentId: tournamentId,
        status: TournamentSettlementStatus.completed,
        timestamp: DateTime.now(),
        totalParticipants: rankings.length,
        prizesDistributed: rankingsWithPrizes
            .where((r) => r.prize != null && !r.prize!.isEmpty)
            .length,
      );

      state = AsyncValue.data(settlement);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final tournamentSettlementProvider =
    StateNotifierProvider<
      TournamentSettlementNotifier,
      AsyncValue<TournamentSettlement?>
    >((ref) {
      return TournamentSettlementNotifier(ref);
    });
