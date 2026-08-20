import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/reward.dart';
import '../../domain/repositories/rewards_repository.dart';
import '../../../player/domain/config/milestone_registry.dart';
import '../../../player/domain/config/goal_registry.dart';
import '../../../player/domain/services/achievement_registry.dart';
import '../../../player/domain/models/xp_transaction.dart';
import '../../../player/data/repositories/firebase_player_progression_repository.dart';
import '../../../player/domain/repositories/player_progression_repository.dart';
import '../../../player/domain/models/season_reward_definition.dart' as player_models;

class FirestoreRewardsRepository implements RewardsRepository {
  final FirebaseFirestore _firestore;
  final PlayerProgressionRepository _progressionRepository;

  FirestoreRewardsRepository(this._firestore, this._progressionRepository);

  @override
  Future<List<Reward>> getAvailableRewards(String userId) async {
    final List<Reward> rewards = [];

    // 1. Fetch Milestones
    final milestoneSnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('milestones')
        .where('status', isEqualTo: 'completed')
        .get();

    for (final doc in milestoneSnapshot.docs) {
      final milestoneId = doc.id;
      final def = MilestoneRegistry.getById(milestoneId);
      if (def != null) {
        rewards.add(Reward(
          id: 'milestone_$milestoneId',
          title: def.name,
          description: def.description,
          type: _mapPlayerRewardTypeToRewardType(def.rewardType),
          amount: def.rewardAmount ?? 0,
          source: RewardSource.milestone,
          status: RewardStatus.claimable,
          metadata: {'milestoneId': milestoneId},
        ));
      }
    }

    // 2. Fetch Goals
    final goalSnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('competitive_goals')
        .where('status', isEqualTo: 'completed')
        .get();

    for (final doc in goalSnapshot.docs) {
      final goalId = doc.id;
      final defId = _resolveGoalDefinitionId(goalId);
      final def = GoalRegistry.getById(defId);
      if (def != null) {
        rewards.add(Reward(
          id: 'goal_$goalId',
          title: def.title,
          description: def.description,
          type: _mapPlayerRewardTypeToRewardType(def.rewardType),
          amount: def.rewardAmount ?? 0,
          source: RewardSource.milestone, // Using milestone as source for simplicity in mapping
          status: RewardStatus.claimable,
          metadata: {'goalId': goalId},
        ));
      }
    }

    // 3. Daily Bonus is handled separately by DailyBonusProvider, but we can wrap it here if needed
    // For now, let's just return the aggregate of milestones and goals.
    
    return rewards;
  }

