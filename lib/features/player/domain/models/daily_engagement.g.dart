// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_engagement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyEngagement _$DailyEngagementFromJson(Map<String, dynamic> json) =>
    _DailyEngagement(
      playerId: json['playerId'] as String,
      engagementDate: json['engagementDate'] as String,
      qualified: json['qualified'] as bool? ?? true,
      qualifyingActivityType: json['qualifyingActivityType'] as String,
      qualifyingActivityId: json['qualifyingActivityId'] as String,
      firstQualifiedActivityAt: const RequiredTimestampConverter().fromJson(
        json['firstQualifiedActivityAt'],
      ),
      createdAt: const RequiredTimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$DailyEngagementToJson(
  _DailyEngagement instance,
) => <String, dynamic>{
  'playerId': instance.playerId,
  'engagementDate': instance.engagementDate,
  'qualified': instance.qualified,
  'qualifyingActivityType': instance.qualifyingActivityType,
  'qualifyingActivityId': instance.qualifyingActivityId,
  'firstQualifiedActivityAt': const RequiredTimestampConverter().toJson(
    instance.firstQualifiedActivityAt,
  ),
  'createdAt': const RequiredTimestampConverter().toJson(instance.createdAt),
};
