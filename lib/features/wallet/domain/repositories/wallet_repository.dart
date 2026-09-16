import '../models/wallet.dart';
import '../models/wallet_transaction.dart';
import '../models/wallet_transaction_type.dart';

abstract class WalletRepository {
  /// Fetches the authoritative wallet for a user.
  /// If no wallet exists, implementations should return a default empty wallet.
  Future<Wallet> getWallet(String uid);

  /// Streams the authoritative wallet for a user.
  Stream<Wallet> watchWallet(String uid);

  /// Executes an atomic economic operation (Rule #2, #13).
  /// 
  /// This must handle:
  /// 1. Concurrency (locking or atomic mutation)
  /// 2. Idempotency (checking if the idempotencyKey exists)
  /// 3. Balance verification (for debits)
  /// 4. Atomic balance + ledger update (Rule #10)
  Future<WalletTransaction> executeTransaction({
    required String uid,
    required int amount,
    required String direction,
    required WalletTransactionType type,
    required String idempotencyKey,
    String? referenceId,
    Map<String, dynamic> metadata = const {},
  });

  /// Fetches the transaction history for a user.
  Future<List<WalletTransaction>> getTransactionHistory(String uid, {int limit = 50});
}
