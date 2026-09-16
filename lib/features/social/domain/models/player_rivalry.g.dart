// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_rivalry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerRivalry _$PlayerRivalryFromJson(Map<String, dynamic> json) =>
    _PlayerRivalry(
      rivalryId: json['rivalryId'] as String,
      userId: json['userId'] as String,
      rivalId: json['rivalId'] as String,
      matchesPlayed: (json['matchesPlayed'] as num).toInt(),
      wins: (json['wins'] as num).toInt(),
      losses: (json['losses'] as num).toInt(),
      draws: (json['draws'] as num).toInt(),
      lastMatchAt: DateTime.parse(json['lastMatchAt'] as String),
      lastOutcome: $enumDecodeNullable(
        _$CompetitiveOutcomeEnumMap,
        json['lastOutcome'],
      ),
      recentForm:
          (json['recentForm'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$CompetitiveOutcomeEnumMap, e))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PlayerRivalryToJson(_PlayerRivalry instance) =>
    <String, dynamic>{
      'rivalryId': instance.rivalryId,
      'userId': instance.userId,
      'rivalId': instance.rivalId,
      'matchesPlayed': instance.matchesPlayed,
      'wins': instance.wins,
      'losses': instance.losses,
      'draws': instance.draws,
      'lastMatchAt': instance.lastMatchAt.toIso8601String(),
      'lastOutcome': _$CompetitiveOutcomeEnumMap[instance.lastOutcome],
      'recentForm': instance.recentForm
          .map((e) => _$CompetitiveOutcomeEnumMap[e]!)
          .toList(),
    };

const _$CompetitiveOutcomeEnumMap = {
  CompetitiveOutcome.win: 'win',
  CompetitiveOutcome.loss: 'loss',
  CompetitiveOutcome.draw: 'draw',
  CompetitiveOutcome.placement: 'placement',
};
