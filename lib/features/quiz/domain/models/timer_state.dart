import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_state.freezed.dart';
part 'timer_state.g.dart';

@freezed
class TimerState with _$TimerState {
  const factory TimerState({
    required Duration totalDuration,
    required Duration remainingTime,
    @Default(1.0) double progress,
    @Default(false) bool isPaused,
    @Default(false) bool isRunning,
    @Default(false) bool hasExpired,
  }) = _TimerState;

  factory TimerState.initial(int seconds) => TimerState(
    totalDuration: Duration(seconds: seconds),
    remainingTime: Duration(seconds: seconds),
  );

  factory TimerState.fromJson(Map<String, dynamic> json) =>
      _$TimerStateFromJson(json);
}
