import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/json_converters.dart';

part 'daily_engagement.freezed.dart';
part 'daily_engagement.g.dart';

@freezed
abstract class DailyEngagement with _$DailyEngagement {
  const factory DailyEngagement({
    required String playerId,
    @EngagementDateConverter() required String engagementDate, // Format: YYYY-MM-DD
    @Default(true) bool qualified,
    required String qualifyingActivityType, // e.g., 'practice', 'versus', 'daily_challenge'
    required String qualifyingActivityId,
    @TimestampConverter() required DateTime firstQualifiedActivityAt,
    @TimestampConverter() required DateTime createdAt,
  }) = _DailyEngagement;

  factory DailyEngagement.fromJson(Map<String, dynamic> json) =>
      _$DailyEngagementFromJson(json);
}
