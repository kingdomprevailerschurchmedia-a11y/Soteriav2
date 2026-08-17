import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../player/providers/player_providers.dart';
import '../../../../core/identity/providers/identity_providers.dart';
import '../../../../core/firebase/providers/firebase_providers.dart';

final dailyBonusProvider = NotifierProvider<DailyBonusNotifier, DailyBonusState>(DailyBonusNotifier.new);

class DailyBonusState {
  final DateTime? lastClaimTime;
  final bool isClaiming;

  DailyBonusState({this.lastClaimTime, this.isClaiming = false});

  bool get canClaim {
    if (isClaiming) return false;
    return !isAlreadyClaimedToday;
  }

  bool get isAlreadyClaimedToday {
    if (lastClaimTime == null) return false;
    final now = DateTime.now();
    return _isSameDay(lastClaimTime!, now);
  }

  static bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  Duration get nextClaimIn {
    if (lastClaimTime == null) return Duration.zero;
    final now = DateTime.now();
    final nextClaim = DateTime(
      lastClaimTime!.year,
      lastClaimTime!.month,
      lastClaimTime!.day,
    ).add(const Duration(days: 1));
    final diff = nextClaim.difference(now);
    return diff.isNegative ? Duration.zero : diff;
  }

  DailyBonusState copyWith({DateTime? lastClaimTime, bool? isClaiming}) {
    return DailyBonusState(
      lastClaimTime: lastClaimTime ?? this.lastClaimTime,
      isClaiming: isClaiming ?? this.isClaiming,
    );
  }
}

class DailyBonusNotifier extends Notifier<DailyBonusState> {
  @override
  DailyBonusState build() {
    // We use ref.listen instead of ref.watch to prevent the entire Notifier from 
    // being destroyed and recreated when the player profile updates.
    // This allows us to maintain the 'isClaiming' state across profile refreshes.
    final initialPlayer = ref.read(currentPlayerProvider);

    ref.listen(currentPlayerProvider, (previous, next) {
      if (next == null) {
        state = DailyBonusState();
        return;
      }

      final now = DateTime.now();
      final lastClaim = next.lastDailyRewardClaim;
      final isActuallyClaimedToday =
          lastClaim != null && DailyBonusState._isSameDay(lastClaim, now);

      // We update the state if:
      // 1. It's newly confirmed as claimed today in Firestore.
      // 2. We don't have a claim time yet.
      // 3. We aren't currently claiming (preventing flickering/reversion).
      if (isActuallyClaimedToday ||
          state.lastClaimTime == null ||
          !state.isClaiming) {
        state = state.copyWith(
          lastClaimTime: lastClaim,
          isClaiming: isActuallyClaimedToday ? false : state.isClaiming,
        );
      }
    });

    return DailyBonusState(lastClaimTime: initialPlayer?.lastDailyRewardClaim);
  }

  Future<void> claim() async {
    // Double-check to prevent race conditions or rapid double-taps
    if (state.isAlreadyClaimedToday || state.isClaiming) return;

    state = state.copyWith(isClaiming: true);

    try {
      final session = ref.read(sessionProvider);
      if (!session.isAuthenticated || session.uid == null) {
        throw Exception('Must be logged in to claim rewards');
      }

      final now = DateTime.now();
      final db = ref.read(firestoreDatabaseServiceProvider);
      final userRef = db.collection('users').doc(session.uid!);
      final walletRef = db.collection('wallets').doc(session.uid!);
      final gameProfileRef = db.collection('user_game_profiles').doc(session.uid!);
      final txRef = db.collection('wallet_transactions').doc();

      // Authoritative update in Firestore via Transaction for consistency
      await db.instance.runTransaction((transaction) async {
        final userSnap = await transaction.get(userRef);
        if (userSnap.exists) {
          final data = userSnap.data()!;
          final lastClaim = data['lastDailyRewardClaim'];
          if (lastClaim != null) {
            final lastClaimDate = (lastClaim as Timestamp).toDate();
            if (DailyBonusState._isSameDay(lastClaimDate, now)) {
              throw Exception('Reward already claimed today');
            }
          }
        }

        // 1. Update Profile coins
        transaction.set(
          userRef,
          {
            'coins': FieldValue.increment(100),
            'lastDailyRewardClaim': Timestamp.fromDate(now),
            'lastCoinTransactionId': txRef.id,
            'updatedAt': Timestamp.fromDate(now),
          },
          SetOptions(merge: true),
        );

        // 2. Sync Wallet coins (used by Rewards screen)
        transaction.set(walletRef, {
          'coins': FieldValue.increment(100),
          'lifetimeCoinsEarned': FieldValue.increment(100),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        // 3. Sync User Game Profile (Identity)
        transaction.set(gameProfileRef, {
          'coins': FieldValue.increment(100),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        // 4. Log transaction
        transaction.set(txRef, {
          'userId': session.uid,
          'currency': 'coins',
          'direction': 'credit',
          'amount': 100,
          'transactionType': 'dailyReward',
          'source': 'dailyLogin',
          'status': 'completed',
          'createdAt': FieldValue.serverTimestamp(),
          'metadata': {'claimDate': now.toIso8601String()},
        });
      });

      // We don't reset isClaiming here immediately because we want to wait 
      // for the Firestore stream to reflect the change, confirming it.
      // However, to provide immediate feedback, we can update the lastClaimTime locally.
      state = state.copyWith(lastClaimTime: now);
    } catch (e) {
      state = state.copyWith(isClaiming: false);
      rethrow;
    }
  }
}
