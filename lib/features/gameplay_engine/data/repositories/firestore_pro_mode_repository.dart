import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/firebase/services/firebase_interfaces.dart';
import '../../domain/repositories/pro_mode_repository.dart';
import '../../models/competitive_session.dart';
import '../../models/game_state.dart';
import '../../models/pro_mode_result.dart';
import '../../models/game_mode.dart';
import '../../models/game_result.dart';
import '../../domain/config/competitive_reward_config.dart';
import '../../domain/services/reward_settlement_service.dart';
import '../../progression/models/reward_summary.dart';
import '../../../question_content/domain/entities/difficulty.dart';
import '../../../quiz/domain/services/quiz_scoring_engine.dart';
import '../../../quiz/domain/models/scoring_configuration.dart';
import '../../../quiz/domain/models/player_answer.dart';

import 'package:soteria/features/player/domain/repositories/player_progression_repository.dart';
import 'package:soteria/features/player/domain/repositories/player_repository.dart';
import 'package:soteria/features/player/domain/models/xp_transaction.dart';
import 'package:soteria/features/player/domain/models/competitive_result.dart';
import '../../../../core/logging/logger_service.dart';

class FirestoreProModeRepository implements ProModeRepository {
  final IDatabaseService _database;
  final PlayerProgressionRepository _progressionRepository;
  final PlayerRepository _playerRepository;

  FirestoreProModeRepository(
    this._database,
    this._progressionRepository,
    this._playerRepository,
  );

  @override
  Future<bool> validateEntry(String uid, Difficulty difficulty) async {
    final snapshot = await _database.collection('users').doc(uid).get();
    if (!snapshot.exists) return false;

    final data = snapshot.data();
    if (data == null) return false;

    final int currentCoins = data['coins'] ?? 0;
    final int fee = CompetitiveRewardConfig.proEntryFees[difficulty] ?? 0;
    return currentCoins >= fee;
  }

