import 'package:freezed_annotation/freezed_annotation.dart';
import 'competitive_event.dart';

part 'competitive_activity_event.freezed.dart';
part 'competitive_activity_event.g.dart';

enum ActivityImportance { low, normal, high, milestone }

enum ActivityVisibility {
  public,
  friends,
  private,
}

@freezed
abstract class CompetitiveActivityEvent with _$CompetitiveActivityEvent {
  const factory CompetitiveActivityEvent({
    required String id,
    required String userId,
    required CompetitiveEventType type,
    required String title,
    required String description,
    required DateTime createdAt,
    String? seasonId,
    @Default({}) Map<String, dynamic> metadata,
    String? deepLink,
    @Default(ActivityImportance.normal) ActivityImportance importance,
    String? icon,
    @Default(ActivityVisibility.public) ActivityVisibility visibility,
  }) = _CompetitiveActivityEvent;

  factory CompetitiveActivityEvent.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveActivityEventFromJson(json);
}
