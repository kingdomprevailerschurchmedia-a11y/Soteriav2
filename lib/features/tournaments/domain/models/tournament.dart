import 'package:flutter/foundation.dart';
import 'tournament_status.dart';
import 'tournament_type.dart';

@immutable
class Tournament {
  final String id;
  final String name;
  final String description;
  final List<String> rules;
  final String bannerUrl;
  final TournamentType type;
  final TournamentStatus status;
  final String difficulty;
  final int questionCount;
  final double entryFee;
  final double prizePool;
  final int maxPlayers;
  final int registeredPlayers;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime registrationEndTime;

  const Tournament({
    required this.id,
    required this.name,
    required this.description,
    required this.rules,
    required this.bannerUrl,
    required this.type,
    required this.status,
    required this.difficulty,
    required this.questionCount,
    required this.entryFee,
    required this.prizePool,
    required this.maxPlayers,
    required this.registeredPlayers,
    required this.startTime,
    required this.endTime,
    required this.registrationEndTime,
  });

  Tournament copyWith({
    String? name,
    String? description,
    List<String>? rules,
    String? bannerUrl,
    TournamentType? type,
    TournamentStatus? status,
    String? difficulty,
    int? questionCount,
    double? entryFee,
    double? prizePool,
    int? maxPlayers,
    int? registeredPlayers,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? registrationEndTime,
  }) {
    return Tournament(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      rules: rules ?? this.rules,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      type: type ?? this.type,
      status: status ?? this.status,
      difficulty: difficulty ?? this.difficulty,
      questionCount: questionCount ?? this.questionCount,
      entryFee: entryFee ?? this.entryFee,
      prizePool: prizePool ?? this.prizePool,
      maxPlayers: maxPlayers ?? this.maxPlayers,
      registeredPlayers: registeredPlayers ?? this.registeredPlayers,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      registrationEndTime: registrationEndTime ?? this.registrationEndTime,
    );
  }
}
