import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tournamentCountdownProvider = StreamProvider.family<Duration, DateTime>((
  ref,
  targetDate,
) {
  return Stream.periodic(const Duration(seconds: 1), (_) {
    final now = DateTime.now();
    final difference = targetDate.difference(now);
    return difference.isNegative ? Duration.zero : difference;
  });
});
