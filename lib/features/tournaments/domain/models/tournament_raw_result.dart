import 'package:flutter/foundation.dart';

/// Helper model for raw results before ranking.
@immutable
class TournamentRawResult {
  final String uid;
  final String displayName;
  final String photoUrl;
  final int score;
  final double accuracy;
  final Duration completionTime;
  final DateTime completionTimestamp;

  const TournamentRawResult({
    required this.uid,
    required this.displayName,
    required this.photoUrl,
    required this.score,
    required this.accuracy,
    required this.completionTime,
    required this.completionTimestamp,
  });
}
