import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:soteria/features/player/presentation/widgets/missions/competitive_mission_card.dart';
import 'package:soteria/features/player/preview/mission_fixtures.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  testWidgets('CompetitiveMissionCard displays mission information', (tester) async {
    final mission = MissionFixtures.activeDaily();
    
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: CompetitiveMissionCard(mission: mission),
          ),
        ),
      ),
    );
    
    expect(find.text(mission.definition.title), findsOneWidget);
    expect(find.text(mission.definition.description), findsOneWidget);
    expect(find.text('1 / 2'), findsOneWidget);
    expect(find.text('+100 XP'), findsOneWidget);
  });

  testWidgets('CompetitiveMissionCard shows CLAIM button when completed', (tester) async {
    final mission = MissionFixtures.completedDaily();
    
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: CompetitiveMissionCard(mission: mission),
          ),
        ),
      ),
    );
    
    expect(find.text('CLAIM REWARD'), findsOneWidget);
  });
}
