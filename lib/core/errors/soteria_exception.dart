import 'package:flutter/foundation.dart';

@immutable
sealed class SoteriaException implements Exception {
  final String message;
  final dynamic originalError;
  final StackTrace? stackTrace;
  final String? code;

  const SoteriaException({
    required this.message,
    this.originalError,
    this.stackTrace,
    this.code,
  });

  @override
  String toString() =>
      'SoteriaException: $message ${code != null ? '[$code]' : ''}';
}

class NetworkException extends SoteriaException {
  const NetworkException({
    super.message = 'A network error occurred. Please check your connection.',
    super.originalError,
    super.stackTrace,
    super.code = 'NETWORK_ERROR',
  });
}

class AuthenticationException extends SoteriaException {
  const AuthenticationException({
    super.message = 'Authentication failed. Please sign in again.',
    super.originalError,
    super.stackTrace,
    super.code = 'AUTH_ERROR',
  });
}

class ValidationException extends SoteriaException {
  const ValidationException({
    required super.message,
    super.originalError,
    super.stackTrace,
    super.code = 'VALIDATION_ERROR',
  });
}

class NavigationException extends SoteriaException {
  const NavigationException({
    required super.message,
    super.originalError,
    super.stackTrace,
    super.code = 'NAVIGATION_ERROR',
  });
}

class StorageException extends SoteriaException {
  const StorageException({
    super.message = 'Failed to access local storage.',
    super.originalError,
    super.stackTrace,
    super.code = 'STORAGE_ERROR',
  });
}

class PermissionException extends SoteriaException {
  const PermissionException({
    super.message = 'Permission denied.',
    super.originalError,
    super.stackTrace,
    super.code = 'PERMISSION_ERROR',
  });
}

class ConfigurationException extends SoteriaException {
  const ConfigurationException({
    required super.message,
    super.originalError,
    super.stackTrace,
    super.code = 'CONFIG_ERROR',
  });
}

class TimeoutException extends SoteriaException {
  const TimeoutException({
    super.message = 'The request timed out. Please try again.',
    super.originalError,
    super.stackTrace,
    super.code = 'TIMEOUT_ERROR',
  });
}

class UnexpectedException extends SoteriaException {
  const UnexpectedException({
    super.message = 'An unexpected error occurred.',
    super.originalError,
    super.stackTrace,
    super.code = 'UNEXPECTED_ERROR',
  });
}

class UnknownException extends SoteriaException {
  const UnknownException({
    super.message = 'An unknown error occurred.',
    super.originalError,
    super.stackTrace,
    super.code = 'UNKNOWN_ERROR',
  });
}
