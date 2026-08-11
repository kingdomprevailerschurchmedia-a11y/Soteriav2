import 'package:freezed_annotation/freezed_annotation.dart';

part 'season_countdown.freezed.dart';

enum CountdownStatus { notStarted, active, endingSoon, ended, unavailable }

@freezed
abstract class SeasonCountdown with _$SeasonCountdown {
  const factory SeasonCountdown({
    required int days,
    required int hours,
    required int minutes,
    required int seconds,
    required Duration totalRemaining,
    required CountdownStatus status,
  }) = _SeasonCountdown;

  factory SeasonCountdown.fromDuration(
    Duration duration, {
    Duration endingSoonThreshold = const Duration(hours: 24),
  }) {
    if (duration.isNegative || duration == Duration.zero) {
      return const SeasonCountdown(
        days: 0,
        hours: 0,
        minutes: 0,
        seconds: 0,
        totalRemaining: Duration.zero,
        status: CountdownStatus.ended,
      );
    }

    final status = duration <= endingSoonThreshold
        ? CountdownStatus.endingSoon
        : CountdownStatus.active;

    return SeasonCountdown(
      days: duration.inDays,
      hours: duration.inHours % 24,
      minutes: duration.inMinutes % 60,
      seconds: duration.inSeconds % 60,
      totalRemaining: duration,
      status: status,
    );
  }

  factory SeasonCountdown.unavailable() => const SeasonCountdown(
    days: 0,
    hours: 0,
    minutes: 0,
    seconds: 0,
    totalRemaining: Duration.zero,
    status: CountdownStatus.unavailable,
  );
}
