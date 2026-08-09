import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/quiz_enums.dart';
import '../domain/models/question.dart';
import '../domain/models/answer_option.dart';
import '../domain/models/timer_state.dart';
import '../domain/models/power_up_state.dart';
import '../presentation/states/quiz_state.dart';
import '../presentation/providers/quiz_providers.dart';
import '../presentation/screens/quiz_gameplay_screen.dart';

class GameplayPreviewWrapper extends StatelessWidget {
  const GameplayPreviewWrapper({super.key, required this.state});

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        quizControllerProvider.overrideWith(() => _MockQuizController(state)),
      ],
      child: const QuizGameplayScreen(),
    );
  }
}

class _MockQuizController extends QuizController {
  _MockQuizController(this.initialState);
  final QuizState initialState;

  @override
  QuizState build() => initialState;

  @override
  void resetQuiz() {
    state = const QuizState();
  }
}

class GameplayPreviews {
  static final mockQuestion = Question(
    id: 'q1',
    type: QuestionType.multipleChoice,
    category: 'Cybersecurity',
    difficulty: Difficulty.hard,
    text:
        'Which encryption algorithm is considered the current standard for securing sensitive data?',
    options: [
      const AnswerOption(id: 'o1', text: 'AES-256'),
      const AnswerOption(id: 'o2', text: 'DES'),
      const AnswerOption(id: 'o3', text: 'MD5'),
      const AnswerOption(id: 'o4', text: 'RC4'),
    ],
    correctOptionIds: ['o1'],
    explanation:
        'AES-256 is the Advanced Encryption Standard with a 256-bit key length.',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  static final mockPowerUps = [
    const PowerUpState(type: PowerUpType.fiftyFifty, isAvailable: true),
    const PowerUpState(type: PowerUpType.pauseTimer, isAvailable: true),
    const PowerUpState(type: PowerUpType.askAudience, isAvailable: false),
  ];

  static Widget active() => GameplayPreviewWrapper(
    state: QuizState(
      status: QuizStatus.active,
      currentQuestion: mockQuestion,
      questions: [mockQuestion, mockQuestion, mockQuestion],
      currentIndex: 0,
      score: 1200,
      streak: 4,
      timer: TimerState(
        totalDuration: const Duration(seconds: 30),
        remainingTime: const Duration(seconds: 24),
        progress: 0.8,
        isRunning: true,
      ),
      powerUps: mockPowerUps,
      questionStartTime: DateTime.now(),
    ),
  );

  static Widget selected() => GameplayPreviewWrapper(
    state: QuizState(
      status: QuizStatus.active,
      currentQuestion: mockQuestion,
      questions: [mockQuestion],
      currentIndex: 0,
      selectedOptionId: 'o1',
      isAnswerLocked: true,
      timer: TimerState(
        totalDuration: const Duration(seconds: 30),
        remainingTime: const Duration(seconds: 20),
        progress: 0.66,
        isRunning: false,
      ),
      powerUps: mockPowerUps,
    ),
  );

  static Widget correct() => GameplayPreviewWrapper(
    state: QuizState(
      status: QuizStatus.active,
      currentQuestion: mockQuestion,
      questions: [mockQuestion],
      currentIndex: 0,
      selectedOptionId: 'o1',
      isAnswerLocked: true,
      score: 100,
      streak: 1,
      timer: TimerState(
        totalDuration: const Duration(seconds: 30),
        remainingTime: const Duration(seconds: 20),
        progress: 0.66,
        isRunning: false,
      ),
      powerUps: mockPowerUps,
    ),
  );

  static Widget incorrect() => GameplayPreviewWrapper(
    state: QuizState(
      status: QuizStatus.active,
      currentQuestion: mockQuestion,
      questions: [mockQuestion],
      currentIndex: 0,
      selectedOptionId: 'o2',
      isAnswerLocked: true,
      streak: 0,
      timer: TimerState(
        totalDuration: const Duration(seconds: 30),
        remainingTime: const Duration(seconds: 20),
        progress: 0.66,
        isRunning: false,
      ),
      powerUps: mockPowerUps,
    ),
  );

  static Widget timerWarning() => GameplayPreviewWrapper(
    state: QuizState(
      status: QuizStatus.active,
      currentQuestion: mockQuestion,
      questions: [mockQuestion, mockQuestion, mockQuestion],
      currentIndex: 1,
      score: 2500,
      streak: 8,
      timer: TimerState(
        totalDuration: const Duration(seconds: 30),
        remainingTime: const Duration(seconds: 10),
        progress: 0.33,
        isRunning: true,
        status: TimerStatus.warning,
      ),
      powerUps: mockPowerUps,
    ),
  );

  static Widget timerCritical() => GameplayPreviewWrapper(
    state: QuizState(
      status: QuizStatus.active,
      currentQuestion: mockQuestion,
      questions: [mockQuestion],
      currentIndex: 0,
      timer: TimerState(
        totalDuration: const Duration(seconds: 30),
        remainingTime: const Duration(seconds: 4),
        progress: 0.13,
        isRunning: true,
        status: TimerStatus.critical,
      ),
      powerUps: mockPowerUps,
    ),
  );

  static Widget expired() => GameplayPreviewWrapper(
    state: QuizState(
      status: QuizStatus.active,
      currentQuestion: mockQuestion,
      questions: [mockQuestion],
      currentIndex: 0,
      isAnswerLocked: true,
      timer: TimerState(
        totalDuration: const Duration(seconds: 30),
        remainingTime: Duration.zero,
        progress: 0.0,
        isRunning: false,
        status: TimerStatus.expired,
        hasExpired: true,
      ),
      powerUps: mockPowerUps,
    ),
  );

  static Widget loading() =>
      const GameplayPreviewWrapper(state: QuizState(isLoading: true));

  static Widget error() => const GameplayPreviewWrapper(
    state: QuizState(error: 'Failed to establish connection to game server.'),
  );

  static Widget empty() => const GameplayPreviewWrapper(
    state: QuizState(status: QuizStatus.active, questions: []),
  );
}
