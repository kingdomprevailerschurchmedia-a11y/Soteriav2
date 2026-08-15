import '../../domain/entities/question.dart';
import '../../domain/entities/difficulty.dart';

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

  /// Audits a question for quality signals (non-breaking).
  static List<String> audit(Question question) {
    final warnings = <String>[];

    if (question.xpValue > 1000) {
      warnings.add('Quality: XP value is unusually high (> 1000).');
    }

    if (question.coinValue > 100) {
      warnings.add('Quality: Coin value is unusually high (> 100).');
    }

    if (question.estimatedTime.inSeconds < 5 || question.estimatedTime.inSeconds > 120) {
      warnings.add('Quality: Estimated time is outside typical range (5-120s).');
    }

    if (question.difficulty == Difficulty.hard && (question.explanation == null || question.explanation!.trim().isEmpty)) {
      warnings.add('Quality: Hard difficulty question is missing an explanation.');
    }

    final versionRegex = RegExp(r'^\d+\.\d+\.\d+$');
    if (!versionRegex.hasMatch(question.version)) {
      warnings.add('Quality: Version does not follow semantic versioning.');
    }

    if (question.source.trim().isEmpty) {
      warnings.add('Quality: Question source is missing.');
    }

    return warnings;
  }
}
