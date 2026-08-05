import 'package:flutter/foundation.dart';

@immutable
class TournamentParticipant {
  final String tournamentId;
  final String uid;
  final String displayName;
  final String photoUrl;
  final DateTime registrationTime;

  const TournamentParticipant({
    required this.tournamentId,
    required this.uid,
    required this.displayName,
    required this.photoUrl,
    required this.registrationTime,
  });
}
