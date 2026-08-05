import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/gameplay_engine/models/practice_session_config.dart';
import 'package:soteria/features/gameplay_engine/services/reward_estimator.dart';

void main() {
  test('should estimate rewards correctly for beginner', () {
    final estimator = RewardEstimator();
    const config = PracticeSessionConfig(
      questionCount: 10,
      difficulty: PracticeDifficulty.beginner,
    );
    
    final rewards = estimator.estimate(config);
    
    // base_xp(10) * count(10) * mult_beginner(1.0) = 100
    expect(rewards.xp, 100);
    expect(rewards.estimatedDuration.inMinutes, 5);
  });

  test('should estimate higher rewards for advanced', () {
    final estimator = RewardEstimator();
    const config = PracticeSessionConfig(
      questionCount: 10,
      difficulty: PracticeDifficulty.advanced,
    );
    
    final rewards = estimator.estimate(config);
    
    // base_xp(10) * count(10) * mult_advanced(1.5) = 150
    expect(rewards.xp, 150);
  });
}
