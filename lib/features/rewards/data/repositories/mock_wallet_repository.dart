import 'dart:async';
import '../../domain/models/wallet.dart';
import '../../domain/models/reward_transaction.dart';
import '../../domain/models/coin_bundle.dart';
import '../../domain/models/reward.dart';
import '../../domain/repositories/wallet_repository.dart';

class MockWalletRepository implements WalletRepository {
  Wallet _wallet = const Wallet(
    coins: 12450,
    lifetimeCoinsEarned: 15000,
    lifetimeCoinsSpent: 2550,
  );

  final List<RewardTransaction> _transactions = [
    RewardTransaction(
      id: 'tx_1',
      userId: 'user_1',
      type: RewardType.coins,
      direction: TransactionDirection.credit,
      amount: 100,
      source: RewardSource.achievement,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    RewardTransaction(
      id: 'tx_2',
      userId: 'user_1',
      type: RewardType.coins,
      direction: TransactionDirection.credit,
      amount: 250,
      source: RewardSource.streak,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    RewardTransaction(
      id: 'tx_3',
      userId: 'user_1',
      type: RewardType.coins,
      direction: TransactionDirection.debit,
      amount: 100,
      source: RewardSource.tournament,
      referenceId: 'tourney_entry_1',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      metadata: {'action': 'entry_fee'},
    ),
  ];

  final StreamController<Wallet> _walletController = StreamController<Wallet>.broadcast();

  MockWalletRepository() {
    _walletController.add(_wallet);
  }

  @override
  Future<Wallet> getWallet(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _wallet;
  }

  @override
  Stream<Wallet> watchWallet(String userId) {
    return _walletController.stream;
  }

  @override
  Future<List<RewardTransaction>> getTransactionHistory(String userId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _transactions;
  }

  @override
  Future<List<CoinBundle>> getCoinBundles() async {
    return [
      const CoinBundle(
        id: 'bundle_starter',
        name: 'Starter',
        coins: 500,
        price: 4.99,
        icon: '🪙',
        displayPrice: '\$4.99',
      ),
      const CoinBundle(
        id: 'bundle_pro',
        name: 'Pro',
        coins: 2000,
        bonusCoins: 200,
        price: 14.99,
        icon: '💰',
        featured: true,
        displayPrice: '\$14.99',
      ),
      const CoinBundle(
        id: 'bundle_elite',
        name: 'Elite',
        coins: 5000,
        bonusCoins: 1000,
        price: 29.99,
        icon: '💎',
        displayPrice: '\$29.99',
      ),
    ];
  }

  @override
  Future<String> initiatePurchase(String userId, String bundleId) async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulate successful purchase
    final bundles = await getCoinBundles();
    final bundle = bundles.firstWhere((b) => b.id == bundleId);
    
    _wallet = _wallet.copyWith(
      coins: _wallet.coins + bundle.coins + bundle.bonusCoins,
      lifetimeCoinsEarned: _wallet.lifetimeCoinsEarned + bundle.coins + bundle.bonusCoins,
      updatedAt: DateTime.now(),
    );
    _walletController.add(_wallet);
    
    return 'mock_tx_${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Future<void> redeemItem(String userId, String itemId, int cost) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_wallet.coins < cost) {
      throw Exception('Insufficient balance');
    }
    
    _wallet = _wallet.copyWith(
      coins: _wallet.coins - cost,
      lifetimeCoinsSpent: _wallet.lifetimeCoinsSpent + cost,
      updatedAt: DateTime.now(),
    );
    _walletController.add(_wallet);
  }
}
