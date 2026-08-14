import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/models/practice_session_config.dart';
import 'package:soteria/features/question_content/domain/entities/difficulty.dart';
import 'package:soteria/features/gameplay_engine/services/reward_estimator.dart';

void main() {
  test('should estimate rewards correctly for easy', () {
    final estimator = RewardEstimator();
    final config = PracticeSessionConfig(
      questionCount: 10,
      difficulty: Difficulty.easy,
    );

    final rewards = estimator.estimate(config);

    // base_xp(10) * count(10) * mult_easy(1.0) = 100
    expect(rewards.xp, 100);
    expect(rewards.estimatedDuration.inMinutes, 5);
  });

  test('should estimate higher rewards for expert', () {
    final estimator = RewardEstimator();
    final config = PracticeSessionConfig(
      questionCount: 10,
      difficulty: Difficulty.expert,
    );

    final rewards = estimator.estimate(config);

    // base_xp(10) * count(10) * mult_expert(2.0) = 200
    expect(rewards.xp, 200);
  });
}
