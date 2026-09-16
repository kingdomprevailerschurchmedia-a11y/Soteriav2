// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestionResult _$QuestionResultFromJson(Map<String, dynamic> json) =>
    _QuestionResult(
      questionId: json['questionId'] as String,
      questionNumber: (json['questionNumber'] as num).toInt(),
      questionText: json['questionText'] as String,
      outcome: $enumDecode(_$QuestionOutcomeEnumMap, json['outcome']),
      selectedOptionId: json['selectedOptionId'] as String?,
      selectedOptionText: json['selectedOptionText'] as String?,
      correctOptionIds: (json['correctOptionIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      correctOptionText: json['correctOptionText'] as String,
      responseTime: Duration(
        microseconds: (json['responseTime'] as num).toInt(),
      ),
      scoreEarned: (json['scoreEarned'] as num).toInt(),
      categoryId: json['categoryId'] as String?,
      mode: $enumDecodeNullable(_$GameModeEnumMap, json['mode']),
      difficulty: $enumDecodeNullable(_$DifficultyEnumMap, json['difficulty']),
      explanation: json['explanation'] as String?,
      questionVersion: json['questionVersion'] as String?,
    );

Map<String, dynamic> _$QuestionResultToJson(_QuestionResult instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'questionNumber': instance.questionNumber,
      'questionText': instance.questionText,
      'outcome': _$QuestionOutcomeEnumMap[instance.outcome]!,
      'selectedOptionId': instance.selectedOptionId,
      'selectedOptionText': instance.selectedOptionText,
      'correctOptionIds': instance.correctOptionIds,
      'correctOptionText': instance.correctOptionText,
      'responseTime': instance.responseTime.inMicroseconds,
      'scoreEarned': instance.scoreEarned,
      'categoryId': instance.categoryId,
      'mode': _$GameModeEnumMap[instance.mode],
      'difficulty': _$DifficultyEnumMap[instance.difficulty],
      'explanation': instance.explanation,
      'questionVersion': instance.questionVersion,
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

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
  Difficulty.expert: 'expert',
  Difficulty.adaptive: 'adaptive',
};
