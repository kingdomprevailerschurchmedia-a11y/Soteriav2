import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_type.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';

abstract class LifelineEngine {
  LifelineType get type;
  Future<dynamic> activate({
    required Question question,
    Map<String, dynamic>? context,
  });
}
