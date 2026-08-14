abstract class LiveOperationsRepository {
  Future<void> fetchAndActivate();
  bool getFeatureEnabled(String featureKey);
  String getStringConfig(String configKey);
  int getIntConfig(String configKey);
  Map<String, dynamic> getJsonConfig(String configKey);
}
