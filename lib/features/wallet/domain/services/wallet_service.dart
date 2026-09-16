import '../models/wallet.dart';
import '../models/wallet_transaction.dart';
import '../models/wallet_transaction_type.dart';
import '../repositories/wallet_repository.dart';

class WalletService {
  final WalletRepository _repository;

  WalletService(this._repository);

  /// Authoritatively fetches the current wallet balance.
  Future<int> getBalance(String uid) async {
    final wallet = await _repository.getWallet(uid);
    return wallet.balance;
  }

  /// Credits coins to a user's wallet with idempotency.
  Future<WalletTransaction> creditCoins({
    required String uid,
    required int amount,
    required WalletTransactionType type,
    required String idempotencyKey,
    String? referenceId,
    Map<String, dynamic> metadata = const {},
  }) async {
    return _repository.executeTransaction(
      uid: uid,
      amount: amount,
      direction: 'credit',
      type: type,
      idempotencyKey: idempotencyKey,
      referenceId: referenceId,
      metadata: metadata,
    );
  }

  /// Debits coins from a user's wallet with idempotency and balance check.
  Future<WalletTransaction> debitCoins({
    required String uid,
    required int amount,
    required WalletTransactionType type,
    required String idempotencyKey,
    String? referenceId,
    Map<String, dynamic> metadata = const {},
  }) async {
    return _repository.executeTransaction(
      uid: uid,
      amount: amount,
      direction: 'debit',
      type: type,
      idempotencyKey: idempotencyKey,
      referenceId: referenceId,
      metadata: metadata,
    );
  }

  /// Streams the wallet for real-time UI updates.
  Stream<Wallet> watchWallet(String uid) {
    return _repository.watchWallet(uid);
  }

  /// Fetches transaction history.
  Future<List<WalletTransaction>> getHistory(String uid) {
    return _repository.getTransactionHistory(uid);
  }
}
