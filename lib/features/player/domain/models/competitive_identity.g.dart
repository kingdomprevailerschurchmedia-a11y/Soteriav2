// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetitiveIdentity _$CompetitiveIdentityFromJson(Map<String, dynamic> json) =>
    _CompetitiveIdentity(
      userId: json['userId'] as String,
      profile: PlayerProfile.fromJson(json['profile'] as Map<String, dynamic>),
      progression: PlayerProgression.fromJson(
        json['progression'] as Map<String, dynamic>,
      ),
      rankProgress: RankProgress.fromJson(
        json['rankProgress'] as Map<String, dynamic>,
      ),
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
      allOwnedBadges:
          (json['allOwnedBadges'] as List<dynamic>?)
              ?.map((e) => CompetitiveBadge.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      allOwnedTitles:
          (json['allOwnedTitles'] as List<dynamic>?)
              ?.map((e) => CompetitiveTitle.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      schemaVersion: (json['schemaVersion'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$CompetitiveIdentityToJson(
  _CompetitiveIdentity instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'profile': instance.profile,
  'progression': instance.progression,
  'rankProgress': instance.rankProgress,
  'equippedTitle': instance.equippedTitle,
  'featuredBadges': instance.featuredBadges,
  'allOwnedBadges': instance.allOwnedBadges,
  'allOwnedTitles': instance.allOwnedTitles,
  'schemaVersion': instance.schemaVersion,
};
