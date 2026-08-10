import 'package:flutter/material.dart';
import '../../../core/design_system/spacing/soteria_spacing.dart';
import '../../preview_gallery/widgets/preview_wrapper.dart';
import '../domain/models/quiz_enums.dart';
import '../presentation/states/quiz_state.dart';
import '../domain/models/timer_state.dart';
import '../domain/models/power_up_state.dart';
import '../domain/models/quiz_session.dart';
import '../domain/models/quiz_result.dart';

class QuizEnginePreview extends StatelessWidget {
  const QuizEnginePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewWrapper(
      title: 'Quiz Engine Foundation',
      builder: (context, state) {
        return ListView(
          padding: EdgeInsets.all(SoteriaSpacing.lg),
          children: [
            _buildSection('Quiz States', [
              const _StateDebugCard(title: 'Idle / Initial', data: QuizState()),
              const _StateDebugCard(
                title: 'Loading',
                data: QuizState(isLoading: true),
              ),
              const _StateDebugCard(
                title: 'Empty (No Questions)',
                data: QuizState(questions: []),
              ),
              const _StateDebugCard(
                title: 'Error State',
                data: QuizState(error: 'Failed to connect to Quiz Server'),
              ),
              const _StateDebugCard(
                title: 'Offline State',
                data: QuizState(isOffline: true),
              ),
              _StateDebugCard(
                title: 'Active Session',
                data: QuizState(
                  status: QuizStatus.active,
                  currentIndex: 2,
                  score: 1500,
                  streak: 5,
                  timer: TimerState.initial(30).copyWith(
                    isRunning: true,
                    remainingTime: const Duration(seconds: 18),
                  ),
                ),
              ),
              _StateDebugCard(
                title: 'Success / Completed',
                data: QuizState(
                  status: QuizStatus.completed,
                  result: QuizResult(
                    sessionId: 's1',
                    playerId: 'p1',
                    gameMode: GameMode.practice,
                    category: 'Science',
                    difficulty: Difficulty.easy,
                    totalQuestions: 10,
                    answeredQuestions: 10,
                    correctAnswers: 9,
                    wrongAnswers: 1,
                    skipped: 0,
                    timedOut: 0,
                    accuracy: 0.9,
                    finalScore: 4500,
                    xpEarned: 500,
                    coinsEarned: 100,
                    longestStreak: 8,
                    finalStreak: 3,
                    averageResponseTime: const Duration(seconds: 4),
                    fastestResponseTime: const Duration(seconds: 2),
                    slowestResponseTime: const Duration(seconds: 10),
                    questionResults: [],
                    completedAt: DateTime.now(),
                    completionTime: const Duration(minutes: 5),
                    performanceRating: 'Excellent',
                  ),
                ),
              ),
            ]),
            SizedBox(height: SoteriaSpacing.xl),
            _buildSection('Component Snapshots', [
              _ModelDebugCard(
                title: 'TimerState (Running)',
                data: TimerState.initial(30).copyWith(
                  isRunning: true,
                  remainingTime: const Duration(seconds: 12),
                  progress: 0.4,
                ),
              ),
              _ModelDebugCard(
                title: 'TimerState (Expired)',
                data: const TimerState(
                  totalDuration: Duration(seconds: 30),
                  remainingTime: Duration.zero,
                  progress: 0.0,
                  hasExpired: true,
                ),
              ),
              _ModelDebugCard(
                title: 'PowerUpState (Available)',
                data: const PowerUpState(
                  type: PowerUpType.fiftyFifty,
                  status: PowerUpStatus.available,
                ),
              ),
              _ModelDebugCard(
                title: 'PowerUpState (Used)',
                data: const PowerUpState(
                  type: PowerUpType.askAudience,
                  status: PowerUpStatus.used,
                  remainingUses: 0,
                ),
              ),
            ]),
          ],
        );
      },
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        const Divider(),
        ...children,
      ],
    );
  }
}

class _StateDebugCard extends StatelessWidget {
  final String title;
  final dynamic data;
  const _StateDebugCard({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.toString(),
              style: const TextStyle(fontSize: 10, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModelDebugCard extends StatelessWidget {
  final String title;
  final dynamic data;
  const _ModelDebugCard({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.toString(),
              style: const TextStyle(fontSize: 10, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
