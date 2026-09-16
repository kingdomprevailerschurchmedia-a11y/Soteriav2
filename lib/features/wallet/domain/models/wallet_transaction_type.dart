enum WalletTransactionType {
  /// Credit from a Paystack purchase
  coinPurchase,

  /// Debit for entering a Pro Mode session
  proModeEntry,

  /// Debit for entering a tournament
  tournamentEntry,

  /// Credit for winning or placing in a tournament
  tournamentReward,

  /// Credit for completing an achievement
  achievementReward,

  /// Credit for a daily streak milestone
  streakReward,

  /// Generic bonus credit
  bonus,

  /// Refund for a failed or cancelled operation
  refund,

  /// Manual adjustment by an administrator
  adminAdjustment,

  /// Debit for a withdrawal request (if applicable)
  withdrawal,

  /// Credit for a reversed withdrawal
  withdrawalReversal;

  String get direction {
    switch (this) {
      case WalletTransactionType.coinPurchase:
      case WalletTransactionType.tournamentReward:
      case WalletTransactionType.achievementReward:
      case WalletTransactionType.streakReward:
      case WalletTransactionType.bonus:
      case WalletTransactionType.refund:
      case WalletTransactionType.adminAdjustment:
      case WalletTransactionType.withdrawalReversal:
        return 'credit';
      case WalletTransactionType.proModeEntry:
      case WalletTransactionType.tournamentEntry:
      case WalletTransactionType.withdrawal:
      case WalletTransactionType.adminAdjustment: // Can be both, but usually specified in metadata
        return 'debit';
    }
  }
}
