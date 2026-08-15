import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/competitive_review_item.dart';
import '../../dashboard/presentation/providers/pro_lobby_providers.dart';
import '../../question_content/domain/entities/question.dart';
import '../../question_content/presentation/providers/question_bank_providers.dart';

final proModeReviewProvider = FutureProvider.family<List<CompetitiveReviewItem>, String>((ref, sessionId) async {
  final repo = ref.read(proModeRepositoryProvider);
  final result = await repo.getResult(sessionId);
  
  if (result == null) throw Exception('Result not found');
  
  // Fetch questions to build review items
  final questionRepo = ref.read(questionRepositoryProvider);
  
  final items = <CompetitiveReviewItem>[];
  
  for (final answer in result.answers) {
    final question = await questionRepo.getQuestionById(answer.questionId);
    if (question != null) {
      items.add(CompetitiveReviewItem(
        questionId: question.id,
        questionText: question.text,
        selectedAnswer: _getSelectedAnswerText(question, answer.selectedOptionIds),
        correctAnswer: _getSelectedAnswerText(question, answer.correctOptionIds),
        explanation: question.explanation ?? 'No explanation provided.',
        reference: question.source,
        difficulty: question.difficulty.name,
        timeTaken: answer.responseTime,
        isCorrect: answer.isCorrect,
      ));
    }
  }
  
  return items;
});

String _getSelectedAnswerText(Question question, List<String> optionIds) {
  if (optionIds.isEmpty) return 'Unanswered';
  
  try {
    return optionIds.map((id) {
      final option = question.options.firstWhere((o) => o.id == id);
      return option.text;
    }).join(', ');
  } catch (_) {
    return 'Unknown Answer';
  }
}
