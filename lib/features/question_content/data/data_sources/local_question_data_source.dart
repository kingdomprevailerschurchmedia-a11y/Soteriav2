import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/question_dto.dart';

/// Data source for loading questions from local JSON assets.
class LocalQuestionDataSource {
  static const String _starterBankPath = 'assets/data/practice_starter.json';

  /// Loads the starter practice questions from local assets.
  Future<List<QuestionDto>> fetchStarterQuestions() async {
    try {
      final String jsonString = await rootBundle.loadString(_starterBankPath);
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => QuestionDto.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      // Return empty list if asset fails to load to prevent crashes
      return [];
    }
  }
}
