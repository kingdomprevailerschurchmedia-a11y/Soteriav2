import 'package:freezed_annotation/freezed_annotation.dart';

part 'power_up_configuration.freezed.dart';
part 'power_up_configuration.g.dart';

@freezed
abstract class PowerUpConfiguration with _$PowerUpConfiguration {
  const factory PowerUpConfiguration({
    @Default(10) int maxPauseDurationSeconds,
    @Default(1) int fiftyFiftyUsesPerRound,
    @Default(1) int pauseTimerUsesPerRound,
    @Default(1) int askAudienceUsesPerRound,
  }) = _PowerUpConfiguration;

  factory PowerUpConfiguration.fromJson(Map<String, dynamic> json) =>
      _$PowerUpConfigurationFromJson(json);

  factory PowerUpConfiguration.standard() => const PowerUpConfiguration();
}
