import '../models/wallet.dart';
import '../models/reward_transaction.dart';
import '../models/coin_bundle.dart';

abstract class WalletRepository {
  Future<Wallet> getWallet(String userId);
  Stream<Wallet> watchWallet(String userId);
  Future<List<RewardTransaction>> getTransactionHistory(String userId);
  
  Future<List<CoinBundle>> getCoinBundles();
  
  /// Initiates a purchase for a coin bundle.
  /// Returns a transaction ID or reference.
  Future<String> initiatePurchase(String userId, String bundleId);
  
  /// Redeems an item using wallet balance.
  Future<void> redeemItem(String userId, String itemId, int cost);
}
