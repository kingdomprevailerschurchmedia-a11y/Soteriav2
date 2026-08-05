import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/tournament.dart';
import '../../domain/models/tournament_status.dart';
import '../../domain/models/tournament_type.dart';

class TournamentDto {
  static Tournament fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Tournament(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      rules: List<String>.from(data['rules'] ?? []),
      bannerUrl: data['bannerUrl'] ?? '',
      type: TournamentType.values.byName(data['type'] ?? 'standard'),
      status: TournamentStatus.values.byName(data['status'] ?? 'upcoming'),
      difficulty: data['difficulty'] ?? 'intermediate',
      questionCount: data['questionCount'] ?? 0,
      entryFee: (data['entryFee'] ?? 0).toDouble(),
      prizePool: (data['prizePool'] ?? 0).toDouble(),
      maxPlayers: data['maxPlayers'] ?? 0,
      registeredPlayers: data['registeredPlayers'] ?? 0,
      startTime: (data['startTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
      registrationEndTime: (data['registrationEndTime'] as Timestamp).toDate(),
    );
  }

  static Map<String, dynamic> toFirestore(Tournament tournament) {
    return {
      'name': tournament.name,
      'description': tournament.description,
      'rules': tournament.rules,
      'bannerUrl': tournament.bannerUrl,
      'type': tournament.type.name,
      'status': tournament.status.name,
      'difficulty': tournament.difficulty,
      'questionCount': tournament.questionCount,
      'entryFee': tournament.entryFee,
      'prizePool': tournament.prizePool,
      'maxPlayers': tournament.maxPlayers,
      'registeredPlayers': tournament.registeredPlayers,
      'startTime': Timestamp.fromDate(tournament.startTime),
      'endTime': Timestamp.fromDate(tournament.endTime),
      'registrationEndTime': Timestamp.fromDate(tournament.registrationEndTime),
    };
  }
}
