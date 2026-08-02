import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soteria/core/widgets/safe_gradient_scaffold.dart';
import 'package:soteria/features/gameplay_engine/models/game_configuration.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';
import 'package:soteria/features/gameplay_engine/providers/game_engine_provider.dart';
import 'package:soteria/features/gameplay_engine/pages/game_shell_page.dart';

class GameEnginePreviewGallery extends StatelessWidget {
  const GameEnginePreviewGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeGradientScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _PreviewSection(
              title: 'Standard Pro Mode',
              child: _GamePreview(config: GameConfiguration.pro()),
            ),
            _PreviewSection(
              title: 'Practice Mode (No Timer)',
              child: _GamePreview(config: GameConfiguration.practice()),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _PreviewSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 600, child: child),
        const Divider(color: Colors.white24),
      ],
    );
  }
}

class _GamePreview extends ConsumerWidget {
  final GameConfiguration config;
  const _GamePreview({required this.config});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Inject mock questions for preview
    final questions = [
      Question(
        id: '1',
        version: '1',
        text: 'What is the primary objective of Soteria?',
        options: const [
          Answer(id: 'a', text: 'Secure Identity'),
          Answer(id: 'b', text: 'Play Games'),
          Answer(id: 'c', text: 'Social Media'),
          Answer(id: 'd', text: 'Online Shopping'),
        ],
        correctAnswers: const ['a'],
        difficulty: QuestionDifficulty.easy,
        category: 'General',
        type: QuestionType.multipleChoice,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        source: 'Mock',
        schemaVersion: 1,
        contentHash: 'mock',
      ),
    ];

    // Auto-start session for preview
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameEngineProvider(config).notifier).startSession(questions);
    });

    return ClipRRect(child: GameShellPage(config: config));
  }
}
