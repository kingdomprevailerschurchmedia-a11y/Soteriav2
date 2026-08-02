import 'package:soteria/features/question_content/domain/entities/question.dart';

/// Service responsible for validating question integrity and schema compliance.
class QuestionValidator {
  /// Validates a question against production requirements.
  /// Returns a list of error messages, or an empty list if valid.
  static List<String> validate(Question question) {
    final errors = <String>[];

    if (question.text.isEmpty) {
      errors.add('Question text cannot be empty.');
    }

    if (question.options.isEmpty) {
      errors.add('Question must have at least one option.');
    }

    if (question.correctAnswers.isEmpty) {
      errors.add('Question must have at least one correct answer.');
    }

    // Verify all correct answer IDs exist in the options
    final optionIds = question.options.map((o) => o.id).toSet();
    for (final correctId in question.correctAnswers) {
      if (!optionIds.contains(correctId)) {
        errors.add('Correct answer ID "$correctId" does not exist in options.');
      }
    }

    // Detect duplicate options
    final uniqueOptions = question.options
        .map((o) => o.text.trim().toLowerCase())
        .toSet();
    if (uniqueOptions.length != question.options.length) {
      errors.add('Question contains duplicate options.');
    }

    return errors;
  }
}
