import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:soteria/core/firebase/exceptions/firebase_exceptions.dart';

void main() {
  group('FirebaseExceptionMapper', () {
    test('should map network-request-failed to NetworkException', () {
      final firebaseException = FirebaseException(
        plugin: 'cloud_firestore',
        code: 'network-request-failed',
        message: 'A network error occurred',
      );

      final result = FirebaseExceptionMapper.map(firebaseException);

      expect(result, isA<NetworkException>());
      expect(result.code, 'network-request-failed');
    });

    test('should map firestore errors to DatabaseException', () {
      final firebaseException = FirebaseException(
        plugin: 'cloud_firestore',
        code: 'permission-denied',
        message: 'Insufficient permissions',
      );

      final result = FirebaseExceptionMapper.map(firebaseException);

      expect(result, isA<DatabaseException>());
      expect(result.code, 'permission-denied');
    });

    test('should return DatabaseException for unknown errors', () {
      final error = 'Random error string';

      final result = FirebaseExceptionMapper.map(error);

      expect(result, isA<DatabaseException>());
      expect(result.message, contains('Random error string'));
    });
  });
}
