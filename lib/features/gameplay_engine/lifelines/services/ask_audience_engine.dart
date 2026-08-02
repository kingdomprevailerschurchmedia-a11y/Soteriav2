import 'package:soteria/features/gameplay_engine/lifelines/models/lifeline_type.dart';
import 'package:soteria/features/gameplay_engine/lifelines/services/lifeline_engine.dart';
import 'package:soteria/features/gameplay_engine/lifelines/services/audience_simulation_strategy.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';

class AskAudienceEngine implements LifelineEngine {
  final AudienceSimulationStrategy _strategy;

  AskAudienceEngine({AudienceSimulationStrategy? strategy})
    : _strategy = strategy ?? DifficultyBasedSimulationStrategy();

  @override
  LifelineType get type => LifelineType.askAudience;

  @override
  Future<Map<String, double>> activate({
    required Question question,
    Map<String, dynamic>? context,
  }) async {
    // Simulate thinking time
    await Future.delayed(const Duration(milliseconds: 800));
    return _strategy.simulate(question);
  }
}
