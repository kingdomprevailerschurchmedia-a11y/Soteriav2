// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuizSession _$QuizSessionFromJson(Map<String, dynamic> json) => _QuizSession(
  sessionId: json['sessionId'] as String,
  playerId: json['playerId'] as String,
  gameMode: $enumDecode(_$GameModeEnumMap, json['gameMode']),
  category: json['category'] as String,
  difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
  startedTime: DateTime.parse(json['startedTime'] as String),
  endedTime: json['endedTime'] == null
      ? null
      : DateTime.parse(json['endedTime'] as String),
  lastUpdatedTime: json['lastUpdatedTime'] == null
      ? null
      : DateTime.parse(json['lastUpdatedTime'] as String),
  currentQuestionIndex: (json['currentQuestionIndex'] as num?)?.toInt() ?? 0,
  currentQuestionId: json['currentQuestionId'] as String?,
  questionIds:
      (json['questionIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  answeredQuestions:
      (json['answeredQuestions'] as List<dynamic>?)
          ?.map((e) => PlayerAnswer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  remainingQuestions: (json['remainingQuestions'] as num?)?.toInt() ?? 0,
  currentScore: (json['currentScore'] as num?)?.toInt() ?? 0,
  currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
  bestStreak: (json['bestStreak'] as num?)?.toInt() ?? 0,
  accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
  xpEarned: (json['xpEarned'] as num?)?.toInt() ?? 0,
  coinsEarned: (json['coinsEarned'] as num?)?.toInt() ?? 0,
  completionStatus:
      $enumDecodeNullable(_$QuizStatusEnumMap, json['completionStatus']) ??
      QuizStatus.idle,
  sessionStatus:
      $enumDecodeNullable(_$SessionStatusEnumMap, json['sessionStatus']) ??
      SessionStatus.created,
  powerUps:
      (json['powerUps'] as List<dynamic>?)
          ?.map((e) => PowerUpState.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  timerState: json['timerState'] == null
      ? null
      : TimerState.fromJson(json['timerState'] as Map<String, dynamic>),
  questionStartTime: json['questionStartTime'] == null
      ? null
      : DateTime.parse(json['questionStartTime'] as String),
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$QuizSessionToJson(_QuizSession instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'playerId': instance.playerId,
      'gameMode': _$GameModeEnumMap[instance.gameMode]!,
      'category': instance.category,
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
      'startedTime': instance.startedTime.toIso8601String(),
      'endedTime': instance.endedTime?.toIso8601String(),
      'lastUpdatedTime': instance.lastUpdatedTime?.toIso8601String(),
      'currentQuestionIndex': instance.currentQuestionIndex,
      'currentQuestionId': instance.currentQuestionId,
      'questionIds': instance.questionIds,
      'answeredQuestions': instance.answeredQuestions,
      'remainingQuestions': instance.remainingQuestions,
      'currentScore': instance.currentScore,
      'currentStreak': instance.currentStreak,
      'bestStreak': instance.bestStreak,
      'accuracy': instance.accuracy,
      'xpEarned': instance.xpEarned,
      'coinsEarned': instance.coinsEarned,
      'completionStatus': _$QuizStatusEnumMap[instance.completionStatus]!,
      'sessionStatus': _$SessionStatusEnumMap[instance.sessionStatus]!,
      'powerUps': instance.powerUps,
      'timerState': instance.timerState,
      'questionStartTime': instance.questionStartTime?.toIso8601String(),
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

const _$QuizStatusEnumMap = {
  QuizStatus.idle: 'idle',
  QuizStatus.loading: 'loading',
  QuizStatus.ready: 'ready',
  QuizStatus.active: 'active',
  QuizStatus.paused: 'paused',
  QuizStatus.completing: 'completing',
  QuizStatus.finalizing: 'finalizing',
  QuizStatus.completed: 'completed',
  QuizStatus.failed: 'failed',
};

const _$SessionStatusEnumMap = {
  SessionStatus.created: 'created',
  SessionStatus.active: 'active',
  SessionStatus.paused: 'paused',
  SessionStatus.interrupted: 'interrupted',
  SessionStatus.recoverable: 'recoverable',
  SessionStatus.completed: 'completed',
  SessionStatus.cancelled: 'cancelled',
  SessionStatus.expired: 'expired',
  SessionStatus.corrupted: 'corrupted',
  SessionStatus.deleted: 'deleted',
};
