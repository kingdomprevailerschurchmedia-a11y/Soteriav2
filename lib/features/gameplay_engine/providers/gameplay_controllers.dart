import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:state_notifier/state_notifier.dart';

/// Manages the countdown timer for individual questions.
class TimerController extends StateNotifier<int> {
  Timer? _timer;
  final int initialSeconds;

  TimerController({this.initialSeconds = 30}) : super(initialSeconds);

  void start() {
    _timer?.cancel();
    state = initialSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state = state - 1;
      } else {
        stop();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }

  void reset() {
    stop();
    state = initialSeconds;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final questionTimerProvider =
    StateNotifierProvider.family<TimerController, int, int>((ref, seconds) {
      return TimerController(initialSeconds: seconds);
    });

/// Shared provider for session-wide streak tracking.
final streakProvider = StateProvider<int>((ref) => 0);

/// Shared provider for session-wide XP calculation.
final xpProvider = StateProvider<int>((ref) => 0);
