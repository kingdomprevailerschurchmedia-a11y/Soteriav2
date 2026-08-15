import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../presentation/widgets/question_analytics_card.dart';
import '../domain/models/question_analytics.dart';
import '../../quiz/domain/models/quiz_enums.dart';

class QuestionAnalyticsPreviews extends StatelessWidget {
  const QuestionAnalyticsPreviews({super.key});

  @override
  Widget build(BuildContext context) {
    final mock1 = QuestionAnalytics(
      questionId: 'prod_math_001',
      version: '1.0.0',
      categoryId: 'mathematics',
      difficulty: Difficulty.medium,
      totalAttempts: 1500,
      correctAttempts: 1200,
      incorrectAttempts: 300,
      averageResponseTime: const Duration(seconds: 12),
      lastAttemptAt: DateTime.now().subtract(const Duration(minutes: 5)),
    );

    final mock2 = QuestionAnalytics(
      questionId: 'prod_math_001',
      version: '1.1.0',
      categoryId: 'mathematics',
      difficulty: Difficulty.medium,
      totalAttempts: 500,
      correctAttempts: 450,
      incorrectAttempts: 50,
      averageResponseTime: const Duration(seconds: 8),
      lastAttemptAt: DateTime.now(),
    );

    final mockBad = QuestionAnalytics(
      questionId: 'prod_logic_999',
      version: '1.0.0',
      categoryId: 'logic',
      difficulty: Difficulty.expert,
      totalAttempts: 100,
      correctAttempts: 12,
      incorrectAttempts: 88,
      timeoutCount: 45,
      averageResponseTime: const Duration(seconds: 45),
      lastAttemptAt: DateTime.now().subtract(const Duration(hours: 2)),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Standard Question (Stable)',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          QuestionAnalyticsCard(analytics: mock1),
          SizedBox(height: 30.h),
          const Text(
            'Improved Question (Post-Update)',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          QuestionAnalyticsCard(analytics: mock2),
          SizedBox(height: 30.h),
          const Text(
            'Problematic Question (Low Accuracy)',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          QuestionAnalyticsCard(analytics: mockBad),
        ],
      ),
    );
  }
}
