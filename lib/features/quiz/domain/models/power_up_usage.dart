import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_enums.dart';

part 'power_up_usage.freezed.dart';
part 'power_up_usage.g.dart';

@freezed
abstract class PowerUpUsage with _$PowerUpUsage {
  const factory PowerUpUsage({
    required String usageId,
    required PowerUpType type,
    required String sessionId,
    required int roundIndex,
    required String questionId,
    required DateTime activatedAt,
    @Default({}) Map<String, dynamic> result,
    Duration? duration,
  }) = _PowerUpUsage;

  factory PowerUpUsage.fromJson(Map<String, dynamic> json) =>
      _$PowerUpUsageFromJson(json);
}
