import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/question.dart';
import '../domain/models/quiz_enums.dart';
import '../presentation/providers/question_providers.dart';
import '../data/repository/mock_question_repository.dart';
import '../../../../core/design_system/spacing/soteria_spacing.dart';
import '../../../../core/design_system/typography/soteria_typography.dart';
import '../../../../core/widgets/feedback/soteria_loader.dart';
import '../../../../core/widgets/feedback/soteria_error_widget.dart';

class QuestionLoaderPreview extends ConsumerWidget {
  final String title;
  final Override? providerOverride;

  const QuestionLoaderPreview({
    super.key,
    required this.title,
    this.providerOverride,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: providerOverride != null ? [providerOverride!] : [],
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const _QuestionListContent(),
      ),
    );
  }
}

class _QuestionListContent extends ConsumerWidget {
  const _QuestionListContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionsAsync = ref.watch(questionLoaderProvider(QuestionQuery()));

    return questionsAsync.when(
      data: (questions) {
        if (questions.isEmpty) {
          return const Center(child: Text('No questions found.'));
        }
        return ListView.builder(
          padding: EdgeInsets.all(SoteriaSpacing.md),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final q = questions[index];
            return Card(
              margin: EdgeInsets.only(bottom: SoteriaSpacing.md),
              child: ListTile(
                title: Text(q.text, style: context.titleSmall),
                subtitle: Text(
                  '${q.category} • ${q.difficulty.name.toUpperCase()}',
                ),
                trailing: Text('${q.xpValue} XP'),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: SoteriaLoader()),
      error: (error, stack) => Center(
        child: SoteriaErrorWidget(
          message: 'Failed to load questions: $error',
          onRetry: () => ref.refresh(questionLoaderProvider(QuestionQuery())),
        ),
      ),
    );
  }
}

// Concrete Preview Widgets

class QuestionLoaderLoadedPreview extends StatelessWidget {
  const QuestionLoaderLoadedPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionLoaderPreview(
      title: 'Questions Loaded (Mock)',
      providerOverride: questionRepositoryProvider.overrideWithValue(
        MockQuestionRepository(),
      ),
    );
  }
}

class QuestionLoaderEmptyPreview extends StatelessWidget {
  const QuestionLoaderEmptyPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionLoaderPreview(
      title: 'Empty State',
      providerOverride: questionRepositoryProvider.overrideWithValue(
        _EmptyMockRepository(),
      ),
    );
  }
}

class QuestionLoaderErrorPreview extends StatelessWidget {
  const QuestionLoaderErrorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return QuestionLoaderPreview(
      title: 'Error State',
      providerOverride: questionRepositoryProvider.overrideWithValue(
        _ErrorMockRepository(),
      ),
    );
  }
}

// Helpers

class _EmptyMockRepository extends MockQuestionRepository {
  @override
  Future<List<Question>> loadQuestions({
    String? categoryId,
    Difficulty? difficulty,
    bool forceRefresh = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
}

class _ErrorMockRepository extends MockQuestionRepository {
  @override
  Future<List<Question>> loadQuestions({
    String? categoryId,
    Difficulty? difficulty,
    bool forceRefresh = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    throw Exception('Simulated network failure');
  }
}
