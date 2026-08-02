import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'firebase_interfaces.dart';

class FirebaseCrashlyticsService implements ICrashlyticsService {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  @override
  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    bool fatal = false,
  }) {
    return _crashlytics.recordError(
      exception,
      stack,
      reason: reason,
      fatal: fatal,
    );
  }

  @override
  Future<void> log(String message) {
    return _crashlytics.log(message);
  }

  @override
  Future<void> setCustomKey(String key, Object value) {
    return _crashlytics.setCustomKey(key, value);
  }

  @override
  Future<void> setUserId(String identifier) {
    return _crashlytics.setUserIdentifier(identifier);
  }
}
