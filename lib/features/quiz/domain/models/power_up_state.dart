import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_enums.dart';

part 'power_up_state.freezed.dart';
part 'power_up_state.g.dart';

@freezed
abstract class PowerUpState with _$PowerUpState {
  const factory PowerUpState({
    required PowerUpType type,
    @Default(true) bool isAvailable,
    @Default(false) bool isUsed,
    @Default(1) int remainingUses,
    @Default(Duration.zero) Duration cooldownRemaining,
  }) = _PowerUpState;

  factory PowerUpState.fromJson(Map<String, dynamic> json) =>
      _$PowerUpStateFromJson(json);
}
