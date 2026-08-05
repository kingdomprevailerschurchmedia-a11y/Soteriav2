import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_result.dart';
import '../models/competitive_settlement.dart';
import 'settlement_provider.dart';

final competitiveResultsProvider =
    Provider.family<CompetitiveResultsData, GameResult>((ref, result) {
      final settlementAsync = ref.watch(settlementProvider);

      return CompetitiveResultsData(
        result: result,
        settlement: settlementAsync.whenOrNull(data: (s) => s),
        isProcessing: settlementAsync.isLoading,
        error: settlementAsync.whenOrNull(error: (e, _) => e.toString()),
      );
    });

class CompetitiveResultsData {
  final GameResult result;
  final CompetitiveSettlement? settlement;
  final bool isProcessing;
  final String? error;

  CompetitiveResultsData({
    required this.result,
    this.settlement,
    this.isProcessing = false,
    this.error,
  });

  bool get isSettled => settlement?.status == SettlementStatus.completed;
}
