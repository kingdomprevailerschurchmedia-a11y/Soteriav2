import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_enums.dart';

part 'timer_state.freezed.dart';
part 'timer_state.g.dart';

@freezed
abstract class TimerState with _$TimerState {
  const factory TimerState({
    required Duration totalDuration,
    required Duration remainingTime,
    @Default(1.0) double progress,
    @Default(false) bool isPaused,
    @Default(false) bool isRunning,
    @Default(false) bool hasExpired,
    @Default(TimerStatus.idle) TimerStatus status,
    DateTime? deadline,
    @Default(false) bool isWarning,
    @Default(false) bool isCritical,
  }) = _TimerState;

  factory TimerState.initial(int seconds) => TimerState(
    totalDuration: Duration(seconds: seconds),
    remainingTime: Duration(seconds: seconds),
    status: TimerStatus.idle,
  );

  factory TimerState.fromJson(Map<String, dynamic> json) =>
      _$TimerStateFromJson(json);
}
