// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_activity_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialActivityEvent _$SocialActivityEventFromJson(Map<String, dynamic> json) =>
    _SocialActivityEvent(
      id: json['id'] as String,
      userId: json['userId'] as String,
      otherUserId: json['otherUserId'] as String,
      otherDisplayName: json['otherDisplayName'] as String,
      type: $enumDecode(_$SocialActivityTypeEnumMap, json['type']),
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SocialActivityEventToJson(
  _SocialActivityEvent instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'otherUserId': instance.otherUserId,
  'otherDisplayName': instance.otherDisplayName,
  'type': _$SocialActivityTypeEnumMap[instance.type]!,
  'message': instance.message,
  'createdAt': instance.createdAt.toIso8601String(),
  'metadata': instance.metadata,
};

const _$SocialActivityTypeEnumMap = {
  SocialActivityType.friendAdded: 'friendAdded',
  SocialActivityType.friendRankUp: 'friendRankUp',
  SocialActivityType.friendAchievement: 'friendAchievement',
  SocialActivityType.rivalryMilestone: 'rivalryMilestone',
  SocialActivityType.overtake: 'overtake',
};
