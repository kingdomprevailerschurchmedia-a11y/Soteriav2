import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/progression/models/reward_summary.dart';
import 'package:soteria/features/gameplay_engine/models/answer_review.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/gameplay_engine/models/game_mode.dart';
import 'package:soteria/features/gameplay_engine/models/game_state.dart';
import 'package:soteria/features/gameplay_engine/models/game_lifecycle.dart';
import 'package:soteria/features/gameplay_engine/models/competitive_session.dart';
import 'package:soteria/features/gameplay_engine/models/pro_session_config.dart';
import 'package:soteria/features/gameplay_engine/models/competitive_settlement.dart';
import 'package:soteria/features/gameplay_engine/models/competitive_review_item.dart';
import 'package:soteria/features/tournaments/domain/models/tournament_ranking.dart';
import 'package:soteria/features/tournaments/domain/models/tournament_reward.dart';
import 'package:soteria/features/tournaments/domain/models/tournament_status.dart';
import 'package:soteria/features/tournaments/domain/models/tournament_type.dart';
import 'package:soteria/features/tournaments/domain/models/tournament.dart';
import 'package:soteria/features/tournaments/domain/models/tournament_participant.dart';

class MockDataFactory {
  static PlayerProfile createMockPlayer({
    String? name,
    int? level,
    int? xp,
    int? coins,
    String? role,
  }) {
    return PlayerProfile(
      uid: const Uuid().v4(),
      displayName: name ?? 'Aria Sterling',
      email: 'aria@soteria.app',
      photoUrl: 'https://i.pravatar.cc/300?u=aria',
      level: level ?? 42,
      xp: xp ?? 4250,
      coins: coins ?? 1500,
      currentStreak: 14,
      highestStreak: 21,
      role: role ?? 'Guardian',
      totalQuestionsAnswered: 840,
      accuracy: 0.92,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastLogin: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static PlayerProfile createNewPlayer() => createMockPlayer(
    name: 'New Recruit',
    level: 1,
    xp: 0,
    coins: 0,
    role: 'Novice',
  );

  static PlayerProfile createExpertPlayer() => createMockPlayer(
    name: 'Master Cyber',
    level: 99,
    xp: 999999,
    coins: 50000,
    role: 'Elder Guardian',
  );

  static List<Question> createMockQuestions(int count) {
    return List.generate(
      count,
      (index) => Question(
        id: 'q_$index',
        version: '1',
        text: 'What is the primary goal of the Soteria security protocol?',
        explanation:
            'Soteria is designed to provide end-to-end encryption for all player data while maintaining sub-50ms latency.',
        difficulty: QuestionDifficulty.medium,
        category: 'Cybersecurity',
        type: QuestionType.multipleChoice,
        options: const [
          Answer(id: 'a1', text: 'Data Encryption'),
          Answer(id: 'a2', text: 'Identity Theft Prevention'),
          Answer(id: 'a3', text: 'Malware Detection'),
          Answer(id: 'a4', text: 'Network Scanning'),
        ],
        correctAnswers: const ['a1'],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Soteria Handbook v2',
        schemaVersion: 1,
        contentHash: 'hash_$index',
      ),
    );
  }

  static RewardSummary createMockRewards({bool isPerfect = false}) {
    return RewardSummary(
      baseXP: 100,
      bonusXP: isPerfect ? 50 : 20,
      baseCoins: 20,
      streakBonus: 15,
      perfectScoreBonus: isPerfect ? 100 : 0,
    );
  }

  static GameResult createMockResult({bool isPerfect = false}) {
    return GameResult(
      sessionId: 'session_mock',
      finalScore: isPerfect ? 1000 : 850,
      totalXP: isPerfect ? 1500 : 1250,
      totalQuestions: 10,
      correctAnswers: isPerfect ? 10 : 8,
      wrongAnswers: isPerfect ? 0 : 2,
      totalDuration: const Duration(minutes: 5, seconds: 20),
      accuracy: isPerfect ? 1.0 : 0.8,
      maxStreak: isPerfect ? 10 : 6,
      rewards: createMockRewards(isPerfect: isPerfect),
      avgResponseTime: const Duration(seconds: 12),
      fastestAnswerTime: const Duration(seconds: 4),
      slowestAnswerTime: const Duration(seconds: 25),
    );
  }

  static GameResult createFailedResult() {
    return GameResult(
      sessionId: 'session_failed',
      finalScore: 120,
      totalXP: 50,
      totalQuestions: 10,
      correctAnswers: 2,
      wrongAnswers: 8,
      totalDuration: const Duration(minutes: 2, seconds: 15),
      accuracy: 0.2,
      maxStreak: 1,
      rewards: const RewardSummary(baseXP: 20, baseCoins: 5),
      avgResponseTime: const Duration(seconds: 8),
      fastestAnswerTime: const Duration(seconds: 3),
      slowestAnswerTime: const Duration(seconds: 45),
    );
  }

  static GameResult createOfflineResult() {
    return createMockResult().copyWith(isSynced: false);
  }

  static GameResult createResumedResult() {
    return createMockResult().copyWith(sessionId: 'session_resumed');
  }

  static PlayerProfile createLowCoinPlayer() => createMockPlayer(
    name: 'Broke Hacker',
    level: 10,
    xp: 1500,
    coins: 5,
    role: 'Scavenger',
  );

  static PlayerProfile createChampionPlayer() => createMockPlayer(
    name: 'Cyber Champion',
    level: 75,
    xp: 250000,
    coins: 100000,
    role: 'Grand Guardian',
  );

  static List<Map<String, dynamic>> createMockAchievements() {
    return [
      {
        'title': 'Perfect Sentinel',
        'description': 'Completed a session with 100% accuracy.',
        'icon': Icons.verified_user_rounded,
      },
      {
        'title': 'Speed Demon',
        'description': 'Answered 5 questions in under 3 seconds each.',
        'icon': Icons.speed_rounded,
      },
      {
        'title': 'Night Owl',
        'description': 'Completed a practice session after midnight.',
        'icon': Icons.nightlight_round,
      },
    ];
  }

  static GameConfiguration createExpertMatchConfig() => const GameConfiguration(
    mode: GameMode.pro,
    difficultyMultiplier: 2.0,
    questionCount: 30,
    questionTimer: Duration(seconds: 10),
  );

  static GameState createWinningProState() => GameState(
    sessionId: 'win_mock',
    score: 2500,
    streak: 12,
    questions: createMockQuestions(30),
    currentQuestionIndex: 15,
    lifecycle: GameLifecycle.playing,
    metadata: {'reservedFee': 500},
  );

  static GameState createLosingProState() => GameState(
    sessionId: 'lose_mock',
    score: 200,
    streak: 0,
    lives: 1,
    questions: createMockQuestions(10),
    currentQuestionIndex: 5,
    lifecycle: GameLifecycle.playing,
    metadata: {'reservedFee': 100},
  );

  static List<AnswerReview> createMockReviews() {
    final questions = createMockQuestions(5);
    return [
      AnswerReview(
        question: questions[0],
        selectedOptionIds: ['a1'],
        isCorrect: true,
        responseTime: const Duration(seconds: 10),
      ),
      AnswerReview(
        question: questions[1],
        selectedOptionIds: ['a2'],
        isCorrect: false,
        responseTime: const Duration(seconds: 15),
      ),
      AnswerReview(
        question: questions[2],
        selectedOptionIds: [],
        isCorrect: false,
        responseTime: Duration.zero,
      ),
    ];
  }

  static CompetitiveSession createMockCompetitiveSession({
    String? id,
    int? fee,
    String? difficulty,
    String? status,
  }) {
    return CompetitiveSession(
      sessionId: id ?? 'session_mock_pro',
      uid: 'user_mock',
      config: ProSessionConfig(
        difficulty: difficulty == 'expert'
            ? ProDifficulty.expert
            : ProDifficulty.intermediate,
        questionCount: 10,
        entryFee: fee ?? 100,
        timerEnabled: true,
      ),
      startTime: DateTime.now().subtract(const Duration(minutes: 10)),
      reservedFee: fee ?? 100,
      status: status ?? 'initialized',
    );
  }

  static CompetitiveSettlement createMockSettlement({
    required GameResult result,
    SettlementStatus status = SettlementStatus.completed,
    int? wagered,
    int? won,
  }) {
    return CompetitiveSettlement(
      settlementId: 'st_${const Uuid().v4().substring(0, 8)}',
      sessionId: result.sessionId,
      uid: 'user_mock',
      result: result,
      status: status,
      coinsWagered: wagered ?? 100,
      coinsWon: won ?? ((result.accuracy >= 0.7) ? 150 : 0),
      xpEarned: result.totalXP,
      timestamp: DateTime.now(),
    );
  }

  static List<CompetitiveReviewItem> createMockCompetitiveReviews() {
    return [
      const CompetitiveReviewItem(
        questionId: 'q1',
        questionText: 'What is the default port for HTTPS?',
        selectedAnswer: '443',
        correctAnswer: '443',
        explanation:
            'HTTPS uses port 443 for secure communication over TLS/SSL.',
        difficulty: 'Medium',
        timeTaken: Duration(seconds: 5),
        isCorrect: true,
      ),
      const CompetitiveReviewItem(
        questionId: 'q2',
        questionText: 'Which protocol is used for secure shell access?',
        selectedAnswer: 'TELNET',
        correctAnswer: 'SSH',
        explanation:
            'SSH provides encrypted remote access, unlike TELNET which sends data in plain text.',
        difficulty: 'Easy',
        timeTaken: Duration(seconds: 12),
        isCorrect: false,
      ),
    ];
  }

  static Tournament createMockTournament({
    String? id,
    String? name,
    TournamentStatus? status,
    TournamentType? type,
    int? registeredPlayers,
    int? maxPlayers,
    DateTime? startTime,
    double? prizePool,
  }) {
    final now = DateTime.now();
    return Tournament(
      id: id ?? const Uuid().v4(),
      name: name ?? 'Tournament ${const Uuid().v4().substring(0, 4)}',
      description:
          'Join the elite competition and prove your knowledge. Massive rewards for the top performers.',
      rules: const [
        'Registration closes 1 hour before start.',
        'No lifelines allowed in this event.',
        'Stable connection required.',
      ],
      bannerUrl:
          'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&q=80&w=800',
      type: type ?? TournamentType.standard,
      status: status ?? TournamentStatus.upcoming,
      difficulty: 'Hard',
      questionCount: 30,
      entryFee: 250,
      prizePool: prizePool ?? 10000,
      maxPlayers: maxPlayers ?? 1000,
      registeredPlayers: registeredPlayers ?? 124,
      startTime: startTime ?? now.add(const Duration(hours: 2)),
      endTime: now.add(const Duration(hours: 4)),
      registrationEndTime: now.add(const Duration(hours: 1)),
    );
  }

  static TournamentParticipant createMockTournamentParticipant({
    String? tournamentId,
    String? uid,
    String? name,
  }) {
    return TournamentParticipant(
      tournamentId: tournamentId ?? 't1',
      uid: uid ?? const Uuid().v4(),
      displayName: name ?? 'Aria Sterling',
      photoUrl: 'https://i.pravatar.cc/300?u=aria',
      registrationTime: DateTime.now().subtract(const Duration(minutes: 30)),
    );
  }

  static TournamentReward createMockTournamentReward({
    int? coins,
    int? xp,
    List<String>? badges,
    List<String>? titles,
  }) {
    return TournamentReward(
      coins: coins ?? 500,
      xp: xp ?? 200,
      badges: badges ?? ['Top 10'],
      titles: titles ?? ['Elite Guardian'],
    );
  }

  static TournamentRanking createMockTournamentRanking({
    int? rank,
    String? uid,
    String? name,
    int? score,
    double? accuracy,
    TournamentReward? prize,
  }) {
    return TournamentRanking(
      rank: rank ?? 1,
      uid: uid ?? const Uuid().v4(),
      displayName: name ?? 'Cyber Master',
      photoUrl: 'https://i.pravatar.cc/300?u=${const Uuid().v4()}',
      score: score ?? 4500,
      accuracy: accuracy ?? 0.95,
      completionTime: const Duration(minutes: 4, seconds: 30),
      completionTimestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      prize: prize,
    );
  }
}

extension GameResultExtension on GameResult {
  GameResult copyWith({
    String? sessionId,
    int? finalScore,
    int? totalXP,
    int? totalQuestions,
    int? correctAnswers,
    int? wrongAnswers,
    int? skippedQuestions,
    Duration? totalDuration,
    double? accuracy,
    int? maxStreak,
    RewardSummary? rewards,
    Duration? avgResponseTime,
    Duration? fastestAnswerTime,
    Duration? slowestAnswerTime,
    bool? isSynced,
  }) {
    return GameResult(
      sessionId: sessionId ?? this.sessionId,
      finalScore: finalScore ?? this.finalScore,
      totalXP: totalXP ?? this.totalXP,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      skippedQuestions: skippedQuestions ?? this.skippedQuestions,
      totalDuration: totalDuration ?? this.totalDuration,
      accuracy: accuracy ?? this.accuracy,
      maxStreak: maxStreak ?? this.maxStreak,
      rewards: rewards ?? this.rewards,
      avgResponseTime: avgResponseTime ?? this.avgResponseTime,
      fastestAnswerTime: fastestAnswerTime ?? this.fastestAnswerTime,
      slowestAnswerTime: slowestAnswerTime ?? this.slowestAnswerTime,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
