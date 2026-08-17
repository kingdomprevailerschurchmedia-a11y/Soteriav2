import 'dart:async';
import '../../domain/models/wallet.dart';
import '../../domain/models/reward_transaction.dart';
import '../../domain/models/store_product.dart';
import '../../domain/models/reward.dart';
import '../../domain/repositories/wallet_repository.dart';

class MockWalletRepository implements WalletRepository {
  Wallet _wallet = const Wallet(
    userId: 'mock_user_1',
    coins: 12450,
    tokens: 25,
    lifetimeCoinsEarned: 15000,
    lifetimeCoinsSpent: 2550,
    isPro: true,
  );

  final List<WalletTransaction> _transactions = [
    WalletTransaction(
      id: 'tx_1',
      userId: 'mock_user_1',
      type: RewardType.coins,
      transactionType: WalletTransactionType.reward,
      direction: TransactionDirection.credit,
      amount: 100,
      source: RewardSource.achievement,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    WalletTransaction(
      id: 'tx_2',
      userId: 'mock_user_1',
      type: RewardType.tokens,
      transactionType: WalletTransactionType.purchase,
      direction: TransactionDirection.credit,
      amount: 10,
      currency: 'tokens',
      source: RewardSource.purchase,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  final StreamController<Wallet> _walletController = StreamController<Wallet>.broadcast();

  MockWalletRepository() {
    _walletController.add(_wallet);
  }

  @override
  Future<Wallet> getWallet(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _wallet.copyWith(userId: userId);
  }

  @override
  Stream<Wallet> watchWallet(String userId) {
    return _walletController.stream;
  }

  @override
  Future<List<WalletTransaction>> getTransactionHistory(String userId, {String? currency}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (currency != null) {
      return _transactions.where((t) => t.currency == currency).toList();
    }
    return _transactions;
  }

  @override
  Future<List<StoreProduct>> getStoreProducts() async {
    return [
      const StoreProduct(
        id: StoreProduct.coin100,
        name: '100 Coins',
        description: 'Starter coin pack',
        category: StoreProductCategory.coins,
        quantity: 100,
        price: 1500.00,
        currencyCode: 'NGN',
        displayPrice: '₦1,500',
        icon: '🪙',
      ),
      const StoreProduct(
        id: StoreProduct.coin550,
        name: '550 Coins',
        description: 'Great for a few matches',
        category: StoreProductCategory.coins,
        quantity: 550,
        price: 7500.00,
        currencyCode: 'NGN',
        displayPrice: '₦7,500',
        icon: '🪙',
        metadata: {'bonusPercentage': 10},
      ),
      const StoreProduct(
        id: StoreProduct.coin1200,
        name: '1,200 Coins',
        description: 'Popular choice for competitors',
        category: StoreProductCategory.coins,
        quantity: 1200,
        price: 15000.00,
        currencyCode: 'NGN',
        displayPrice: '₦15,000',
        icon: '🪙',
        isPopular: true,
        metadata: {'bonusPercentage': 20},
      ),
      const StoreProduct(
        id: StoreProduct.proMonthly,
        name: 'Soteria Pro Monthly',
        description: 'Premium competitive learning',
        category: StoreProductCategory.pro,
        quantity: 1,
        price: 15000.00,
        currencyCode: 'NGN',
        displayPrice: '₦15,000',
        icon: '💎',
      ),
    ];
  }

  @override
  Future<String> initiatePurchase(String userId, String productId) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'mock_pending_tx_${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Future<void> fulfillPurchase(String userId, String purchaseId, String verificationToken) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> spendCurrency(String userId, int amount, String currency, String source, String referenceId) async {
    await Future.delayed(const Duration(seconds: 1));
    if (currency == 'coins' && _wallet.coins < amount) throw Exception('Insufficient coins');
    if (currency == 'tokens' && _wallet.tokens < amount) throw Exception('Insufficient tokens');

    if (currency == 'coins') {
      _wallet = _wallet.copyWith(
        coins: _wallet.coins - amount,
        lifetimeCoinsSpent: _wallet.lifetimeCoinsSpent + amount,
        updatedAt: DateTime.now(),
      );
    } else {
      _wallet = _wallet.copyWith(
        tokens: _wallet.tokens - amount,
        lifetimeTokensSpent: _wallet.lifetimeTokensSpent + amount,
        updatedAt: DateTime.now(),
      );
    }
    _walletController.add(_wallet);
  }
}
