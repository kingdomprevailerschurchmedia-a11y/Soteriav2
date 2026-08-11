import 'package:freezed_annotation/freezed_annotation.dart';

part 'rank_transaction.freezed.dart';
part 'rank_transaction.g.dart';

@freezed
abstract class RankTransaction with _$RankTransaction {
  const factory RankTransaction({
    required String transactionId,
    required String userId,
    required String seasonId,
    required String resultId,
    required int previousRankPoints,
    required int changeAmount,
    required int newRankPoints,
    required DateTime timestamp,
    @Default(1) int schemaVersion,
  }) = _RankTransaction;

  factory RankTransaction.fromJson(Map<String, dynamic> json) =>
      _$RankTransactionFromJson(json);
}
