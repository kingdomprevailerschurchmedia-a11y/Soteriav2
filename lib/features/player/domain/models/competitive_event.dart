import 'package:freezed_annotation/freezed_annotation.dart';

part 'competitive_event.freezed.dart';
part 'competitive_event.g.dart';

enum CompetitiveEventType {
  rankPromoted,
  rankDemoted,
  rankReached,
  rankChanged,
  leaderboardChanged,
  leaderboardMilestone,
  personalBest,
  seasonEnding,
  seasonStarted,
  seasonCompleted,
  seasonResult,
  seasonResultAvailable,
  rewardReceived,
  milestoneCompleted,
  achievementUnlocked,
  newSeasonStarted,
  gameMilestone,
  winMilestone,
  careerMilestone,
}

@freezed
abstract class CompetitiveEvent with _$CompetitiveEvent {
  const factory CompetitiveEvent({
    required String eventId,
    required String userId,
    required CompetitiveEventType type,
    required String title,
    required String body,
    @Default({}) Map<String, dynamic> metadata,
    String? seasonId,
    required DateTime createdAt,
    @Default(1) int priority, // 0: Low, 1: Normal, 2: High, 3: Critical
    String? deduplicationKey,
  }) = _CompetitiveEvent;

  factory CompetitiveEvent.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveEventFromJson(json);
}
