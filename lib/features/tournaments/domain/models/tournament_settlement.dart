import 'package:flutter/foundation.dart';

enum TournamentSettlementStatus { pending, processing, completed, failed }

@immutable
class TournamentSettlement {
  final String tournamentId;
  final TournamentSettlementStatus status;
  final DateTime timestamp;
  final int totalParticipants;
  final int prizesDistributed;
  final String? error;

  const TournamentSettlement({
    required this.tournamentId,
    this.status = TournamentSettlementStatus.pending,
    required this.timestamp,
    this.totalParticipants = 0,
    this.prizesDistributed = 0,
    this.error,
  });

  Map<String, dynamic> toJson() => {
    'tournamentId': tournamentId,
    'status': status.name,
    'timestamp': timestamp.toIso8601String(),
    'totalParticipants': totalParticipants,
    'prizesDistributed': prizesDistributed,
    if (error != null) 'error': error,
  };
}
