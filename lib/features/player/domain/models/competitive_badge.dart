import 'package:freezed_annotation/freezed_annotation.dart';

part 'competitive_badge.freezed.dart';
part 'competitive_badge.g.dart';

enum BadgeCategory {
  rank,
  achievement,
  season,
  tournament,
  milestone,
  career,
}

@freezed
abstract class CompetitiveBadge with _$CompetitiveBadge {
  const factory CompetitiveBadge({
    required String id,
    required String name,
    required String description,
    required String iconAsset,
    required BadgeCategory category,
    @Default(false) bool isHidden,
    @Default(0) int displayOrder,
  }) = _CompetitiveBadge;

  factory CompetitiveBadge.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveBadgeFromJson(json);
}
