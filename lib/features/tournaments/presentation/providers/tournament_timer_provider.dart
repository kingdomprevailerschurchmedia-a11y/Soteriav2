import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TournamentTimerNotifier extends StateNotifier<Duration> {
  Timer? _timer;
  final DateTime targetEndTime;

  TournamentTimerNotifier(this.targetEndTime) : super(Duration.zero) {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final now = DateTime.now();
      final remaining = targetEndTime.difference(now);

      if (remaining.isNegative) {
        state = Duration.zero;
        _timer?.cancel();
      } else {
        state = remaining;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final tournamentTimerProvider =
    StateNotifierProvider.family<TournamentTimerNotifier, Duration, DateTime>((
      ref,
      endTime,
    ) {
      return TournamentTimerNotifier(endTime);
    });
