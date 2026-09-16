import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/firebase/providers/firebase_providers.dart';
import '../../../core/identity/providers/identity_providers.dart';
import '../domain/models/wallet.dart';
import '../domain/repositories/wallet_repository.dart';
import '../data/repositories/firestore_wallet_repository.dart';
import '../domain/services/wallet_service.dart';

// --- Repositories ---

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return FirestoreWalletRepository(
    ref.watch(firestoreDatabaseServiceProvider),
  );
});

// --- Services ---

final walletServiceProvider = Provider<WalletService>((ref) {
  return WalletService(ref.watch(walletRepositoryProvider));
});

// --- State Providers ---

/// A stream of the current user's authoritative wallet.
final currentWalletStreamProvider = StreamProvider<Wallet?>((ref) {
  final session = ref.watch(sessionProvider);

  if (!session.isAuthenticated || session.uid == null) {
    return Stream.value(null);
  }

  return ref.watch(walletServiceProvider).watchWallet(session.uid!);
});

/// A convenience provider for the current wallet balance.
final currentWalletBalanceProvider = Provider<int>((ref) {
  final wallet = ref.watch(currentWalletStreamProvider).value;
  return wallet?.balance ?? 0;
});
