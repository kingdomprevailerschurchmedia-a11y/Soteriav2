import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../domain/repositories/post_game_repository.dart';
import '../../../core/logging/logger_service.dart';

class SyncService {
  final PostGameRepository _repository;
  final Connectivity _connectivity;
  StreamSubscription? _connectivitySubscription;

  SyncService(this._repository, this._connectivity);

  void initialize() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      status,
    ) {
      if (status.isNotEmpty && !status.contains(ConnectivityResult.none)) {
        _processQueue();
      }
    });
  }

  Future<void> _processQueue() async {
    final queue = await _repository.getOfflineSyncQueue();
    if (queue.isEmpty) return;

    LoggerService.i(
      'SyncService: Processing ${queue.length} offline sessions.',
      feature: 'Sync',
    );

    for (final result in queue) {
      try {
        await _repository.syncProgress(result);
        await _repository.removeFromSyncQueue(result.sessionId);
        LoggerService.i(
          'SyncService: Session ${result.sessionId} synced successfully.',
          feature: 'Sync',
        );
      } catch (e) {
        LoggerService.e(
          'SyncService: Failed to sync session ${result.sessionId}: $e',
          feature: 'Sync',
        );
        // Stop processing on error to avoid repeated failures in this cycle
        break;
      }
    }
  }

  void dispose() {
    _connectivitySubscription?.cancel();
  }
}
