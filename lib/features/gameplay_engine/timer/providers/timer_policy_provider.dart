import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/features/gameplay_engine/timer/models/timer_policy.dart';
import 'package:soteria/features/gameplay_engine/timer/services/timer_policy_resolver.dart';

final timerPolicyProvider = Provider<TimerPolicy>((ref) {
  return TimerPolicyResolver();
});
