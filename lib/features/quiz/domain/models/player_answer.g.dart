// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerAnswer _$PlayerAnswerFromJson(Map<String, dynamic> json) =>
    _PlayerAnswer(
      questionId: json['questionId'] as String,
      selectedOptionIds: (json['selectedOptionIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isCorrect: json['isCorrect'] as bool,
      responseTime: Duration(
        microseconds: (json['responseTime'] as num).toInt(),
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
      isSkipped: json['isSkipped'] as bool? ?? false,
      isTimedOut: json['isTimedOut'] as bool? ?? false,
    );

Map<String, dynamic> _$PlayerAnswerToJson(_PlayerAnswer instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'selectedOptionIds': instance.selectedOptionIds,
      'isCorrect': instance.isCorrect,
      'responseTime': instance.responseTime.inMicroseconds,
      'timestamp': instance.timestamp.toIso8601String(),
      'isSkipped': instance.isSkipped,
      'isTimedOut': instance.isTimedOut,
    };
