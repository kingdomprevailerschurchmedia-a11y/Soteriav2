// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Friendship _$FriendshipFromJson(Map<String, dynamic> json) => _Friendship(
  id: json['id'] as String,
  userIds: (json['userIds'] as List<dynamic>).map((e) => e as String).toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$FriendshipToJson(_Friendship instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userIds': instance.userIds,
      'createdAt': instance.createdAt.toIso8601String(),
      'metadata': instance.metadata,
    };
