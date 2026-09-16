// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_analytics_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestionAnalyticsEvent _$QuestionAnalyticsEventFromJson(
  Map<String, dynamic> json,
) => _QuestionAnalyticsEvent(
  eventId: json['eventId'] as String,
  userId: json['userId'] as String,
  questionId: json['questionId'] as String,
  version: json['version'] as String,
  categoryId: json['categoryId'] as String,
  difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
  outcome: $enumDecode(_$QuestionOutcomeEnumMap, json['outcome']),
  responseTime: Duration(microseconds: (json['responseTime'] as num).toInt()),
  mode: $enumDecode(_$GameModeEnumMap, json['mode']),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$QuestionAnalyticsEventToJson(
  _QuestionAnalyticsEvent instance,
) => <String, dynamic>{
  'eventId': instance.eventId,
  'userId': instance.userId,
  'questionId': instance.questionId,
  'version': instance.version,
  'categoryId': instance.categoryId,
  'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
  'outcome': _$QuestionOutcomeEnumMap[instance.outcome]!,
  'responseTime': instance.responseTime.inMicroseconds,
  'mode': _$GameModeEnumMap[instance.mode]!,
  'timestamp': instance.timestamp.toIso8601String(),
};

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
  Difficulty.expert: 'expert',
  Difficulty.adaptive: 'adaptive',
};

const _$QuestionOutcomeEnumMap = {
  QuestionOutcome.correct: 'correct',
  QuestionOutcome.incorrect: 'incorrect',
  QuestionOutcome.skipped: 'skipped',
  QuestionOutcome.timedOut: 'timedOut',
};

const _$GameModeEnumMap = {
  GameMode.practice: 'practice',
  GameMode.pro: 'pro',
  GameMode.tournament: 'tournament',
  GameMode.versus: 'versus',
  GameMode.aiChallenge: 'aiChallenge',
  GameMode.teamBattle: 'teamBattle',
  GameMode.dailyChallenge: 'dailyChallenge',
  GameMode.seasonalEvent: 'seasonalEvent',
};
