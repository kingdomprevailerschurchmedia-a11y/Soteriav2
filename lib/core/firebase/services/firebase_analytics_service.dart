import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebase_interfaces.dart';

class FirebaseAnalyticsService implements IAnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
  }) {
    return _analytics.logEvent(
      name: name,
      parameters: parameters?.map(
        (key, value) => MapEntry(key, value as Object),
      ),
    );
  }

  @override
  Future<void> setUserId(String? id) {
    return _analytics.setUserId(id: id);
  }

  @override
  Future<void> setUserProperty({required String name, required String? value}) {
    return _analytics.setUserProperty(name: name, value: value);
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) {
    return _analytics.setAnalyticsCollectionEnabled(enabled);
  }
}
