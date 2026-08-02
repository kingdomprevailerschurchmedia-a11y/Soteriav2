import 'package:flutter/foundation.dart';

@immutable
class DeviceIdentity {
  final String deviceId;
  final String model;
  final String os;
  final String osVersion;
  final DateTime lastVerifiedAt;

  const DeviceIdentity({
    required this.deviceId,
    required this.model,
    required this.os,
    required this.osVersion,
    required this.lastVerifiedAt,
  });
}
