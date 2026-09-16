// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Follow _$FollowFromJson(Map<String, dynamic> json) => _Follow(
  id: json['id'] as String,
  followerId: json['followerId'] as String,
  followingId: json['followingId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$FollowToJson(_Follow instance) => <String, dynamic>{
  'id': instance.id,
  'followerId': instance.followerId,
  'followingId': instance.followingId,
  'createdAt': instance.createdAt.toIso8601String(),
};
