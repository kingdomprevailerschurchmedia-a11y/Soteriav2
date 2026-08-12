import 'package:flutter/foundation.dart';
import 'tournament_reward.dart';

@immutable
class TournamentRanking {
  final int rank;
  final String uid;
  final String displayName;
  final String photoUrl;
  final String? avatarId;
  final int score;
  final double accuracy;
  final Duration completionTime;
  final DateTime completionTimestamp;
  final TournamentReward? prize;
  final bool isTie;

  const TournamentRanking({
    required this.rank,
    required this.uid,
    required this.displayName,
    required this.photoUrl,
    this.avatarId,
    required this.score,
    required this.accuracy,
    required this.completionTime,
    required this.completionTimestamp,
    this.prize,
    this.isTie = false,
  });

  Map<String, dynamic> toJson() => {
    'rank': rank,
    'uid': uid,
    'displayName': displayName,
    'photoUrl': photoUrl,
    'avatarId': avatarId,
    'score': score,
    'accuracy': accuracy,
    'completionTimeMs': completionTime.inMilliseconds,
    'completionTimestamp': completionTimestamp.toIso8601String(),
    if (prize != null) 'prize': prize!.toJson(),
    'isTie': isTie,
  };

  factory TournamentRanking.fromJson(Map<String, dynamic> json) =>
      TournamentRanking(
        rank: json['rank'],
        uid: json['uid'],
        displayName: json['displayName'],
        photoUrl: json['photoUrl'],
        avatarId: json['avatarId'],
        score: json['score'],
        accuracy: json['accuracy'].toDouble(),
        completionTime: Duration(milliseconds: json['completionTimeMs']),
        completionTimestamp: DateTime.parse(json['completionTimestamp']),
        prize: json['prize'] != null
            ? TournamentReward.fromJson(json['prize'])
            : null,
        isTie: json['isTie'] ?? false,
      );
}
