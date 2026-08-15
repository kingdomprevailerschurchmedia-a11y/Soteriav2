import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../quiz/domain/models/quiz_enums.dart';

part 'question_analytics.freezed.dart';
part 'question_analytics.g.dart';

class DurationConverter implements JsonConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromJson(int json) => Duration(milliseconds: json);

  @override
  int toJson(Duration object) => object.inMilliseconds;
}

class TimestampConverter implements JsonConverter<DateTime?, dynamic> {
  const TimestampConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    try {
      if (json is DateTime) return json;
      if (json.runtimeType.toString() == 'Timestamp') {
        return (json as dynamic).toDate();
      }
      return DateTime.tryParse(json.toString());
    } catch (_) {
      return null;
    }
  }

  @override
  dynamic toJson(DateTime? object) => object?.toIso8601String();
}

enum QualitySignalLevel {
  insufficientData,
  healthy,
  qualitySignal,
  reviewRecommended,
}

@freezed
abstract class QuestionAnalytics with _$QuestionAnalytics {
  const factory QuestionAnalytics({
    required String questionId,
    required String version,
    required String categoryId,
    required Difficulty difficulty,
    @Default(0) int totalAttempts,
    @Default(0) int correctAttempts,
    @Default(0) int incorrectAttempts,
    @Default(0) int timeoutCount,
    @Default(0) int skipCount,
    @DurationConverter() @Default(Duration.zero) Duration averageResponseTime,
    @DurationConverter() @Default(Duration.zero) Duration fastestResponseTime,
    @DurationConverter() @Default(Duration.zero) Duration slowestResponseTime,
    @TimestampConverter() DateTime? firstAttemptAt,
    @TimestampConverter() DateTime? lastAttemptAt,
    @Default({}) Map<String, int> modeBreakdown, // Key: GameMode.name
  }) = _QuestionAnalytics;

  const QuestionAnalytics._();

  double get accuracyRate =>
      totalAttempts > 0 ? correctAttempts / totalAttempts : 0.0;
  double get timeoutRate =>
      totalAttempts > 0 ? timeoutCount / totalAttempts : 0.0;
  double get skipRate =>
      totalAttempts > 0 ? skipCount / totalAttempts : 0.0;

  QualitySignalLevel get qualityLevel {
    if (totalAttempts < 20) return QualitySignalLevel.insufficientData;

    final acc = accuracyRate;
    final timeout = timeoutRate;
    final skip = skipRate;

    // Strong signals for review
    if (acc < 0.2 || timeout > 0.3 || skip > 0.2) {
      return QualitySignalLevel.reviewRecommended;
    }

    // Minor quality signals
    if (acc < 0.4 || acc > 0.98 || timeout > 0.15 || skip > 0.1) {
      return QualitySignalLevel.qualitySignal;
    }

    return QualitySignalLevel.healthy;
  }

  int getAttemptsForMode(GameMode mode) => modeBreakdown[mode.name] ?? 0;

  factory QuestionAnalytics.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnalyticsFromJson(json);
}
