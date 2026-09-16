import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:soteria/features/wallet/domain/models/wallet.dart';
import 'package:soteria/features/wallet/domain/models/wallet_transaction.dart';
import 'package:soteria/features/wallet/domain/models/wallet_transaction_type.dart';
import 'package:soteria/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:soteria/features/wallet/domain/services/wallet_service.dart';

import 'wallet_service_test.mocks.dart';

@GenerateMocks([WalletRepository])
void main() {
  late WalletService walletService;
  late MockWalletRepository mockRepository;

  setUp(() {
    mockRepository = MockWalletRepository();
    walletService = WalletService(mockRepository);
  });

  group('WalletService', () {
    const userId = 'user_123';
    const idempotencyKey = 'key_456';

    test('getBalance returns balance from repository', () async {
      final wallet = Wallet(
        uid: userId,
        balance: 1000,
        updatedAt: DateTime.now(),
      );
      when(mockRepository.getWallet(userId)).thenAnswer((_) async => wallet);

      final balance = await walletService.getBalance(userId);

      expect(balance, 1000);
      verify(mockRepository.getWallet(userId)).called(1);
    });

    test('creditCoins calls repository with correct parameters', () async {
      final expectedTx = WalletTransaction(
        id: idempotencyKey,
        uid: userId,
        direction: 'credit',
        amount: 500,
        balanceBefore: 1000,
        balanceAfter: 1500,
        type: WalletTransactionType.coinPurchase,
        idempotencyKey: idempotencyKey,
        createdAt: DateTime.now(),
      );

      when(mockRepository.executeTransaction(
        uid: userId,
        amount: 500,
        direction: 'credit',
        type: WalletTransactionType.coinPurchase,
        idempotencyKey: idempotencyKey,
        referenceId: anyNamed('referenceId'),
        metadata: anyNamed('metadata'),
      )).thenAnswer((_) async => expectedTx);

      final result = await walletService.creditCoins(
        uid: userId,
        amount: 500,
        type: WalletTransactionType.coinPurchase,
        idempotencyKey: idempotencyKey,
      );

      expect(result, expectedTx);
    });

    test('debitCoins calls repository with correct parameters', () async {
      final expectedTx = WalletTransaction(
        id: idempotencyKey,
        uid: userId,
        direction: 'debit',
        amount: 200,
        balanceBefore: 1000,
        balanceAfter: 800,
        type: WalletTransactionType.proModeEntry,
        idempotencyKey: idempotencyKey,
        createdAt: DateTime.now(),
      );

      when(mockRepository.executeTransaction(
        uid: userId,
        amount: 200,
        direction: 'debit',
        type: WalletTransactionType.proModeEntry,
        idempotencyKey: idempotencyKey,
        referenceId: anyNamed('referenceId'),
        metadata: anyNamed('metadata'),
      )).thenAnswer((_) async => expectedTx);

      final result = await walletService.debitCoins(
        uid: userId,
        amount: 200,
        type: WalletTransactionType.proModeEntry,
        idempotencyKey: idempotencyKey,
      );

      expect(result, expectedTx);
    });
  Group('Wallet Verification', () {
      test('watchWallet delegates to repository', () {
        final walletStream = Stream.value(Wallet(uid: userId, balance: 100, updatedAt: DateTime.now()));
        when(mockRepository.watchWallet(userId)).thenAnswer((_) => walletStream);

        final result = walletService.watchWallet(userId);

        expect(result, walletStream);
      });
    });
  });
}
