import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_progression.freezed.dart';
part 'player_progression.g.dart';

@freezed
abstract class PlayerProgression with _$PlayerProgression {
  const factory PlayerProgression({
    required String userId,
    required int currentLevel,
    required int currentXp,
    required int lifetimeXp,
    required int xpRequiredForCurrentLevel,
    required int xpRequiredForNextLevel,
    required double xpProgress,
    required String currentRank,
    required String currentRankTier,
    required int rankPoints,
    required double rankProgress,
    required String seasonId,
    required int seasonXp,
    required int seasonRankPoints,
    required DateTime lastUpdated,
    @Default(1) int schemaVersion,
  }) = _PlayerProgression;

  factory PlayerProgression.fromJson(Map<String, dynamic> json) =>
      _$PlayerProgressionFromJson(json);

  factory PlayerProgression.initial(String userId, String seasonId) =>
      PlayerProgression(
        userId: userId,
        currentLevel: 1,
        currentXp: 0,
        lifetimeXp: 0,
        xpRequiredForCurrentLevel: 0,
        xpRequiredForNextLevel: 1000, // Default start
        xpProgress: 0.0,
        currentRank: 'Unranked',
        currentRankTier: 'None',
        rankPoints: 0,
        rankProgress: 0.0,
        seasonId: seasonId,
        seasonXp: 0,
        seasonRankPoints: 0,
        lastUpdated: DateTime.now(),
      );
}
