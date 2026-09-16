// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimerState _$TimerStateFromJson(Map<String, dynamic> json) => _TimerState(
  totalDuration: Duration(microseconds: (json['totalDuration'] as num).toInt()),
  remainingTime: Duration(microseconds: (json['remainingTime'] as num).toInt()),
  progress: (json['progress'] as num?)?.toDouble() ?? 1.0,
  isPaused: json['isPaused'] as bool? ?? false,
  isRunning: json['isRunning'] as bool? ?? false,
  hasExpired: json['hasExpired'] as bool? ?? false,
  status:
      $enumDecodeNullable(_$TimerStatusEnumMap, json['status']) ??
      TimerStatus.idle,
  deadline: json['deadline'] == null
      ? null
      : DateTime.parse(json['deadline'] as String),
  isWarning: json['isWarning'] as bool? ?? false,
  isCritical: json['isCritical'] as bool? ?? false,
);

Map<String, dynamic> _$TimerStateToJson(_TimerState instance) =>
    <String, dynamic>{
      'totalDuration': instance.totalDuration.inMicroseconds,
      'remainingTime': instance.remainingTime.inMicroseconds,
      'progress': instance.progress,
      'isPaused': instance.isPaused,
      'isRunning': instance.isRunning,
      'hasExpired': instance.hasExpired,
      'status': _$TimerStatusEnumMap[instance.status]!,
      'deadline': instance.deadline?.toIso8601String(),
      'isWarning': instance.isWarning,
      'isCritical': instance.isCritical,
    };

const _$TimerStatusEnumMap = {
  TimerStatus.idle: 'idle',
  TimerStatus.running: 'running',
  TimerStatus.warning: 'warning',
  TimerStatus.critical: 'critical',
  TimerStatus.paused: 'paused',
  TimerStatus.expired: 'expired',
};
