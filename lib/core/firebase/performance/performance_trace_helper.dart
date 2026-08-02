import 'package:firebase_performance/firebase_performance.dart';
import '../services/firebase_interfaces.dart';

class PerformanceTraceHelper {
  final IPerformanceService _performanceService;

  PerformanceTraceHelper(this._performanceService);

  Future<T> trace<T>(
    String name,
    Future<T> Function() block, {
    Map<String, String>? attributes,
  }) async {
    final Trace trace = _performanceService.newTrace(name);

    await trace.start();

    if (attributes != null) {
      attributes.forEach((key, value) {
        trace.putAttribute(key, value);
      });
    }

    try {
      final T result = await block();
      return result;
    } finally {
      await trace.stop();
    }
  }

  Trace startTrace(String name) {
    final Trace trace = _performanceService.newTrace(name);
    trace.start();
    return trace;
  }
}
