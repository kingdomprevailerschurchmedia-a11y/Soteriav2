import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import 'package:soteria/core/firebase/analytics/analytics_coordinator.dart';
import 'package:soteria/core/firebase/analytics/analytics_events.dart';

import 'package:package_info_plus/package_info_plus.dart';

@GenerateMocks([IAnalyticsService, ICrashlyticsService])
import 'analytics_coordinator_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AnalyticsCoordinator coordinator;
  late MockIAnalyticsService mockAnalytics;
  late MockICrashlyticsService mockCrashlytics;

  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'Soteria',
      packageName: 'com.soteria.app',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: 'buildSignature',
    );
    mockAnalytics = MockIAnalyticsService();
    mockCrashlytics = MockICrashlyticsService();
    coordinator = AnalyticsCoordinator(mockAnalytics, mockCrashlytics);
  });

  group('AnalyticsCoordinator', () {
    test('logEvent should attach standard parameters', () async {
      final event = LoginEvent(method: 'email');

      await coordinator.logEvent(event);

      verify(
        mockAnalytics.logEvent(
          name: 'login',
          parameters: argThat(
            predicate((Map params) {
              return params['method'] == 'email' &&
                  params.containsKey('session_id');
            }),
            named: 'parameters',
          ),
        ),
      ).called(1);
    });

    test('setUserId should update both services', () async {
      await coordinator.setUserId('user-123');

      verify(mockAnalytics.setUserId('user-123')).called(1);
      verify(mockCrashlytics.setUserId('user-123')).called(1);
    });
  });
}
