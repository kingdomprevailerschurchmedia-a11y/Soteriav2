import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/competitive_personal_record.dart';
import '../presentation/providers/personal_record_providers.dart';
import '../presentation/screens/personal_records_screen.dart';
import '../presentation/widgets/personal_record_card.dart';

class PersonalRecordPreviewWrapper extends StatelessWidget {
  final List<CompetitivePersonalRecord> records;
  final bool isLoading;
  final Object? error;

  const PersonalRecordPreviewWrapper({
    super.key,
    required this.records,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        currentUserPersonalRecordsProvider.overrideWith(
          (ref) => isLoading
              ? Stream.fromFuture(Completer<List<CompetitivePersonalRecord>>().future)
              : Stream.value(records),
        ),
      ],
      child: const PersonalRecordsScreen(),
    );
  }
}

class PersonalRecordPreviews {
  static List<CompetitivePersonalRecord> mockRecords() {
    final now = DateTime.now();
    return [
      CompetitivePersonalRecord(
        id: 'r1',
        userId: 'u1',
        type: CompetitiveRecordType.highestScore,
        value: 9850,
        displayValue: '9,850',
        matchId: 'm1',
        seasonId: 's5',
        achievedAt: now.subtract(const Duration(days: 2)),
        previousValue: 9420,
        isCareerRecord: true,
      ),
      CompetitivePersonalRecord(
        id: 'r2',
        userId: 'u1',
        type: CompetitiveRecordType.bestAccuracy,
        value: 0.965,
        displayValue: '96.5%',
        matchId: 'm2',
        seasonId: 's5',
        achievedAt: now.subtract(const Duration(days: 5)),
        previousValue: 0.94,
        isCareerRecord: true,
      ),
      CompetitivePersonalRecord(
        id: 'r3',
        userId: 'u1',
        type: CompetitiveRecordType.longestWinStreak,
        value: 12,
        displayValue: '12',
        seasonId: 's5',
        achievedAt: now.subtract(const Duration(days: 10)),
        previousValue: 8,
        isCareerRecord: true,
      ),
      CompetitivePersonalRecord(
        id: 'r4',
        userId: 'u1',
        type: CompetitiveRecordType.bestRankReached,
        value: 2800,
        displayValue: 'Diamond II',
        seasonId: 's4',
        achievedAt: now.subtract(const Duration(days: 45)),
        isCareerRecord: true,
      ),
      // Seasonal records
      CompetitivePersonalRecord(
        id: 'rs1',
        userId: 'u1',
        type: CompetitiveRecordType.highestScore,
        value: 8900,
        displayValue: '8,900',
        matchId: 'm3',
        seasonId: 's5',
        achievedAt: now.subtract(const Duration(days: 1)),
        isCareerRecord: false,
      ),
    ];
  }

  static Widget gallery() => PersonalRecordPreviewWrapper(records: mockRecords());

  static Widget empty() => const PersonalRecordPreviewWrapper(records: []);

  static Widget loading() => const PersonalRecordPreviewWrapper(records: [], isLoading: true);

  static Widget error() => const PersonalRecordPreviewWrapper(
        records: [],
        error: 'Failed to load personal records',
      );

  static Widget singleCard() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PersonalRecordCard(
          record: mockRecords().first,
        ),
      ),
    );
  }
}
