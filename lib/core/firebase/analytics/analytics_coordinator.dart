import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';
import '../services/firebase_interfaces.dart';
import 'analytics_events.dart';

class AnalyticsCoordinator {
  final IAnalyticsService _analyticsService;
  final ICrashlyticsService _crashlyticsService;
  final String _sessionId = const Uuid().v4();
  PackageInfo? _packageInfo;

  AnalyticsCoordinator(
    this._analyticsService,
    this._crashlyticsService, {
    this._packageInfo,
  });

  Future<void> logEvent(SoteriaAnalyticsEvent event) async {
    if (_packageInfo == null && !kIsWeb) {
      try {
        _packageInfo = await PackageInfo.fromPlatform();
      } catch (_) {
        // Fallback for tests or environments where package info fails
      }
    }

    final standardParams = {
      'session_id': _sessionId,
      'app_version': _packageInfo?.version ?? 'unknown',
      'app_build_number': _packageInfo?.buildNumber ?? 'unknown',
      'platform': Platform.operatingSystem,
      'is_debug': kDebugMode,
    };

    final allParams = {...standardParams, ...event.parameters};

    // 1. Log to Analytics
    await _analyticsService.logEvent(name: event.name, parameters: allParams);

    // 2. Add as breadcrumb to Crashlytics
    await _crashlyticsService.log(
      'Event: ${event.name} with params: ${event.parameters}',
    );
  }

  Future<void> setUserId(String? userId) async {
    await _analyticsService.setUserId(userId);
    if (userId != null) {
      await _crashlyticsService.setUserId(userId);
    }
  }

  Future<void> setUserProperty(String name, String value) async {
    await _analyticsService.setUserProperty(name: name, value: value);
  }
}
