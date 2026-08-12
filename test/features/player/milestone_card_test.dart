import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/player/domain/models/milestone.dart';
import 'package:soteria/features/player/presentation/widgets/milestone_card.dart';

void main() {
  Widget createTestWidget(MilestoneProgress progress) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        home: Scaffold(body: MilestoneCard(progress: progress)),
      ),
    );
  }

  group('MilestoneCard', () {
    const definition = MilestoneDefinition(
      id: 'm1',
      name: 'Test Milestone',
      description: 'Test Description',
      type: MilestoneType.count,
      category: MilestoneCategory.general,
      threshold: 10,
    );

    testWidgets('should show progress for in-progress milestone', (
      tester,
    ) async {
      const progress = MilestoneProgress(
        definition: definition,
        playerState: PlayerMilestone(
          userId: 'u1',
          milestoneId: 'm1',
          status: MilestoneStatus.inProgress,
          currentProgress: 5,
        ),
      );

      await tester.pumpWidget(createTestWidget(progress));
      await tester.pumpAndSettle();

      expect(find.text('Test Milestone'), findsOneWidget);
      expect(find.text('5 / 10'), findsOneWidget);
      expect(find.text('PROGRESS'), findsOneWidget);
    });

    testWidgets('should show completed state', (tester) async {
      const progress = MilestoneProgress(
        definition: definition,
        playerState: PlayerMilestone(
          userId: 'u1',
          milestoneId: 'm1',
          status: MilestoneStatus.completed,
          currentProgress: 10,
        ),
      );

      await tester.pumpWidget(createTestWidget(progress));
      await tester.pumpAndSettle();

      expect(find.text('COMPLETED'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
      expect(
        find.text('10 / 10'),
        findsNothing,
      ); // Should be hidden in completed state
    });

    testWidgets('should show locked state', (tester) async {
      const progress = MilestoneProgress(
        definition: definition,
        playerState: PlayerMilestone(
          userId: 'u1',
          milestoneId: 'm1',
          status: MilestoneStatus.locked,
          currentProgress: 0,
        ),
      );

      await tester.pumpWidget(createTestWidget(progress));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.lock_outline_rounded), findsOneWidget);
      expect(find.text('0 / 10'), findsOneWidget);
    });
  });
}
