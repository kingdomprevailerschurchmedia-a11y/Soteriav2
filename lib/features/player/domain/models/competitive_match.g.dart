// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetitiveMatch _$CompetitiveMatchFromJson(Map<String, dynamic> json) =>
    _CompetitiveMatch(
      result: CompetitiveResult.fromJson(
        json['result'] as Map<String, dynamic>,
      ),
      rankChange: json['rankChange'] == null
          ? null
          : RankChange.fromJson(json['rankChange'] as Map<String, dynamic>),
      quizResult: json['quizResult'] == null
          ? null
          : QuizResult.fromJson(json['quizResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompetitiveMatchToJson(_CompetitiveMatch instance) =>
    <String, dynamic>{
      'result': instance.result,
      'rankChange': instance.rankChange,
      'quizResult': instance.quizResult,
    };
