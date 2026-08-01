import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppDiagnostics {
  final String appVersion;
  final String buildNumber;
  final String deviceModel;
  final String osVersion;
  final String flutterMode;
  final DateTime startTime;

  AppDiagnostics({
    required this.appVersion,
    required this.buildNumber,
    required this.deviceModel,
    required this.osVersion,
    required this.flutterMode,
    required this.startTime,
  });

  Map<String, String> toMap() => {
        'App Version': appVersion,
        'Build Number': buildNumber,
        'Device': deviceModel,
        'OS Version': osVersion,
        'Build Mode': flutterMode,
        'Uptime': DateTime.now().difference(startTime).toString().split('.').first,
      };
}

class DiagnosticsService {
  static final DateTime _startTime = DateTime.now();
  static late final PackageInfo _packageInfo;
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  
  static String? _cachedDeviceModel;
  static String? _cachedOsVersion;
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    _packageInfo = await PackageInfo.fromPlatform();
    _initialized = true;
  }

  static Future<AppDiagnostics> getDiagnostics() async {
    if (_cachedDeviceModel != null && _cachedOsVersion != null) {
      return _createDiagnostics(_cachedDeviceModel!, _cachedOsVersion!);
    }

    String deviceModel = 'Unknown';
    String osVersion = 'Unknown';

    try {
      if (kIsWeb) {
        deviceModel = 'Web Browser';
        osVersion = 'Unknown';
      } else if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        deviceModel = '${androidInfo.manufacturer} ${androidInfo.model}';
        osVersion = 'Android ${androidInfo.version.release}';
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        deviceModel = iosInfo.utsname.machine;
        osVersion = 'iOS ${iosInfo.systemVersion}';
      }
    } catch (e) {
      deviceModel = 'Unknown Platform';
    }

    _cachedDeviceModel = deviceModel;
    _cachedOsVersion = osVersion;

    return _createDiagnostics(deviceModel, osVersion);
  }

  static AppDiagnostics _createDiagnostics(String model, String os) {
    return AppDiagnostics(
      appVersion: _packageInfo.version,
      buildNumber: _packageInfo.buildNumber,
      deviceModel: model,
      osVersion: os,
      flutterMode: kDebugMode ? 'Debug' : (kProfileMode ? 'Profile' : 'Release'),
      startTime: _startTime,
    );
  }

  static String get startupDuration =>
      '${DateTime.now().difference(_startTime).inMilliseconds}ms';
}
