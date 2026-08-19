import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/wallet.dart';
import '../../domain/models/reward_transaction.dart';
import '../../domain/models/store_product.dart';
import '../../domain/models/reward.dart';
import '../../domain/repositories/wallet_repository.dart';

class FirestoreWalletRepository implements WalletRepository {
  final FirebaseFirestore _firestore;

  FirestoreWalletRepository(this._firestore);

  @override
  Future<Wallet> getWallet(String userId) async {
    final doc = await _firestore.collection('wallets').doc(userId).get();
    if (!doc.exists) {
      // Check legacy users collection if needed, or just return empty
      return Wallet.empty(userId);
    }
    
    return _mapFirestoreToWallet(doc);
  }

  @override
  Stream<Wallet> watchWallet(String userId) {
    return _firestore.collection('wallets').doc(userId).snapshots().map((doc) {
      if (!doc.exists) return Wallet.empty(userId);
      return _mapFirestoreToWallet(doc);
    });
  }

  Wallet _mapFirestoreToWallet(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    // Convert Firestore Timestamps to ISO 8601 strings for model parsing
    final mappedData = Map<String, dynamic>.from(data);
    
    if (data['proExpiresAt'] is Timestamp) {
      mappedData['proExpiresAt'] = (data['proExpiresAt'] as Timestamp).toDate().toIso8601String();
    }
    
    if (data['updatedAt'] is Timestamp) {
      mappedData['updatedAt'] = (data['updatedAt'] as Timestamp).toDate().toIso8601String();
    }

    return Wallet.fromJson({
      ...mappedData,
      'userId': doc.id,
    });
  }

