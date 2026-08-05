import 'package:flutter/foundation.dart';
import 'game_result.dart';

enum SettlementStatus { pending, completed, failed, offline }

@immutable
class CompetitiveSettlement {
  final String settlementId;
  final String sessionId;
  final String uid;
  final GameResult result;
  final SettlementStatus status;
  final int coinsWagered;
  final int coinsWon;
  final int xpEarned;
  final DateTime timestamp;
  final String? errorMessage;

  const CompetitiveSettlement({
    required this.settlementId,
    required this.sessionId,
    required this.uid,
    required this.result,
    this.status = SettlementStatus.pending,
    required this.coinsWagered,
    required this.coinsWon,
    required this.xpEarned,
    required this.timestamp,
    this.errorMessage,
  });

  Map<String, dynamic> toJson() => {
    'settlementId': settlementId,
    'sessionId': sessionId,
    'uid': uid,
    'result': result.toJson(),
    'status': status.name,
    'coinsWagered': coinsWagered,
    'coinsWon': coinsWon,
    'xpEarned': xpEarned,
    'timestamp': timestamp.toIso8601String(),
    if (errorMessage != null) 'errorMessage': errorMessage,
  };

  factory CompetitiveSettlement.fromJson(Map<String, dynamic> json) =>
      CompetitiveSettlement(
        settlementId: json['settlementId'],
        sessionId: json['sessionId'],
        uid: json['uid'],
        result: GameResult.fromJson(json['result']),
        status: SettlementStatus.values.byName(json['status']),
        coinsWagered: json['coinsWagered'],
        coinsWon: json['coinsWon'],
        xpEarned: json['xpEarned'],
        timestamp: DateTime.parse(json['timestamp']),
        errorMessage: json['errorMessage'],
      );

  CompetitiveSettlement copyWith({
    SettlementStatus? status,
    String? errorMessage,
  }) {
    return CompetitiveSettlement(
      settlementId: settlementId,
      sessionId: sessionId,
      uid: uid,
      result: result,
      status: status ?? this.status,
      coinsWagered: coinsWagered,
      coinsWon: coinsWon,
      xpEarned: xpEarned,
      timestamp: timestamp,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
