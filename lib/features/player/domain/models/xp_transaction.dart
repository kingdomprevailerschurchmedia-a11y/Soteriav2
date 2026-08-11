import 'package:freezed_annotation/freezed_annotation.dart';

part 'xp_transaction.freezed.dart';
part 'xp_transaction.g.dart';

enum XpSource {
  quizCompletion,
  achievement,
  dailyChallenge,
  tournament,
  versus,
  bonus,
  adminGrant,
}

@freezed
abstract class XpTransaction with _$XpTransaction {
  const factory XpTransaction({
    required String transactionId,
    required String userId,
    required int amount,
    required XpSource source,
    required String referenceId,
    required DateTime createdAt,
    @Default(1) int schemaVersion,
  }) = _XpTransaction;

  factory XpTransaction.fromJson(Map<String, dynamic> json) =>
      _$XpTransactionFromJson(json);
}
