import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/firebase/services/firebase_interfaces.dart';
import '../../../../core/logging/logger_service.dart';
import '../../domain/models/wallet.dart';
import '../../domain/models/wallet_transaction.dart';
import '../../domain/models/wallet_transaction_type.dart';
import '../../domain/repositories/wallet_repository.dart';

class FirestoreWalletRepository implements WalletRepository {
  final IDatabaseService _database;

  FirestoreWalletRepository(this._database);

  @override
  Future<Wallet> getWallet(String uid) async {
    final doc = await _database.collection('wallets').doc(uid).get();
    if (!doc.exists) {
      return Wallet(
        uid: uid,
        balance: 0,
        updatedAt: DateTime.now(),
      );
    }
    return Wallet.fromJson(doc.data()!);
  }

  @override
  Stream<Wallet> watchWallet(String uid) {
    return _database.collection('wallets').doc(uid).snapshots().map((doc) {
      if (!doc.exists) {
        return Wallet(
          uid: uid,
          balance: 0,
          updatedAt: DateTime.now(),
        );
      }
      return Wallet.fromJson(doc.data()!);
    });
  }

  @override
  Future<WalletTransaction> executeTransaction({
    required String uid,
    required int amount,
    required String direction,
    required WalletTransactionType type,
    required String idempotencyKey,
    String? referenceId,
    Map<String, dynamic> metadata = const {},
  }) async {
    try {
      return await _database.instance.runTransaction<WalletTransaction>((transaction) async {
        final walletRef = _database.collection('wallets').doc(uid);
        final txRef = _database.collection('wallet_transactions').doc(idempotencyKey);
        final userRef = _database.collection('users').doc(uid);

        // 1. ATOMIC READS
        final walletDoc = await transaction.get(walletRef);
        final existingTxDoc = await transaction.get(txRef);
        final userDoc = await transaction.get(userRef);

        // 2. IDEMPOTENCY CHECK (Rule #5)
        if (existingTxDoc.exists) {
          LoggerService.i(
            'Transaction with idempotencyKey $idempotencyKey already exists. Returning existing record.',
            feature: 'Wallet',
          );
          return WalletTransaction.fromJson(existingTxDoc.data()!);
        }

        // 3. BALANCE VERIFICATION (Rule #2.4)
        int currentBalance = 0;
        if (walletDoc.exists) {
          currentBalance = walletDoc.data()?['balance'] ?? 0;
        } else if (userDoc.exists) {
          // Fallback to user document during migration (Rule #18.2)
          currentBalance = userDoc.data()?['coins'] ?? 0;
        }

        if (direction == 'debit' && currentBalance < amount) {
          throw Exception('Insufficient funds: $currentBalance < $amount');
        }

        // 4. PREPARE MUTATION
        final int balanceBefore = currentBalance;
        final int balanceAfter = direction == 'credit' 
            ? currentBalance + amount 
            : currentBalance - amount;

        final newTx = WalletTransaction(
          id: idempotencyKey, // Using idempotencyKey as doc ID for strict uniqueness
          uid: uid,
          direction: direction,
          amount: amount,
          balanceBefore: balanceBefore,
          balanceAfter: balanceAfter,
          type: type,
          referenceId: referenceId,
          idempotencyKey: idempotencyKey,
          status: 'completed',
          metadata: metadata,
          createdAt: DateTime.now(),
          processedAt: DateTime.now(),
        );

        // 5. ATOMIC WRITES (Rule #10)
        
        // Update authoritative wallet
        transaction.set(walletRef, {
          'uid': uid,
          'balance': balanceAfter,
          'lastTransactionId': idempotencyKey,
          'updatedAt': FieldValue.serverTimestamp(),
          'version': FieldValue.increment(1),
        }, SetOptions(merge: true));

        // Create ledger entry
        transaction.set(txRef, {
          ...newTx.toJson(),
          'createdAt': FieldValue.serverTimestamp(),
          'processedAt': FieldValue.serverTimestamp(),
        });

        // 6. SYNC TO USER DOCUMENT (Backward Compatibility/Redundancy)
        // We keep this for now to avoid breaking existing features like Pro Mode
        // that still look at the 'users' collection.
        if (userDoc.exists) {
          transaction.update(userRef, {
            'coins': balanceAfter,
            'lastCoinTransactionId': idempotencyKey,
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }

        LoggerService.i(
          'Successfully executed ${direction} of $amount coins for user $uid. New balance: $balanceAfter',
          feature: 'Wallet',
        );

        return newTx;
      });
    } catch (e, stack) {
      LoggerService.e(
        'Failed to execute wallet transaction',
        error: e,
        stackTrace: stack,
        feature: 'Wallet',
      );
      rethrow;
    }
  }

  @override
  Future<List<WalletTransaction>> getTransactionHistory(String uid, {int limit = 50}) async {
    final query = await _database
        .collection('wallet_transactions')
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();

    return query.docs
        .map((doc) => WalletTransaction.fromJson(doc.data()))
        .toList();
  }
}
