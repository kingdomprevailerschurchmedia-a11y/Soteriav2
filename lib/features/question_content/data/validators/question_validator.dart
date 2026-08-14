import '../../domain/entities/question.dart';

/// Service responsible for validating question integrity and quality rules.
class QuestionValidator {
  /// Validates a question against production requirements.
  static List<String> validate(Question question) {
    final errors = <String>[];

    if (question.text.trim().isEmpty) {
      errors.add('Question text cannot be empty.');
    }

    if (question.categoryId.trim().isEmpty) {
      errors.add('Category ID is required.');
    }

    if (question.type == QuestionType.multipleChoice) {
      if (question.options.length < 2) {
        errors.add('Multiple choice questions must have at least 2 options.');
      }
      if (question.correctOptionIds.length != 1) {
        errors.add('Multiple choice questions must have exactly one correct option.');
      }
    }

    if (question.correctOptionIds.isEmpty) {
      errors.add('Question must have at least one correct answer ID.');
    }

    // Verify all correct answer IDs exist in the options
    final optionIds = question.options.map((o) => o.id).toSet();
    for (final correctId in question.correctOptionIds) {
      if (!optionIds.contains(correctId)) {
        errors.add('Correct option ID "$correctId" does not exist in options.');
      }
    }

    // Detect duplicate options text
    final uniqueOptions = question.options
        .map((o) => o.text.trim().toLowerCase())
        .toSet();
    if (uniqueOptions.length != question.options.length) {
      errors.add('Question contains duplicate option text.');
    }

    // Detect duplicate option IDs
    if (optionIds.length != question.options.length) {
      errors.add('Question contains duplicate option IDs.');
    }

    if (question.xpValue < 0) {
      errors.add('XP value cannot be negative.');
    }

    return errors;
  }
}
