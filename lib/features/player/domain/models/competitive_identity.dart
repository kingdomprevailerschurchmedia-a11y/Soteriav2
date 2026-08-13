import 'package:freezed_annotation/freezed_annotation.dart';
import 'player_profile.dart';
import 'player_progression.dart';
import 'competitive_title.dart';
import 'competitive_badge.dart';
import 'rank_progress.dart';

part 'competitive_identity.freezed.dart';
part 'competitive_identity.g.dart';

@freezed
abstract class CompetitiveIdentity with _$CompetitiveIdentity {
  const factory CompetitiveIdentity({
    required String userId,
    required PlayerProfile profile,
    required PlayerProgression progression,
    required RankProgress rankProgress,
    CompetitiveTitle? equippedTitle,
    @Default([]) List<CompetitiveBadge> featuredBadges,
    @Default([]) List<CompetitiveBadge> allOwnedBadges,
    @Default([]) List<CompetitiveTitle> allOwnedTitles,
    @Default(1) int schemaVersion,
  }) = _CompetitiveIdentity;

  factory CompetitiveIdentity.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveIdentityFromJson(json);
}
