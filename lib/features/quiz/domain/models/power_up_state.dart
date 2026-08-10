import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_enums.dart';

import 'power_up_usage.dart';

part 'power_up_state.freezed.dart';
part 'power_up_state.g.dart';

@freezed
abstract class PowerUpState with _$PowerUpState {
  const factory PowerUpState({
    required PowerUpType type,
    @Default(PowerUpStatus.available) PowerUpStatus status,
    @Default(1) int remainingUses,
    @Default(Duration.zero) Duration cooldownRemaining,
    @Default([]) List<PowerUpUsage> usageHistory,
  }) = _PowerUpState;

  factory PowerUpState.fromJson(Map<String, dynamic> json) =>
      _$PowerUpStateFromJson(json);
}
