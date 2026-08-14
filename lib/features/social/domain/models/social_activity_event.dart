import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_activity_event.freezed.dart';
part 'social_activity_event.g.dart';

enum SocialActivityType {
  friendAdded,
  friendRankUp,
  friendAchievement,
  rivalryMilestone,
  overtake,
}

@freezed
abstract class SocialActivityEvent with _$SocialActivityEvent {
  const factory SocialActivityEvent({
    required String id,
    required String userId,
    required String otherUserId,
    required String otherDisplayName,
    required SocialActivityType type,
    required String message,
    required DateTime createdAt,
    Map<String, dynamic>? metadata,
  }) = _SocialActivityEvent;

  factory SocialActivityEvent.fromJson(Map<String, dynamic> json) =>
      _$SocialActivityEventFromJson(json);
}