  @override
  Future<List<Reward>> getRewardHistory(String userId) async {
    // This could be fetched from wallet_transactions with credit direction
    final snapshot = await _firestore
        .collection('wallet_transactions')
        .where('userId', isEqualTo: userId)
        .where('direction', isEqualTo: 'credit')
        .orderBy('createdAt', descending: true)
        .limit(20)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Reward(
        id: doc.id,
        title: _getTitleFromSource(data['source']),
        description: data['metadata']?['description'] ?? 'Reward claimed',
        type: _mapCurrencyToRewardType(data['currency']),
        amount: data['amount'] ?? 0,
        source: _mapStringToRewardSource(data['source']),
        status: RewardStatus.claimed,
        claimedAt: (data['createdAt'] as Timestamp).toDate(),
      );
    }).toList();
  }

  @override
  Future<void> claimReward(String userId, String rewardId) async {
    final parts = rewardId.split('_');
    final type = parts[0];
    final originalId = parts.skip(1).join('_');

    await _firestore.runTransaction((transaction) async {
      final userRef = _firestore.collection('users').doc(userId);
      final walletRef = _firestore.collection('wallets').doc(userId);
      final txRef = _firestore.collection('wallet_transactions').doc();

      RewardType rewardType = RewardType.coins;
      int amount = 0;
      RewardSource source = RewardSource.milestone;
      String description = '';

      if (type == 'milestone') {
        final milestoneRef = userRef.collection('milestones').doc(originalId);
        final snapshot = await transaction.get(milestoneRef);
        if (!snapshot.exists || snapshot.data()?['status'] != 'completed') {
          throw Exception('Milestone not claimable');
        }

        final def = MilestoneRegistry.getById(originalId);
        if (def == null) throw Exception('Definition not found');

        rewardType = _mapPlayerRewardTypeToRewardType(def.rewardType);
        amount = def.rewardAmount ?? 0;
        source = RewardSource.milestone;
        description = def.name;

        transaction.update(milestoneRef, {
          'status': 'claimed',
          'claimedAt': DateTime.now().toIso8601String(),
        });
      } else if (type == 'goal') {
        final goalRef = userRef.collection('competitive_goals').doc(originalId);
        final snapshot = await transaction.get(goalRef);
        if (!snapshot.exists || snapshot.data()?['status'] != 'completed') {
          throw Exception('Goal not claimable');
        }

        final defId = _resolveGoalDefinitionId(originalId);
        final def = GoalRegistry.getById(defId);
        if (def == null) throw Exception('Definition not found');

        rewardType = _mapPlayerRewardTypeToRewardType(def.rewardType);
        amount = def.rewardAmount ?? 0;
        source = RewardSource.dailyChallenge;
        description = def.title;

        transaction.update(goalRef, {
          'status': 'claimed',
          'claimedAt': DateTime.now().toIso8601String(),
        });
      } else {
        throw Exception('Unknown reward type: $type');
      }

      // Credit Coins if applicable
      if (rewardType == RewardType.coins) {
        transaction.update(userRef, {
          'coins': FieldValue.increment(amount),
          'lastCoinTransactionId': txRef.id,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        transaction.set(walletRef, {
          'coins': FieldValue.increment(amount),
          'lifetimeCoinsEarned': FieldValue.increment(amount),
          'lastTransactionId': txRef.id,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
        
        transaction.set(_firestore.collection('user_game_profiles').doc(userId), {
          'coins': FieldValue.increment(amount),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        transaction.set(txRef, {
          'userId': userId,
          'currency': 'coins',
          'direction': 'credit',
          'amount': amount,
          'transactionType': 'reward',
          'source': source.name,
          'referenceId': originalId,
          'status': 'completed',
          'createdAt': FieldValue.serverTimestamp(),
          'metadata': {'description': description},
        });
      }

      // Credit XP if applicable (Requires atomicity with progression)
      if (rewardType == RewardType.xp) {
        final xpTx = XpTransaction(
          transactionId: txRef.id,
          userId: userId,
          amount: amount,
          source: _mapSourceToXpSource(source),
          referenceId: originalId,
          createdAt: DateTime.now(),
        );

        if (_progressionRepository is FirebasePlayerProgressionRepository) {
          await _progressionRepository.processXpTransaction(transaction, xpTx);
        } else {
          // Non-atomic fallback if needed
          await _progressionRepository.applyXpTransaction(xpTx);
        }
      }
    });
  }

  String _resolveGoalDefinitionId(String goalId) {
    final parts = goalId.split('_');
    if (parts.length > 3 && (parts[0] == 'daily' || parts[0] == 'weekly')) {
      return parts.take(3).join('_');
    }
    return goalId;
  }

  String _getTitleFromSource(String? source) {
    switch (source) {
      case 'milestone': return 'Milestone Completed';
      case 'dailyLogin': return 'Daily Bonus';
      case 'achievement': return 'Achievement Unlocked';
      default: return 'Reward';
    }
  }

  RewardType _mapCurrencyToRewardType(String? currency) {
    if (currency == 'coins') return RewardType.coins;
    if (currency == 'tokens') return RewardType.tokens;
    return RewardType.xp;
  }

  RewardSource _mapStringToRewardSource(String? source) {
    return RewardSource.values.firstWhere(
      (s) => s.name == source,
      orElse: () => RewardSource.milestone,
    );
  }

  XpSource _mapSourceToXpSource(RewardSource source) {
    if (source == RewardSource.milestone) return XpSource.milestone;
    if (source == RewardSource.dailyChallenge) return XpSource.goal;
    if (source == RewardSource.achievement) return XpSource.achievement;
    return XpSource.quizCompletion;
  }

  RewardType _mapPlayerRewardTypeToRewardType(player_models.RewardType? type) {
    if (type == null) return RewardType.coins;
    switch (type) {
      case player_models.RewardType.xp:
        return RewardType.xp;
      case player_models.RewardType.coins:
        return RewardType.coins;
      case player_models.RewardType.tokens:
        return RewardType.tokens;
      case player_models.RewardType.cosmetic:
        return RewardType.cosmetic;
      default:
        return RewardType.coins;
    }
  }
}
