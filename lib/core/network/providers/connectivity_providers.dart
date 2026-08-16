import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the current connectivity status stream
final connectivityProvider = StreamProvider<List<ConnectivityResult>>((ref) {
  return Connectivity().onConnectivityChanged;
});

/// Provides a simple boolean for online status
final isOnlineProvider = Provider<bool>((ref) {
  final connectivity = ref.watch(connectivityProvider);
  
  return connectivity.maybeWhen(
    data: (results) {
      if (results.isEmpty) return false;
      // If any result is NOT none, we are considered online
      return !results.contains(ConnectivityResult.none);
    },
    // Default to true while loading to avoid flickering, 
    // or we could use a synchronous check for the initial value.
    orElse: () => true, 
  );
});
