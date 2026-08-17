import '../models/wallet.dart';
import '../models/reward_transaction.dart';
import '../models/store_product.dart';

abstract class WalletRepository {
  Future<Wallet> getWallet(String userId);
  Stream<Wallet> watchWallet(String userId);
  Future<List<WalletTransaction>> getTransactionHistory(String userId, {String? currency});
  
  Future<List<StoreProduct>> getStoreProducts();
  
  /// Initiates a purchase for a store product.
  /// Returns a transaction ID or reference.
  Future<String> initiatePurchase(String userId, String productId);
  
  /// Processes a successful platform purchase.
  Future<void> fulfillPurchase(String userId, String purchaseId, String verificationToken);
  
  /// Redeems an item using wallet balance.
  Future<void> spendCurrency(String userId, int amount, String currency, String source, String referenceId);

  /// Credits currency to the user's wallet and syncs with profile.
  Future<void> creditCurrency({
    required String userId,
    required int amount,
    required String currency,
    required String source,
    required String referenceId,
    String? description,
  });
}
