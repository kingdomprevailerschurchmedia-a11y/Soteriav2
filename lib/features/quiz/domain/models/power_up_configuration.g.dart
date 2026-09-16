// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_up_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PowerUpConfiguration _$PowerUpConfigurationFromJson(
  Map<String, dynamic> json,
) => _PowerUpConfiguration(
  maxPauseDurationSeconds:
      (json['maxPauseDurationSeconds'] as num?)?.toInt() ?? 10,
  fiftyFiftyUsesPerRound:
      (json['fiftyFiftyUsesPerRound'] as num?)?.toInt() ?? 1,
  pauseTimerUsesPerRound:
      (json['pauseTimerUsesPerRound'] as num?)?.toInt() ?? 1,
  askAudienceUsesPerRound:
      (json['askAudienceUsesPerRound'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$PowerUpConfigurationToJson(
  _PowerUpConfiguration instance,
) => <String, dynamic>{
  'maxPauseDurationSeconds': instance.maxPauseDurationSeconds,
  'fiftyFiftyUsesPerRound': instance.fiftyFiftyUsesPerRound,
  'pauseTimerUsesPerRound': instance.pauseTimerUsesPerRound,
  'askAudienceUsesPerRound': instance.askAudienceUsesPerRound,
};
