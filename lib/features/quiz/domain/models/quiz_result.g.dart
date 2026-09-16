// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizResult _$QuizResultFromJson(Map<String, dynamic> json) => _QuizResult(
  sessionId: json['sessionId'] as String,
  playerId: json['playerId'] as String,
  gameMode: $enumDecode(_$GameModeEnumMap, json['gameMode']),
  category: json['category'] as String,
  difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
  totalQuestions: (json['totalQuestions'] as num).toInt(),
  answeredQuestions: (json['answeredQuestions'] as num).toInt(),
  correctAnswers: (json['correctAnswers'] as num).toInt(),
  wrongAnswers: (json['wrongAnswers'] as num).toInt(),
  skipped: (json['skipped'] as num).toInt(),
  timedOut: (json['timedOut'] as num).toInt(),
  accuracy: (json['accuracy'] as num).toDouble(),
  finalScore: (json['finalScore'] as num).toInt(),
  xpEarned: (json['xpEarned'] as num).toInt(),
  coinsEarned: (json['coinsEarned'] as num?)?.toInt() ?? 0,
  longestStreak: (json['longestStreak'] as num).toInt(),
  finalStreak: (json['finalStreak'] as num).toInt(),
  averageResponseTime: Duration(
    microseconds: (json['averageResponseTime'] as num).toInt(),
  ),
  fastestResponseTime: Duration(
    microseconds: (json['fastestResponseTime'] as num).toInt(),
  ),
  slowestResponseTime: Duration(
    microseconds: (json['slowestResponseTime'] as num).toInt(),
  ),
  questionResults: (json['questionResults'] as List<dynamic>)
      .map((e) => QuestionResult.fromJson(e as Map<String, dynamic>))
      .toList(),
  powerUpsUsed:
      (json['powerUpsUsed'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$PowerUpTypeEnumMap, e))
          .toList() ??
      const [],
  completedAt: DateTime.parse(json['completedAt'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  completionTime: Duration(
    microseconds: (json['completionTime'] as num).toInt(),
  ),
  performanceRating: json['performanceRating'] as String,
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$QuizResultToJson(_QuizResult instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'playerId': instance.playerId,
      'gameMode': _$GameModeEnumMap[instance.gameMode]!,
      'category': instance.category,
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
      'totalQuestions': instance.totalQuestions,
      'answeredQuestions': instance.answeredQuestions,
      'correctAnswers': instance.correctAnswers,
      'wrongAnswers': instance.wrongAnswers,
      'skipped': instance.skipped,
      'timedOut': instance.timedOut,
      'accuracy': instance.accuracy,
      'finalScore': instance.finalScore,
      'xpEarned': instance.xpEarned,
      'coinsEarned': instance.coinsEarned,
      'longestStreak': instance.longestStreak,
      'finalStreak': instance.finalStreak,
      'averageResponseTime': instance.averageResponseTime.inMicroseconds,
      'fastestResponseTime': instance.fastestResponseTime.inMicroseconds,
      'slowestResponseTime': instance.slowestResponseTime.inMicroseconds,
      'questionResults': instance.questionResults,
      'powerUpsUsed': instance.powerUpsUsed
          .map((e) => _$PowerUpTypeEnumMap[e]!)
          .toList(),
      'completedAt': instance.completedAt.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'completionTime': instance.completionTime.inMicroseconds,
      'performanceRating': instance.performanceRating,
      'version': instance.version,
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

const _$PowerUpTypeEnumMap = {
  PowerUpType.fiftyFifty: 'fiftyFifty',
  PowerUpType.pauseTimer: 'pauseTimer',
  PowerUpType.askAudience: 'askAudience',
  PowerUpType.extraTime: 'extraTime',
  PowerUpType.doubleXP: 'doubleXP',
  PowerUpType.shield: 'shield',
  PowerUpType.revealCategory: 'revealCategory',
};
