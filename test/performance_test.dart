import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/core/services/diagnostics_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Performance Benchmarks', () {
    test('Startup sequence duration should be minimal', () async {
      // Mock package info for test
      PackageInfo.setMockInitialValues(
        appName: 'Soteria',
        packageName: 'com.example.soteria',
        version: '1.0.0',
        buildNumber: '1',
        buildSignature: '',
      );

      final stopwatch = Stopwatch()..start();
      await DiagnosticsService.init();
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(500), 
        reason: 'Service initialization took too long');
    });

    test('Diagnostics caching should be effective', () async {
       await DiagnosticsService.init();
       
       final stopwatch1 = Stopwatch()..start();
       await DiagnosticsService.getDiagnostics();
       stopwatch1.stop();

       final stopwatch2 = Stopwatch()..start();
       await DiagnosticsService.getDiagnostics();
       stopwatch2.stop();

       expect(stopwatch2.elapsedMicroseconds, lessThan(stopwatch1.elapsedMicroseconds),
         reason: 'Cached diagnostics should be faster');
    });
  });
}
