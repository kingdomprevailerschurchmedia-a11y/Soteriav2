import 'package:soteria/features/gameplay_engine/progression/models/progress_snapshot.dart';
import 'package:soteria/features/gameplay_engine/progression/models/progression_event.dart';

/// Represents the outcome of a progression engine processing cycle.
class ProgressionResult {
  final ProgressSnapshot before;
  final ProgressSnapshot after;
  final int scoreDelta;
  final int xpDelta;
  final List<ProgressionEvent> events;

  const ProgressionResult({
    required this.before,
    required this.after,
    required this.scoreDelta,
    required this.xpDelta,
    required this.events,
  });

  bool get leveledUp => after.level > before.level;
  bool get streakBroken => after.currentStreak == 0 && before.currentStreak > 0;
  bool get streakIncreased => after.currentStreak > before.currentStreak;
}
