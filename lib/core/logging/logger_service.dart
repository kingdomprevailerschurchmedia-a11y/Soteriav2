import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import '../firebase/services/firebase_interfaces.dart';

enum LogLevel { trace, debug, info, warning, error, critical }

class LogEntry {
  final DateTime timestamp;
  final LogLevel level;
  final String message;
  final String? feature;
  final String? route;
  final dynamic error;
  final StackTrace? stackTrace;
  final String correlationId;
  final Map<String, dynamic>? metadata;

  LogEntry({
    required this.timestamp,
    required this.level,
    required this.message,
    this.feature,
    this.route,
    this.error,
    this.stackTrace,
    required this.correlationId,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'level': level.name,
    'message': message,
    'feature': feature,
    'route': route,
    'error': error?.toString(),
    'correlationId': correlationId,
    'metadata': metadata,
  };
}

class LoggerService {
  static final _uuid = const Uuid();
  static final String _sessionId = _uuid.v4();
  static final List<LogEntry> _memoryLogs = [];
  static const int _maxMemoryLogs = 200;

  static ICrashlyticsService? _crashlytics;

  static void setCrashlytics(ICrashlyticsService crashlytics) {
    _crashlytics = crashlytics;
  }

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static final StreamController<LogEntry> _logStreamController =
      StreamController<LogEntry>.broadcast();

  static Stream<LogEntry> get logStream => _logStreamController.stream;
  static List<LogEntry> get memoryLogs => List.unmodifiable(_memoryLogs);

  static void t(
    String message, {
    String? feature,
    Map<String, dynamic>? metadata,
  }) => _log(LogLevel.trace, message, feature: feature, metadata: metadata);

  static void d(
    String message, {
    String? feature,
    Map<String, dynamic>? metadata,
  }) => _log(LogLevel.debug, message, feature: feature, metadata: metadata);

  static void i(
    String message, {
    String? feature,
    Map<String, dynamic>? metadata,
  }) => _log(LogLevel.info, message, feature: feature, metadata: metadata);

  static void w(
    String message, {
    String? feature,
    Map<String, dynamic>? metadata,
  }) => _log(LogLevel.warning, message, feature: feature, metadata: metadata);

  static void e(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    String? feature,
    Map<String, dynamic>? metadata,
  }) => _log(
    LogLevel.error,
    message,
    error: error,
    stackTrace: stackTrace,
    feature: feature,
    metadata: metadata,
  );

  static void critical(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    String? feature,
    Map<String, dynamic>? metadata,
  }) => _log(
    LogLevel.critical,
    message,
    error: error,
    stackTrace: stackTrace,
    feature: feature,
    metadata: metadata,
  );

  static void _log(
    LogLevel level,
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    String? feature,
    Map<String, dynamic>? metadata,
  }) {
    final correlationId = _uuid.v4();

    // Security Hardening: Redact sensitive information
    final redactedMessage = _redactSensitiveInfo(message);
    final redactedMetadata = metadata != null
        ? _redactMetadata(metadata)
        : null;

    final entry = LogEntry(
      timestamp: DateTime.now(),
      level: level,
      message: redactedMessage,
      feature: feature,
      error: error,
      stackTrace: stackTrace,
      correlationId: correlationId,
      metadata: {
        ...?redactedMetadata,
        'sessionId': _sessionId,
        'env': kDebugMode ? 'debug' : 'release',
      },
    );

    // Add to memory logs
    _memoryLogs.add(entry);
    if (_memoryLogs.length > _maxMemoryLogs) {
      _memoryLogs.removeAt(0);
    }

    // Broadcast
    _logStreamController.add(entry);

    // Console Output
    final logMessage = '[$feature] $redactedMessage (CID: $correlationId)';

    // Forward to Crashlytics if appropriate
    if (level == LogLevel.error || level == LogLevel.critical) {
      _crashlytics?.recordError(
        error ?? redactedMessage,
        stackTrace,
        reason: 'LogLevel: ${level.name}, Feature: $feature',
        fatal: level == LogLevel.critical,
      );
    } else {
      _crashlytics?.log(logMessage);
    }

    switch (level) {
      case LogLevel.trace:
        _logger.t(logMessage);
      case LogLevel.debug:
        _logger.d(logMessage);
      case LogLevel.info:
        _logger.i(logMessage);
      case LogLevel.warning:
        _logger.w(logMessage);
      case LogLevel.error:
        _logger.e(logMessage, error: error, stackTrace: stackTrace);
      case LogLevel.critical:
        _logger.f(logMessage, error: error, stackTrace: stackTrace);
    }
  }

  static String _redactSensitiveInfo(String text) {
    final sensitivePatterns = [
      RegExp(r'password[:=]\s*\S+', caseSensitive: false),
      RegExp(r'otp[:=]\s*\S+', caseSensitive: false),
      RegExp(r'token[:=]\s*\S+', caseSensitive: false),
      RegExp(r'secret[:=]\s*\S+', caseSensitive: false),
    ];

    String result = text;
    for (final pattern in sensitivePatterns) {
      result = result.replaceAll(pattern, '[REDACTED]');
    }
    return result;
  }

  static Map<String, dynamic> _redactMetadata(Map<String, dynamic> data) {
    const sensitiveKeys = {'password', 'otp', 'token', 'secret', 'cvv', 'pin'};
    final result = Map<String, dynamic>.from(data);

    result.forEach((key, value) {
      final lowerKey = key.toLowerCase();
      if (sensitiveKeys.any((sk) => lowerKey.contains(lowerKey))) {
        // Wait, the logic above contains a bug (lowerKey.contains(lowerKey))
      }
    });
    // Let me rewrite this more cleanly
    return result.map((key, value) {
      final isSensitive = sensitiveKeys.any(
        (sk) => key.toLowerCase().contains(sk),
      );
      return MapEntry(key, isSensitive ? '[REDACTED]' : value);
    });
  }

  static void clearLogs() {
    _memoryLogs.clear();
  }
}
