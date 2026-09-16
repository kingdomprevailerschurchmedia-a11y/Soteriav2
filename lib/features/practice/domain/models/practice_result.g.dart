// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PracticeResult _$PracticeResultFromJson(Map<String, dynamic> json) =>
    _PracticeResult(
      sessionId: json['sessionId'] as String,
      userId: json['userId'] as String,
      completedAt: DateTime.parse(json['completedAt'] as String),
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      answeredQuestions: (json['answeredQuestions'] as num).toInt(),
      correctAnswers: (json['correctAnswers'] as num).toInt(),
      incorrectAnswers: (json['incorrectAnswers'] as num).toInt(),
      skippedQuestions: (json['skippedQuestions'] as num).toInt(),
      accuracy: (json['accuracy'] as num).toDouble(),
      score: (json['score'] as num).toInt(),
      totalTime: Duration(microseconds: (json['totalTime'] as num).toInt()),
      categoryPerformance: (json['categoryPerformance'] as Map<String, dynamic>)
          .map(
            (k, e) => MapEntry(
              k,
              CategoryPerformance.fromJson(e as Map<String, dynamic>),
            ),
          ),
      difficultyPerformance:
          (json['difficultyPerformance'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(
              $enumDecode(_$DifficultyEnumMap, k),
              (e as num).toDouble(),
            ),
          ),
      reviewItems: (json['reviewItems'] as List<dynamic>)
          .map((e) => QuestionReviewItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      insights:
          (json['insights'] as List<dynamic>?)
              ?.map((e) => LearningInsight.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      recommendation: json['recommendation'] == null
          ? null
          : PracticeRecommendation.fromJson(
              json['recommendation'] as Map<String, dynamic>,
            ),
      xpEarned: (json['xpEarned'] as num?)?.toInt() ?? 0,
      coinsEarned: (json['coinsEarned'] as num?)?.toInt() ?? 0,
      performanceMessage: json['performanceMessage'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$PracticeResultToJson(_PracticeResult instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'userId': instance.userId,
      'completedAt': instance.completedAt.toIso8601String(),
      'totalQuestions': instance.totalQuestions,
      'answeredQuestions': instance.answeredQuestions,
      'correctAnswers': instance.correctAnswers,
      'incorrectAnswers': instance.incorrectAnswers,
      'skippedQuestions': instance.skippedQuestions,
      'accuracy': instance.accuracy,
      'score': instance.score,
      'totalTime': instance.totalTime.inMicroseconds,
      'categoryPerformance': instance.categoryPerformance.map(
        (k, e) => MapEntry(k, e.toJson()),
      ),
      'difficultyPerformance': instance.difficultyPerformance.map(
        (k, e) => MapEntry(_$DifficultyEnumMap[k]!, e),
      ),
      'reviewItems': instance.reviewItems.map((e) => e.toJson()).toList(),
      'insights': instance.insights.map((e) => e.toJson()).toList(),
      'recommendation': instance.recommendation?.toJson(),
      'xpEarned': instance.xpEarned,
      'coinsEarned': instance.coinsEarned,
      'performanceMessage': instance.performanceMessage,
      'metadata': instance.metadata,
    };

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
  Difficulty.expert: 'expert',
  Difficulty.adaptive: 'adaptive',
};

_CategoryPerformance _$CategoryPerformanceFromJson(Map<String, dynamic> json) =>
    _CategoryPerformance(
      categoryId: json['categoryId'] as String,
      total: (json['total'] as num).toInt(),
      correct: (json['correct'] as num).toInt(),
      accuracy: (json['accuracy'] as num).toDouble(),
    );

Map<String, dynamic> _$CategoryPerformanceToJson(
  _CategoryPerformance instance,
) => <String, dynamic>{
  'categoryId': instance.categoryId,
  'total': instance.total,
  'correct': instance.correct,
  'accuracy': instance.accuracy,
};

_QuestionReviewItem _$QuestionReviewItemFromJson(Map<String, dynamic> json) =>
    _QuestionReviewItem(
      questionId: json['questionId'] as String,
      questionText: json['questionText'] as String,
      selectedOptionIds: (json['selectedOptionIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      correctOptionIds: (json['correctOptionIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isCorrect: json['isCorrect'] as bool,
      isSkipped: json['isSkipped'] as bool,
      explanation: json['explanation'] as String?,
      categoryId: json['categoryId'] as String,
      difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
      responseTime: Duration(
        microseconds: (json['responseTime'] as num).toInt(),
      ),
      questionVersion: json['questionVersion'] as String?,
    );

Map<String, dynamic> _$QuestionReviewItemToJson(_QuestionReviewItem instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'questionText': instance.questionText,
      'selectedOptionIds': instance.selectedOptionIds,
      'correctOptionIds': instance.correctOptionIds,
      'isCorrect': instance.isCorrect,
      'isSkipped': instance.isSkipped,
      'explanation': instance.explanation,
      'categoryId': instance.categoryId,
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
      'responseTime': instance.responseTime.inMicroseconds,
      'questionVersion': instance.questionVersion,
    };

_LearningInsight _$LearningInsightFromJson(Map<String, dynamic> json) =>
    _LearningInsight(
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$LearningInsightTypeEnumMap, json['type']),
      isPositive: json['isPositive'] as bool,
    );

Map<String, dynamic> _$LearningInsightToJson(_LearningInsight instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'type': _$LearningInsightTypeEnumMap[instance.type]!,
      'isPositive': instance.isPositive,
    };

const _$LearningInsightTypeEnumMap = {
  LearningInsightType.strength: 'strength',
  LearningInsightType.weakness: 'weakness',
  LearningInsightType.improvement: 'improvement',
  LearningInsightType.consistency: 'consistency',
  LearningInsightType.challenge: 'challenge',
};

_PracticeRecommendation _$PracticeRecommendationFromJson(
  Map<String, dynamic> json,
) => _PracticeRecommendation(
  title: json['title'] as String,
  description: json['description'] as String,
  categoryId: json['categoryId'] as String,
  difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
  questionCount: (json['questionCount'] as num).toInt(),
  icon: json['icon'] as String?,
);

Map<String, dynamic> _$PracticeRecommendationToJson(
  _PracticeRecommendation instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'categoryId': instance.categoryId,
  'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
  'questionCount': instance.questionCount,
  'icon': instance.icon,
};
