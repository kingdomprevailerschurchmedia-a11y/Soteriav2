import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class TimeService {
  DateTime now();
  DateTime nowUtc();
}

class SystemTimeService implements TimeService {
  @override
  DateTime now() => DateTime.now();

  @override
  DateTime nowUtc() => DateTime.now().toUtc();
}

final timeServiceProvider = Provider<TimeService>((ref) {
  return SystemTimeService();
});
