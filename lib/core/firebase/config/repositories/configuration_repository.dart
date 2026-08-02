import '../models/app_configuration.dart';

abstract interface class ConfigurationRepository {
  Future<void> fetchAndActivate();
  AppConfiguration getConfiguration();
  Map<String, dynamic> getAllRawValues();
  DateTime getLastFetchTime();
}