  @override
  Future<List<WalletTransaction>> getTransactionHistory(String userId, {String? currency}) async {
    var query = _firestore
        .collection('wallet_transactions')
        .where('userId', isEqualTo: userId);
    
    if (currency != null) {
      query = query.where('currency', isEqualTo: currency);
    }

    final snapshot = await query
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      
      final mappedData = Map<String, dynamic>.from(data);
      
      // Map 'currency' to 'type' for RewardType enum compatibility
      if (mappedData['type'] == null && mappedData['currency'] != null) {
        mappedData['type'] = mappedData['currency'];
      }
      
      // Ensure 'transactionType' is valid or fallback
      final validTransactionTypes = [
        'purchase', 'gameEntry', 'tournamentEntry', 'reward', 
        'refund', 'adminGrant', 'promotion', 'spend', 'itemRedemption'
      ];
      if (!validTransactionTypes.contains(mappedData['transactionType'])) {
        mappedData['transactionType'] = 'reward'; // Default fallback
      }

      // Handle Timestamp parsing safely
      String createdAtStr;
      if (data['createdAt'] is Timestamp) {
        createdAtStr = (data['createdAt'] as Timestamp).toDate().toIso8601String();
      } else if (data['createdAt'] is String) {
        createdAtStr = data['createdAt'];
      } else {
        createdAtStr = DateTime.now().toIso8601String();
      }
      
      return WalletTransaction.fromJson({
        ...mappedData,
        'id': doc.id,
        'createdAt': createdAtStr,
      });
    }).toList();
  }

  @override
  Future<List<StoreProduct>> getStoreProducts() async {
    // In a real app, this might come from Firestore or platform billing
    // Here we provide the canonical product definitions
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
      ),
      // ... Add others as needed
      const StoreProduct(
        id: StoreProduct.token25,
        name: '25 Tokens',
        description: 'Competitive access pack',
        category: StoreProductCategory.tokens,
        quantity: 25,
        price: 7500.00,
        currencyCode: 'NGN',
        displayPrice: '₦7,500',
        icon: '🎟️',
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
    final purchaseRef = _firestore.collection('purchases').doc();
    await purchaseRef.set({
      'userId': userId,
      'productId': productId,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
    return purchaseRef.id;
  }

  @override
  Future<void> fulfillPurchase(String userId, String purchaseId, String verificationToken) async {
    final purchaseRef = _firestore.collection('purchases').doc(purchaseId);
    final walletRef = _firestore.collection('wallets').doc(userId);
    final userRef = _firestore.collection('users').doc(userId);
    final gameProfileRef = _firestore.collection('user_game_profiles').doc(userId);
    final txRef = _firestore.collection('wallet_transactions').doc();

    await _firestore.runTransaction((transaction) async {
      // 1. ALL READS FIRST
      final purchaseSnapshot = await transaction.get(purchaseRef);
      if (!purchaseSnapshot.exists) throw Exception('Purchase not found');
      
      final purchaseData = purchaseSnapshot.data()!;
      if (purchaseData['status'] == 'completed') return; // Already fulfilled

      final productId = purchaseData['productId'] as String;
      final product = (await getStoreProducts()).firstWhere(
        (p) => p.id == productId,
        orElse: () => throw Exception('Product not found'),
      );

      final amount = product.quantity;
      final currency = product.category == StoreProductCategory.tokens ? 'tokens' : 'coins';
      final balanceField = currency == 'tokens' ? 'tokens' : 'coins';
      final earnedField = currency == 'tokens' ? 'lifetimeTokensEarned' : 'lifetimeCoinsEarned';

      // 2. LOGIC & VALIDATION
      // (Verification token would be checked here in a real production app)

      // 3. ALL WRITES AFTER
      
      // Update Purchase status
      transaction.update(purchaseRef, {
        'status': 'completed',
        'verificationToken': verificationToken,
        'fulfilledAt': FieldValue.serverTimestamp(),
      });

      // Update Wallet
      transaction.set(walletRef, {
        balanceField: FieldValue.increment(amount),
        earnedField: FieldValue.increment(amount),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Update User (Gameplay)
      transaction.update(userRef, {
        balanceField: FieldValue.increment(amount),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update User Game Profile (Identity)
      transaction.set(gameProfileRef, {
        balanceField: FieldValue.increment(amount),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Log Transaction
      transaction.set(txRef, {
        'userId': userId,
        'type': currency,
        'currency': currency,
        'direction': 'credit',
        'amount': amount,
        'transactionType': 'purchase',
        'source': 'purchase',
        'referenceId': purchaseId,
        'status': 'completed',
        'createdAt': FieldValue.serverTimestamp(),
        'metadata': {
          'productId': productId,
          'description': 'Purchase: ${product.name}',
        },
      });
    });
  }

  @override
  Future<void> spendCurrency(String userId, int amount, String currency, String source, String referenceId) async {
    final walletRef = _firestore.collection('wallets').doc(userId);
    final userRef = _firestore.collection('users').doc(userId);
    final gameProfileRef = _firestore.collection('user_game_profiles').doc(userId);
    final txRef = _firestore.collection('wallet_transactions').doc();
    
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(walletRef);
      if (!snapshot.exists) throw Exception('Wallet not found');
      
      final data = snapshot.data()!;
      final currentBalance = (currency == 'coins') 
          ? (data['coins'] ?? 0) 
          : (data['tokens'] ?? 0);
          
      if (currentBalance < amount) throw Exception('Insufficient $currency');
      
      final balanceField = (currency == 'coins') ? 'coins' : 'tokens';
      final spentField = (currency == 'coins') ? 'lifetimeCoinsSpent' : 'lifetimeTokensSpent';

      // 1. Update Wallet collection
      transaction.update(walletRef, {
        balanceField: FieldValue.increment(-amount),
        spentField: FieldValue.increment(amount),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // 2. Sync to Users collection (Authoritative for Gameplay)
      transaction.update(userRef, {
        balanceField: FieldValue.increment(-amount),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // 3. Sync to User Game Profiles (Identity)
      transaction.set(gameProfileRef, {
        balanceField: FieldValue.increment(-amount),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      transaction.set(txRef, {
        'userId': userId,
        'type': currency, // Added for model consistency
        'currency': currency,
        'direction': 'debit',
        'amount': amount,
        'transactionType': 'spend',
        'source': source,
        'referenceId': referenceId,
        'status': 'completed',
        'createdAt': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Future<void> creditCurrency({
    required String userId,
    required int amount,
    required String currency,
    required String source,
    required String referenceId,
    String? description,
  }) async {
    final walletRef = _firestore.collection('wallets').doc(userId);
    final userRef = _firestore.collection('users').doc(userId);
    final gameProfileRef = _firestore.collection('user_game_profiles').doc(userId);
    final txRef = _firestore.collection('wallet_transactions').doc();

    await _firestore.runTransaction((transaction) async {
      final balanceField = (currency == 'coins') ? 'coins' : 'tokens';
      final earnedField = (currency == 'coins') ? 'lifetimeCoinsEarned' : 'lifetimeTokensEarned';

      // 1. Update Wallet
      transaction.set(walletRef, {
        balanceField: FieldValue.increment(amount),
        earnedField: FieldValue.increment(amount),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // 2. Update User (Gameplay)
      transaction.update(userRef, {
        balanceField: FieldValue.increment(amount),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // 3. Update User Game Profile (Identity)
      transaction.set(gameProfileRef, {
        balanceField: FieldValue.increment(amount),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // 4. Log Transaction
      transaction.set(txRef, {
        'userId': userId,
        'type': currency, // Added for model consistency
        'currency': currency,
        'direction': 'credit',
        'amount': amount,
        'transactionType': 'reward',
        'source': source,
        'referenceId': referenceId,
        'status': 'completed',
        'createdAt': FieldValue.serverTimestamp(),
        'metadata': {
          'description': description ?? 'Currency credited',
        },
      });
    });
  }
}