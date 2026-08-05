import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/tournament_participant.dart';

class TournamentParticipantDto {
  static TournamentParticipant fromFirestore(
    DocumentSnapshot doc,
    String tournamentId,
  ) {
    final data = doc.data() as Map<String, dynamic>;

    return TournamentParticipant(
      tournamentId: tournamentId,
      uid: doc.id,
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      registrationTime: (data['registrationTime'] as Timestamp).toDate(),
    );
  }

  static Map<String, dynamic> toFirestore(TournamentParticipant participant) {
    return {
      'displayName': participant.displayName,
      'photoUrl': participant.photoUrl,
      'registrationTime': Timestamp.fromDate(participant.registrationTime),
    };
  }
}
