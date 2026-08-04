import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app_router.dart';
import '../services/navigation_coordinator.dart';

final navigationCoordinatorProvider = Provider<NavigationCoordinator>((ref) {
  final router = ref.watch(routerProvider);
  return NavigationCoordinator(router);
});