  @override
  Future<void> reserveEntryFee(String uid, String sessionId, Difficulty difficulty, {bool isFree = false}) async {
    final int fee = CompetitiveRewardConfig.proEntryFees[difficulty] ?? 0;
    final now = DateTime.now();

    // 1. Pre-transaction check: Check for existing active sessions to prevent parallel play.
    // We use a timeout to prevent hanging on flaky connections.
    final existingSessions = await _database
        .collection('competitive_sessions')
        .where('uid', isEqualTo: uid)
        .where('status', whereIn: ['initialized', 'active'])
        .get()
        .timeout(const Duration(seconds: 5), onTimeout: () {
          LoggerService.e('Pro Mode Entry: Active session check timed out', feature: 'GameplayEngine');
          throw Exception('Connection timeout checking for active sessions. Please try again.');
        });

    final activeSessions = existingSessions.docs.where((doc) {
      final data = doc.data();
      final updatedAt = data['updatedAt'];
      final startTime = data['startTime'];

      DateTime? lastActivity;
      if (updatedAt is String) {
        lastActivity = DateTime.tryParse(updatedAt);
      } else if (updatedAt is Timestamp) {
        lastActivity = updatedAt.toDate();
      } else if (startTime is String) {
        lastActivity = DateTime.tryParse(startTime);
      }

      if (lastActivity == null) return true;
      return now.difference(lastActivity).inMinutes < 20;
    }).toList();

    if (activeSessions.isNotEmpty) {
      LoggerService.w(
        'Pro Mode Entry Blocked: Active session exists',
        feature: 'GameplayEngine',
        metadata: {'uid': uid, 'sessionId': activeSessions.first.id},
      );
      throw Exception('An active competitive session already exists.');
    }

    // 2. Authoritative Atomic Transaction for Fee & Stats
    await _database.instance.runTransaction<void>((transaction) async {
      final playerRef = _database.collection('users').doc(uid);
      final playerDoc = await transaction.get(playerRef);

      if (!playerDoc.exists) {
        throw Exception('Player profile not found.');
      }

      final data = playerDoc.data() ?? {};
      final int currentCoins = data['coins'] ?? 0;

      // Authoritative daily reset check
      final lastSessionDate = data['lastProSessionDate'] != null
          ? (data['lastProSessionDate'] is Timestamp
              ? (data['lastProSessionDate'] as Timestamp).toDate()
              : DateTime.parse(data['lastProSessionDate']))
          : null;

      bool isNewDay = lastSessionDate == null ||
          lastSessionDate.year != now.year ||
          lastSessionDate.month != now.month ||
          lastSessionDate.day != now.day;

      if (!isFree && currentCoins < fee) {
        throw Exception('Insufficient coins for Pro Mode entry.');
      }

      // 1. Update player stats
      final updates = <String, dynamic>{
        'proSessions': FieldValue.increment(1),
        'dailyProSessionsPlayed': isNewDay ? 1 : FieldValue.increment(1),
        'lastProSessionDate': Timestamp.fromDate(now),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (!isFree) {
        updates['coins'] = FieldValue.increment(-fee);
      }
      
      transaction.update(playerRef, updates);

      // 2. Log coin transaction (only if fee was paid)
      if (!isFree) {
        final txId = _database.collection('wallet_transactions').doc().id;
        
        final txData = {
          'userId': uid,
          'type': 'coins',
          'currency': 'coins',
          'direction': 'debit',
          'amount': fee,
          'transactionType': 'spend',
          'source': 'proModeEntry',
          'referenceId': sessionId,
          'status': 'completed',
          'createdAt': FieldValue.serverTimestamp(),
          'metadata': {'sessionId': sessionId, 'action': 'entry_fee'},
        };

        transaction.set(_database.collection('wallet_transactions').doc(txId), txData);
        
        // Sync to legacy if needed
        final coinTxRef = _database.collection('coin_transactions').doc(txId);
        transaction.set(coinTxRef, txData);
      }

      // 3. Create a reservation record
      final reservationRef = _database.collection('pro_reservations').doc(sessionId);
      transaction.set(reservationRef, {
        'uid': uid,
        'fee': isFree ? 0 : fee,
        'isFree': isFree,
        'timestamp': DateTime.now().toIso8601String(),
        'status': 'reserved',
      });
    });
  }

  @override
  Future<void> createCompetitiveSession(CompetitiveSession session) async {
    await _database
        .collection('competitive_sessions')
        .doc(session.sessionId)
        .set(session.toJson());
  }

  @override
  Future<int> getAvailableQuestionCount({
    List<String>? categoryIds,
    required Difficulty difficulty,
  }) async {
    try {
      if (categoryIds == null || categoryIds.isEmpty) {
        final query = _database.collection('questions')
            .where('status', isEqualTo: 'published')
            .where('difficulty', isEqualTo: difficulty.name);
        final snapshot = await query.count().get().timeout(const Duration(seconds: 5));
        return snapshot.count ?? 0;
      }

      // Firestore 'in'/'whereIn' operator supports up to 30 items.
      // We chunk the categories to avoid "Invalid Query" errors.
      int totalCount = 0;
      const int chunkSize = 30;
      
      for (var i = 0; i < categoryIds.length; i += chunkSize) {
        final chunk = categoryIds.sublist(
          i, 
          i + chunkSize > categoryIds.length ? categoryIds.length : i + chunkSize
        );
        
        final query = _database.collection('questions')
            .where('status', isEqualTo: 'published')
            .where('difficulty', isEqualTo: difficulty.name)
            .where('categoryId', whereIn: chunk);
            
        final snapshot = await query.count().get().timeout(const Duration(seconds: 5));
        totalCount += snapshot.count ?? 0;
      }

      LoggerService.d(
        'Pro Mode Content Check: categories=${categoryIds.length}, difficulty=${difficulty.name}, total=$totalCount',
        feature: 'GameplayEngine',
      );
      
      return totalCount;
    } catch (e) {
      LoggerService.e('Pro Mode Content Check failed', error: e, feature: 'GameplayEngine');
      return 0; // Default to 0 to prevent allowing entry if check fails
    }
  }

  @override
  Future<ProModeResult> completeSession(String sessionId, GameState finalState) async {
    final scoringEngine = QuizScoringEngine(config: ScoringConfiguration.pro());
    
    int authoritativeScore = 0;
    int authoritativeXP = 0;
    int currentStreak = 0;
    int maxStreak = 0;
    int correctCount = 0;
    int wrongCount = 0;
    int skippedCount = 0;
    
    Duration totalResponseTime = Duration.zero;
    Duration fastestTime = Duration.zero;
    Duration slowestTime = Duration.zero;

    final questionMap = {for (var q in finalState.questions) q.id: q};

    for (final answerResult in finalState.answerHistory) {
      final question = questionMap[answerResult.questionId];
      if (question == null) continue;

      final playerAnswer = PlayerAnswer(
        questionId: answerResult.questionId,
        selectedOptionIds: answerResult.selectedOptionIds,
        isCorrect: answerResult.isCorrect,
        responseTime: answerResult.responseTime,
        timestamp: answerResult.timestamp,
        isSkipped: answerResult.isSkipped,
        isTimedOut: answerResult.isTimedOut,
      );

      final scoreResult = scoringEngine.calculate(question, playerAnswer, currentStreak);
      authoritativeScore += scoreResult.totalScore.toInt();
      authoritativeXP += scoreResult.xpEarned.toInt();
      
      currentStreak = scoringEngine.calculateNewStreak(currentStreak, playerAnswer);
      if (currentStreak > maxStreak) maxStreak = currentStreak;

      if (answerResult.isCorrect) {
        correctCount++;
      } else if (answerResult.isWrong || answerResult.isTimedOut) {
        wrongCount++;
      } else if (answerResult.isSkipped) {
        skippedCount++;
      }

      totalResponseTime += answerResult.responseTime;
      if (answerResult.responseTime > Duration.zero) {
        if (fastestTime == Duration.zero || answerResult.responseTime < fastestTime) {
          fastestTime = answerResult.responseTime;
        }
      }
      if (answerResult.responseTime > slowestTime) {
        slowestTime = answerResult.responseTime;
      }
    }

    final totalQuestions = finalState.questions.length;
    final totalAnswered = finalState.answerHistory.length;
    skippedCount += (totalQuestions - totalAnswered);
    
    final accuracy = totalQuestions > 0 ? correctCount / totalQuestions : 0.0;
    
    final avgResponseTime = totalAnswered > 0 
        ? Duration(milliseconds: totalResponseTime.inMilliseconds ~/ totalAnswered)
        : Duration.zero;

    // PRE-FETCH: Get Player Profile outside the transaction to reduce transaction duration
    final playerProfile = await _playerRepository.getPlayerProfile(finalState.playerId);
    if (playerProfile == null) throw Exception('Player profile not found');

    await _database.instance.runTransaction<void>((transaction) async {
      final sessionRef = _database.collection('competitive_sessions').doc(sessionId);
      final resultRef = _database.collection('pro_results').doc(sessionId);
      
      // BATCH READ: Start all necessary transaction reads sequentially
      final sessionDoc = await transaction.get(sessionRef);
      if (!sessionDoc.exists) throw Exception('Session not found');
      
      final resultDoc = await transaction.get(resultRef);
      if (resultDoc.exists) return; // Idempotency

      final sessionData = sessionDoc.data() as Map<String, dynamic>;
      final configData = sessionData['config'] as Map<String, dynamic>;
      final difficulty = Difficulty.values.byName(configData['difficulty']);
      final questionCount = (configData['questionCount'] as num).toInt();
      final reservedFee = (sessionData['reservedFee'] as num?)?.toInt();

      // ... logic continues ...

      // VITAL SECURITY: Verify that the fee paid matches the difficulty config
      final expectedFee = CompetitiveRewardConfig.proEntryFees[difficulty] ?? 0;
      if (reservedFee != null && reservedFee < expectedFee) {
        throw Exception('Security violation: Entry fee mismatch. Expected $expectedFee, found $reservedFee.');
      }
      // If reservedFee is null, we treat it as a legacy session for backward compatibility 
      // during the remediation rollout.

      // Authoritative Reward Calculation via Service
      final settlementService = RewardSettlementService();
      
      // Temporary GameResult for calculation
      final tempResult = GameResult(
        sessionId: sessionId,
        playerId: finalState.playerId,
        mode: GameMode.pro,
        finalScore: authoritativeScore,
        totalXP: 0, // Will be calculated
        totalQuestions: totalQuestions,
        correctAnswers: correctCount,
        wrongAnswers: wrongCount,
        skippedQuestions: skippedCount,
        totalDuration: finalState.lastAnswerTime != null && finalState.startTime != null
            ? finalState.lastAnswerTime!.difference(finalState.startTime!)
            : Duration.zero,
        accuracy: accuracy,
        maxStreak: maxStreak,
        timestamp: DateTime.now(),
      );

      final settlement = settlementService.calculateProSettlement(
        settlementId: sessionId, // Using sessionId as settlementId for Pro Mode
        result: tempResult,
        difficulty: difficulty,
        questionCount: questionCount,
      );

      final rewards = RewardSummary(
        baseXP: settlement.xpEarned,
        baseCoins: settlement.coinsWon,
      );

      final result = ProModeResult(
        sessionId: sessionId,
        playerId: finalState.playerId,
        mode: GameMode.pro,
        finalScore: authoritativeScore,
        totalXP: settlement.xpEarned,
        totalQuestions: totalQuestions,
        correctAnswers: correctCount,
        wrongAnswers: wrongCount,
        skippedQuestions: skippedCount,
        totalDuration: tempResult.totalDuration,
        accuracy: accuracy,
        maxStreak: maxStreak,
        rewards: rewards,
        avgResponseTime: avgResponseTime,
        fastestAnswerTime: fastestTime,
        slowestAnswerTime: slowestTime,
        timestamp: DateTime.now(),
        rating: ProModeResult.calculateRating(accuracy),
        answers: finalState.answerHistory,
      );

      transaction.update(sessionRef, {'status': 'completed'});
      transaction.set(resultRef, result.toJson());
      
      final uid = sessionDoc.data()?['uid'];
      if (uid != null) {
        final playerRef = _database.collection('users').doc(uid);
        final walletRef = _database.collection('wallets').doc(uid);
        final gameProfileRef = _database.collection('user_game_profiles').doc(uid);
        final amount = settlement.coinsWon;
        
        final txId = _database.collection('wallet_transactions').doc().id;

        transaction.update(playerRef, {
          'coins': FieldValue.increment(amount),
          'proSessions': FieldValue.increment(1),
          'totalQuestionsAnswered': FieldValue.increment(totalQuestions),
          'correctAnswers': FieldValue.increment(correctCount),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        // 1. Sync Wallet & Game Profile
        transaction.set(walletRef, {
          'coins': FieldValue.increment(amount),
          'lifetimeCoinsEarned': FieldValue.increment(amount),
          'lastTransactionId': txId,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        transaction.set(gameProfileRef, {
          'coins': FieldValue.increment(amount),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        // 2. Log coin transaction if there are rewards
        if (amount > 0) {
          final walletTxRef = _database.collection('wallet_transactions').doc(txId);
          
          final txData = {
            'userId': uid,
            'type': 'coins',
            'currency': 'coins',
            'direction': 'credit',
            'amount': amount,
            'transactionType': 'reward',
            'source': 'proReward',
            'referenceId': sessionId,
            'status': 'completed',
            'createdAt': FieldValue.serverTimestamp(),
            'metadata': {
              'sessionId': sessionId,
              'accuracy': accuracy,
              'difficulty': difficulty.name,
            },
          };

          transaction.set(walletTxRef, txData);
          
          // Update last transaction ID for security rule verification
          transaction.update(playerRef, {
            'lastCoinTransactionId': txId,
          });

          // Sync to legacy if needed
          final coinTxRef = _database.collection('coin_transactions').doc(txId);
          transaction.set(coinTxRef, txData);
        }

        // 3. Authoritative Progression Update
        if (settlement.xpEarned > 0) {
          final xpTx = XpTransaction(
            transactionId: '${sessionId}_xp',
            userId: uid,
            amount: settlement.xpEarned,
            source: XpSource.quizCompletion,
            referenceId: sessionId,
            createdAt: DateTime.now(),
          );
          
          await _progressionRepository.processXpTransaction(transaction, xpTx);
        }

        // 4. Authoritative Rank Point (RP) Update - USING TRANSACTION-AWARE METHOD
        final compResult = CompetitiveResult(
          resultId: sessionId,
          userId: uid,
          seasonId: 'current_season',
          outcome: result.accuracy >= 0.7 ? CompetitiveOutcome.win : CompetitiveOutcome.loss,
          mode: 'pro',
          score: result.finalScore.toInt(),
          completedAt: DateTime.now(),
        );
        
        await _progressionRepository.applyCompetitiveResultInTransaction(
          transaction, 
          compResult,
          profile: playerProfile,
        );

        // 5. Store Settlement Record for auditing
        final settlementRef = _database.collection('settlements').doc(sessionId);
        transaction.set(settlementRef, settlement.toJson());
      }
    });

    // Return the result (though caller might not use it as much as the DB state)
    final finalResultDoc = await _database.collection('pro_results').doc(sessionId).get();
    return ProModeResult.fromJson(finalResultDoc.data()!);
  }

  @override
  Future<ProModeResult?> getResult(String sessionId) async {
    final snapshot = await _database.collection('pro_results').doc(sessionId).get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return ProModeResult.fromJson(snapshot.data()!);
  }

  @override
  Future<void> refundEntryFee(String uid, String sessionId, Difficulty difficulty) async {
    final int fee = CompetitiveRewardConfig.proEntryFees[difficulty] ?? 0;

    await _database.instance.runTransaction<void>((transaction) async {
      final playerRef = _database.collection('users').doc(uid);
      final reservationRef = _database.collection('pro_reservations').doc(sessionId);
      final sessionRef = _database.collection('competitive_sessions').doc(sessionId);

      final reservationDoc = await transaction.get(reservationRef);
      if (!reservationDoc.exists) return; // Already refunded or never reserved

      final resData = reservationDoc.data() ?? {};
      if (resData['status'] == 'refunded') return; // Idempotency

      // 1. Restore coins (if a fee was actually paid)
      final int reservedFee = (resData['fee'] as num?)?.toInt() ?? fee;
      if (reservedFee > 0) {
        transaction.update(playerRef, {
          'coins': FieldValue.increment(reservedFee),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        // 2. Log refund transaction
        final txId = _database.collection('wallet_transactions').doc().id;
        final txData = {
          'userId': uid,
          'type': 'coins',
          'currency': 'coins',
          'direction': 'credit',
          'amount': reservedFee,
          'transactionType': 'refund',
          'source': 'proModeRefund',
          'referenceId': sessionId,
          'status': 'completed',
          'createdAt': FieldValue.serverTimestamp(),
          'metadata': {'sessionId': sessionId, 'action': 'initialization_failure_refund'},
        };
        transaction.set(_database.collection('wallet_transactions').doc(txId), txData);
        
        // Sync to legacy if needed
        final coinTxRef = _database.collection('coin_transactions').doc(txId);
        transaction.set(coinTxRef, txData);
      }

      // 3. Update reservation status
      transaction.update(reservationRef, {'status': 'refunded'});
      
      // 4. Update session status (using set merge for resilience)
      transaction.set(sessionRef, {
        'status': 'refunded',
        'refundedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    });
  }
}
