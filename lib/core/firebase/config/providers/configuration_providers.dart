import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/firebase_providers.dart';
import '../models/app_configuration.dart';
import '../repositories/configuration_repository.dart';
import '../repositories/firebase_configuration_repository.dart';
import '../services/configuration_coordinator.dart';

final configurationRepositoryProvider = Provider<ConfigurationRepository>((
  ref,
) {
  return FirebaseConfigurationRepository(
    ref.watch(remoteConfigServiceProvider),
  );
});

final configurationCoordinatorProvider = NotifierProvider<ConfigurationCoordinator, AppConfiguration>(
  ConfigurationCoordinator.new,
);

final configurationProvider = Provider<AppConfiguration>((ref) {
  return ref.watch(configurationCoordinatorProvider);
});

final featureFlagsProvider = Provider<FeatureConfig>((ref) {
  return ref.watch(configurationProvider).features;
});

final gameplayConfigProvider = Provider<GameplayConfig>((ref) {
  return ref.watch(configurationProvider).gameplay;
});
