import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soteria/features/player/domain/models/competitive_personal_record.dart';
import 'package:soteria/features/player/presentation/providers/personal_record_providers.dart';
import 'package:soteria/features/player/presentation/screens/personal_records_screen.dart';
import 'package:soteria/features/player/presentation/widgets/personal_record_card.dart';

void main() {
  Widget createTestWidget({
    List<CompetitivePersonalRecord> records = const [],
    bool isLoading = false,
  }) {
    return ProviderScope(
      overrides: [
        currentUserPersonalRecordsProvider.overrideWith(
          (ref) => isLoading 
              ? Stream.fromFuture(Completer<List<CompetitivePersonalRecord>>().future)
              : Stream.value(records),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) => const MaterialApp(home: PersonalRecordsScreen()),
      ),
    );
  }

  testWidgets('should show empty state when no records', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('No Records Yet'), findsOneWidget);
    expect(find.byType(PersonalRecordCard), findsNothing);
  });

  testWidgets('should show career records when available', (tester) async {
    final records = [
      CompetitivePersonalRecord(
        id: 'r1',
        userId: 'u1',
        type: CompetitiveRecordType.highestScore,
        value: 9850,
        displayValue: '9,850',
        achievedAt: DateTime.now(),
        isCareerRecord: true,
      ),
    ];

    await tester.pumpWidget(createTestWidget(records: records));
    await tester.pumpAndSettle();

    expect(find.text('CAREER BESTS'), findsOneWidget);
    expect(find.byType(PersonalRecordCard), findsOneWidget);
    expect(find.text('9,850'), findsOneWidget);
  });
}
