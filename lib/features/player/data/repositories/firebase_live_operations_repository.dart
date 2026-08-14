import 'dart:convert';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import '../../domain/repositories/live_operations_repository.dart';

class FirebaseLiveOperationsRepository implements LiveOperationsRepository {
  final IRemoteConfigService _remoteConfig;

  FirebaseLiveOperationsRepository(this._remoteConfig);

  @override
  Future<void> fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }

  @override
  bool getFeatureEnabled(String featureKey) {
    return _remoteConfig.getBool(featureKey);
  }

  @override
  String getStringConfig(String configKey) {
    return _remoteConfig.getString(configKey);
  }

  @override
  int getIntConfig(String configKey) {
    return _remoteConfig.getInt(configKey);
  }

  @override
  Map<String, dynamic> getJsonConfig(String configKey) {
    final value = _remoteConfig.getString(configKey);
    if (value.isEmpty) return {};
    try {
      return json.decode(value) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }
}
