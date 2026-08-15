import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_engagement.freezed.dart';
part 'daily_engagement.g.dart';

@freezed
abstract class DailyEngagement with _$DailyEngagement {
  const factory DailyEngagement({
    required String playerId,
    required String engagementDate, // Format: YYYY-MM-DD
    @Default(true) bool qualified,
    required String qualifyingActivityType, // e.g., 'practice', 'versus', 'daily_challenge'
    required String qualifyingActivityId,
    required DateTime firstQualifiedActivityAt,
    required DateTime createdAt,
  }) = _DailyEngagement;

  factory DailyEngagement.fromJson(Map<String, dynamic> json) =>
      _$DailyEngagementFromJson(json);
}
