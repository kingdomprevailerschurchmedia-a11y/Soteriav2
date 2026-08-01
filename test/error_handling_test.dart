import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/core/errors/soteria_exception.dart';
import 'package:soteria/core/logging/logger_service.dart';

void main() {
  group('SoteriaException Tests', () {
    test('NetworkException should have correct defaults', () {
      const ex = NetworkException();
      expect(ex.code, 'NETWORK_ERROR');
      expect(ex.message, contains('network error'));
    });

    test('UnexpectedException should be identifiable', () {
      const ex = UnexpectedException();
      expect(ex, isA<SoteriaException>());
      expect(ex.code, 'UNEXPECTED_ERROR');
    });
  });

  group('LoggerService Tests', () {
    test('Memory logs should capture events', () {
      LoggerService.clearLogs();
      LoggerService.i('Test Info');
      LoggerService.e('Test Error');

      expect(LoggerService.memoryLogs.length, 2);
      expect(LoggerService.memoryLogs[0].level, LogLevel.info);
      expect(LoggerService.memoryLogs[1].level, LogLevel.error);
    });

    test('Log levels should be correctly assigned', () {
      LoggerService.clearLogs();
      LoggerService.t('Trace');
      LoggerService.d('Debug');
      LoggerService.w('Warning');
      LoggerService.critical('Critical');

      expect(LoggerService.memoryLogs[0].level, LogLevel.trace);
      expect(LoggerService.memoryLogs[1].level, LogLevel.debug);
      expect(LoggerService.memoryLogs[2].level, LogLevel.warning);
      expect(LoggerService.memoryLogs[3].level, LogLevel.critical);
    });
  });
}
