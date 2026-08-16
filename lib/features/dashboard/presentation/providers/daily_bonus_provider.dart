import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../player/providers/player_providers.dart';
import '../../../../core/identity/providers/identity_providers.dart';

final dailyBonusProvider = NotifierProvider<DailyBonusNotifier, DailyBonusState>(DailyBonusNotifier.new);

class DailyBonusState {
  final DateTime? lastClaimTime;
  final bool isClaiming;

  DailyBonusState({this.lastClaimTime, this.isClaiming = false});

  bool get canClaim {
    if (isClaiming) return false;
    if (lastClaimTime == null) return true;
    final now = DateTime.now();
    
    // Check if it's a new calendar day
    final lastClaimDate = DateTime(lastClaimTime!.year, lastClaimTime!.month, lastClaimTime!.day);
    final today = DateTime(now.year, now.month, now.day);
    
    return today.isAfter(lastClaimDate);
  }

  Duration get nextClaimIn {
    if (lastClaimTime == null) return Duration.zero;
    final now = DateTime.now();
    final nextClaim = DateTime(lastClaimTime!.year, lastClaimTime!.month, lastClaimTime!.day).add(const Duration(days: 1));
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
      final isAlreadyClaimedToday = next.lastDailyRewardClaim != null &&
          _isSameDay(next.lastDailyRewardClaim!, now);

      state = state.copyWith(
        lastClaimTime: next.lastDailyRewardClaim,
        // Only stop claiming if we see the reward is now recorded as claimed
        isClaiming: isAlreadyClaimedToday ? false : state.isClaiming,
      );
    });

    return DailyBonusState(lastClaimTime: initialPlayer?.lastDailyRewardClaim);
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  Future<void> claim() async {
    if (!state.canClaim || state.isClaiming) return;

    state = state.copyWith(isClaiming: true);

    try {
      final session = ref.read(sessionProvider);
      if (!session.isAuthenticated || session.uid == null) {
        throw Exception('Must be logged in to claim rewards');
      }

      final now = DateTime.now();
      
      // Authoritative update in Firestore
      await ref.read(playerRepositoryProvider).patchPlayerProfile(
        session.uid!,
        {
          'coins': FieldValue.increment(100),
          'lastDailyRewardClaim': Timestamp.fromDate(now),
          'updatedAt': Timestamp.fromDate(now),
        },
      );

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
