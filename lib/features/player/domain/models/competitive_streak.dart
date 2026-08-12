import 'package:freezed_annotation/freezed_annotation.dart';

part 'competitive_streak.freezed.dart';
part 'competitive_streak.g.dart';

enum StreakType { win, participation, performance, personalBest }

enum StreakStatus { active, broken, milestoneReached }

@freezed
abstract class CompetitiveStreak with _$CompetitiveStreak {
  const factory CompetitiveStreak({
    required String userId,
    required StreakType type,
    required int current,
    required int best,
    required int seasonBest,
    required DateTime startedAt,
    required DateTime lastQualifiedAt,
    String? seasonId,
    @Default(StreakStatus.active) StreakStatus status,
    required DateTime updatedAt,
  }) = _CompetitiveStreak;

  factory CompetitiveStreak.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveStreakFromJson(json);
}
