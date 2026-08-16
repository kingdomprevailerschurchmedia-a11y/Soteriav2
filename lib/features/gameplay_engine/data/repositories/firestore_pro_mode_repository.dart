import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/firebase/services/firebase_interfaces.dart';
import '../../domain/repositories/pro_mode_repository.dart';
import '../../models/competitive_session.dart';
import '../../models/game_state.dart';
import '../../models/pro_mode_result.dart';
import '../../models/game_mode.dart';
import '../../progression/models/reward_summary.dart';
import '../../../question_content/domain/entities/difficulty.dart';
import '../../../quiz/domain/services/quiz_scoring_engine.dart';
import '../../../quiz/domain/models/scoring_configuration.dart';
import '../../../quiz/domain/models/player_answer.dart';

import '../../../player/domain/repositories/player_progression_repository.dart';
import '../../../player/domain/models/xp_transaction.dart';
import '../../../../core/logging/logger_service.dart';

class FirestoreProModeRepository implements ProModeRepository {
  final IDatabaseService _database;
  final PlayerProgressionRepository _progressionRepository;

  FirestoreProModeRepository(this._database, this._progressionRepository);

  @override
  Future<bool> validateEntry(String uid, int fee) async {
    final snapshot = await _database.collection('users').doc(uid).get();
    if (!snapshot.exists) return false;

    final data = snapshot.data();
    if (data == null) return false;

    final int currentCoins = data['coins'] ?? 0;
    return currentCoins >= fee;
  }

  @override
  Future<void> reserveEntryFee(String uid, String sessionId, int fee) async {
    await _database.instance.runTransaction((transaction) async {
      final playerRef = _database.collection('users').doc(uid);
      final playerDoc = await transaction.get(playerRef);

      if (!playerDoc.exists) {
        throw Exception('Player profile not found.');
      }

      final int currentCoins = playerDoc.data()?['coins'] ?? 0;
      if (currentCoins < fee) {
        throw Exception('Insufficient coins for Pro Mode entry.');
      }

      // Hardening: Check for existing active sessions to prevent parallel play
      final activeSessions = await _database
          .collection('competitive_sessions')
          .where('uid', isEqualTo: uid)
          .where('status', isEqualTo: 'initialized')
          .get();

      if (activeSessions.docs.isNotEmpty) {
        throw Exception('An active competitive session already exists.');
      }

      // 1. Deduct coins from player
      transaction.update(playerRef, {
        'coins': FieldValue.increment(-fee),
        'proSessions': FieldValue.increment(1),
      });

      // 2. Create a reservation record
      final reservationRef = _database.collection('pro_reservations').doc(sessionId);
      transaction.set(reservationRef, {
        'uid': uid,
        'fee': fee,
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
    Query query = _database.collection('questions')
        .where('status', isEqualTo: 'published')
        .where('difficulty', isEqualTo: difficulty.name);

    if (categoryIds != null && categoryIds.isNotEmpty) {
      if (categoryIds.length == 1) {
        query = query.where('categoryId', isEqualTo: categoryIds.first);
      } else {
        // Firestore 'in' operator supports up to 10-30 items depending on SDK version
        query = query.where('categoryId', whereIn: categoryIds);
      }
    }

    final snapshot = await query.count().get();
    final count = snapshot.count ?? 0;
    
    LoggerService.d(
      'Pro Mode Content Check: categories=$categoryIds, difficulty=${difficulty.name}, available=$count',
      feature: 'GameplayEngine',
    );
    
    return count;
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
      authoritativeScore += scoreResult.totalScore;
      authoritativeXP += scoreResult.xpEarned;
      
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
    
    // Authoritative Reward Calculation
    // Pro Mode grants bonus coins based on performance
    final baseCoins = (correctCount * 10); // Pro Mode has higher base reward
    final bonusCoins = accuracy >= 1.0 ? 100 : (accuracy >= 0.9 ? 50 : 0);
    
    final rewards = RewardSummary(
      baseXP: authoritativeXP,
      bonusXP: (authoritativeScore * 0.05).toInt(), // Performance bonus XP
      baseCoins: baseCoins,
      bonusCoins: bonusCoins,
    );

    final avgResponseTime = totalAnswered > 0 
        ? Duration(milliseconds: totalResponseTime.inMilliseconds ~/ totalAnswered)
        : Duration.zero;

    final result = ProModeResult(
      sessionId: sessionId,
      playerId: finalState.playerId,
      mode: GameMode.pro,
      finalScore: authoritativeScore,
      totalXP: rewards.totalXP,
      totalQuestions: totalQuestions,
      correctAnswers: correctCount,
      wrongAnswers: wrongCount,
      skippedQuestions: skippedCount,
      totalDuration: finalState.lastAnswerTime != null && finalState.startTime != null
          ? finalState.lastAnswerTime!.difference(finalState.startTime!)
          : Duration.zero,
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

    await _database.instance.runTransaction((transaction) async {
      final sessionRef = _database.collection('competitive_sessions').doc(sessionId);
      final resultRef = _database.collection('pro_results').doc(sessionId);
      
      final sessionDoc = await transaction.get(sessionRef);
      if (!sessionDoc.exists) throw Exception('Session not found');
      
      final resultDoc = await transaction.get(resultRef);
      if (resultDoc.exists) return; // Idempotency

      transaction.update(sessionRef, {'status': 'completed'});
      transaction.set(resultRef, result.toJson());
      
      final uid = sessionDoc.data()?['uid'];
      if (uid != null) {
        final playerRef = _database.collection('users').doc(uid);
        transaction.update(playerRef, {
          'coins': FieldValue.increment(result.rewards.totalCoins),
        });

        // 3. Authoritative Progression Update
        if (result.totalXP > 0) {
          final xpTx = XpTransaction(
            transactionId: '${sessionId}_xp',
            userId: uid,
            amount: result.totalXP,
            source: XpSource.quizCompletion,
            referenceId: sessionId,
            createdAt: DateTime.now(),
          );
          
          // We call this AFTER the transaction as Firestore transactions 
          // don't support calling other methods that start their own transactions 
          // easily without passing the transaction object.
          // But applyXpTransaction is idempotent, so it's safe to retry or call separately.
          _progressionRepository.applyXpTransaction(xpTx);
        }
      }
    });

    return result;
  }

  @override
  Future<ProModeResult?> getResult(String sessionId) async {
    final snapshot = await _database.collection('pro_results').doc(sessionId).get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return ProModeResult.fromJson(snapshot.data()!);
  }
}
