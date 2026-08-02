import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firebase_interfaces.dart';
import '../services/firebase_analytics_service.dart';
import '../services/firebase_crashlytics_service.dart';
import '../services/firebase_performance_service.dart';
import '../analytics/analytics_coordinator.dart';
import '../performance/performance_trace_helper.dart';
import '../../logging/logger_service.dart';

final analyticsServiceProvider = Provider<IAnalyticsService>((ref) {
  return FirebaseAnalyticsService();
});

final crashlyticsServiceProvider = Provider<ICrashlyticsService>((ref) {
  final service = FirebaseCrashlyticsService();
  // Register with LoggerService
  LoggerService.setCrashlytics(service);
  return service;
});

final performanceServiceProvider = Provider<IPerformanceService>((ref) {
  return FirebasePerformanceService();
});

final analyticsCoordinatorProvider = Provider<AnalyticsCoordinator>((ref) {
  return AnalyticsCoordinator(
    ref.watch(analyticsServiceProvider),
    ref.watch(crashlyticsServiceProvider),
  );
});

final performanceTraceHelperProvider = Provider<PerformanceTraceHelper>((ref) {
  return PerformanceTraceHelper(ref.watch(performanceServiceProvider));
});

class AnalyticsConsentNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void toggle(bool enabled) => state = enabled;
}

final analyticsConsentProvider =
    NotifierProvider<AnalyticsConsentNotifier, bool>(
      AnalyticsConsentNotifier.new,
    );
