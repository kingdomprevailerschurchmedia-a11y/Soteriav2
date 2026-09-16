// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_competitive_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PublicCompetitiveProfile _$PublicCompetitiveProfileFromJson(
  Map<String, dynamic> json,
) => _PublicCompetitiveProfile(
  userId: json['userId'] as String,
  displayName: json['displayName'] as String,
  username: json['username'] as String? ?? '',
  avatarId: json['avatarId'] as String,
  photoUrl: json['photoUrl'] as String?,
  currentRank: json['currentRank'] as String,
  rankTier: json['rankTier'] as String,
  rankPoints: (json['rankPoints'] as num).toInt(),
  division: (json['division'] as num).toInt(),
  equippedTitle: json['equippedTitle'] == null
      ? null
      : CompetitiveTitle.fromJson(
          json['equippedTitle'] as Map<String, dynamic>,
        ),
  featuredBadges:
      (json['featuredBadges'] as List<dynamic>?)
          ?.map((e) => CompetitiveBadge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isSearchable: json['isSearchable'] as bool? ?? true,
  careerHighlights: CareerStatistics.fromJson(
    json['careerHighlights'] as Map<String, dynamic>,
  ),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$PublicCompetitiveProfileToJson(
  _PublicCompetitiveProfile instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'displayName': instance.displayName,
  'username': instance.username,
  'avatarId': instance.avatarId,
  'photoUrl': instance.photoUrl,
  'currentRank': instance.currentRank,
  'rankTier': instance.rankTier,
  'rankPoints': instance.rankPoints,
  'division': instance.division,
  'equippedTitle': instance.equippedTitle,
  'featuredBadges': instance.featuredBadges,
  'isSearchable': instance.isSearchable,
  'careerHighlights': instance.careerHighlights,
  'updatedAt': instance.updatedAt.toIso8601String(),
  'schemaVersion': instance.schemaVersion,
};
