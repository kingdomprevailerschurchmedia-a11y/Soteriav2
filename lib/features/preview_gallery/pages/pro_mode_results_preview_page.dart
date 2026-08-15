import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../preview/pro_mode/pro_mode_results_previews.dart';
import '../../../../core/design_system/colors/soteria_colors.dart';

class ProModeResultsPreviewPage extends StatelessWidget {
  const ProModeResultsPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'PRO RESULTS PREVIEW',
            style: TextStyle(
              color: SoteriaColors.gold,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: SoteriaColors.gold,
            labelColor: SoteriaColors.gold,
            unselectedLabelColor: Colors.white38,
            tabs: const [
              Tab(text: 'PERFECT (S)'),
              Tab(text: 'EXCELLENT (A)'),
              Tab(text: 'AVERAGE (C)'),
              Tab(text: 'LOW (D)'),
              Tab(text: 'UNANSWERED'),
              Tab(text: 'TIMEOUT'),
              Tab(text: 'OFFLINE SYNC'),
              Tab(text: 'EARNED'),
              Tab(text: 'LOADING'),
              Tab(text: 'ERROR'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProModeResultsPreviews.perfectScore(),
            ProModeResultsPreviews.excellentResult(),
            ProModeResultsPreviews.averageResult(),
            ProModeResultsPreviews.lowResult(),
            ProModeResultsPreviews.unansweredQuestions(),
            ProModeResultsPreviews.timeoutResult(),
            ProModeResultsPreviews.offlineSyncPending(),
            ProModeResultsPreviews.rewardEarned(),
            ProModeResultsPreviews.loading(),
            ProModeResultsPreviews.error(),
          ],
        ),
      ),
    );
  }
}
