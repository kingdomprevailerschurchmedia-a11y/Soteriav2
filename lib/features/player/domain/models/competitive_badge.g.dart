// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitive_badge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CompetitiveBadge _$CompetitiveBadgeFromJson(Map<String, dynamic> json) =>
    _CompetitiveBadge(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconAsset: json['iconAsset'] as String,
      category: $enumDecode(_$BadgeCategoryEnumMap, json['category']),
      isHidden: json['isHidden'] as bool? ?? false,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CompetitiveBadgeToJson(_CompetitiveBadge instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'iconAsset': instance.iconAsset,
      'category': _$BadgeCategoryEnumMap[instance.category]!,
      'isHidden': instance.isHidden,
      'displayOrder': instance.displayOrder,
    };

const _$BadgeCategoryEnumMap = {
  BadgeCategory.rank: 'rank',
  BadgeCategory.achievement: 'achievement',
  BadgeCategory.season: 'season',
  BadgeCategory.tournament: 'tournament',
  BadgeCategory.milestone: 'milestone',
  BadgeCategory.career: 'career',
};
