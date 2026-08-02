import 'package:firebase_performance/firebase_performance.dart';
import 'firebase_interfaces.dart';

class FirebasePerformanceService implements IPerformanceService {
  final FirebasePerformance _performance = FirebasePerformance.instance;

  @override
  Trace newTrace(String name) {
    return _performance.newTrace(name);
  }

  @override
  Future<void> setPerformanceCollectionEnabled(bool enabled) {
    return _performance.setPerformanceCollectionEnabled(enabled);
  }
}
