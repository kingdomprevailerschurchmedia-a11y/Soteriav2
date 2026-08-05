import 'package:soteria/features/player/domain/models/player_profile.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/gameplay_engine/models/game_result.dart';
import 'package:soteria/features/gameplay_engine/progression/models/reward_summary.dart';
import 'package:soteria/features/gameplay_engine/models/answer_review.dart';
import 'package:uuid/uuid.dart';

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
