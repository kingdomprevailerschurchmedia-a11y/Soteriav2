import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/firebase_config.dart';
import '../models/security_status.dart';
import '../services/security_coordinator.dart';

final securityCoordinatorProvider = Provider<SecurityCoordinator>((ref) {
  final env = FirebaseConfig.fromEnvironment().environment;
  final coordinator = SecurityCoordinator(env);
  ref.onDispose(coordinator.dispose);
  return coordinator;
});

final securityStatusProvider = StreamProvider<SecurityStatus>((ref) {
  return ref.watch(securityCoordinatorProvider).statusStream;
});

final currentSecurityStatusProvider = Provider<SecurityStatus>((ref) {
  return ref.watch(securityStatusProvider).valueOrNull ??
      ref.read(securityCoordinatorProvider).currentStatus;
});
