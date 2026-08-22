import 'dart:io';
import 'package:firedart/firedart.dart';

/// Admin script to aggregate question analytics events into global performance documents.
/// This fulfills the Spark-plan requirement for secure aggregation without Cloud Functions.
/// Usage: dart bin/aggregate_question_analytics.dart <API_KEY> <PROJECT_ID>
void main(List<String> args) async {
  if (args.length < 2) {
    print('Usage: dart bin/aggregate_question_analytics.dart <API_KEY> <PROJECT_ID>');
    exit(1);
  }

  final apiKey = args[0];
  final projectId = args[1];

  Firestore.initialize(projectId);
  // Firedart doesn't use the API key in the same way as the client SDK for basic operations,
  // but it's good to have for authenticated paths if needed.

  print('SOTERIA — QUESTION ANALYTICS AGGREGATION');
  print('-----------------------------------------');

  final eventCollection = Firestore.instance.collection('question_analytics_events');
  final performanceCollection = Firestore.instance.collection('question_performance');

  try {
    final events = await eventCollection.get();
    print('Found ${events.length} events to process.');

    if (events.isEmpty) {
      print('No events to process. Exiting.');
      return;
    }

    // Map to store temporary aggregates to reduce Firestore writes
    final Map<String, List<Document>> groupedEvents = {};

    for (var eventDoc in events) {
      final data = eventDoc.map;
      final qId = data['questionId'];
      final version = data['version'] ?? '1.0.0';
      final partitionKey = '${qId}_v${version.replaceAll('.', '_')}';

      groupedEvents.putIfAbsent(partitionKey, () => []).add(eventDoc);
    }

    for (var entry in groupedEvents.entries) {
      final docId = entry.key;
      final batch = entry.value;

      print('Processing $docId (${batch.length} events)...');

      final perfDocRef = performanceCollection.document(docId);
      
      // Load current state for manual aggregation (Firedart lacks complex increments in some versions)
      Map<String, dynamic> currentData = {};
      List<String> processedEvents = [];
      try {
        final doc = await perfDocRef.get();
        currentData = Map<String, dynamic>.from(doc.map);
        processedEvents = List<String>.from(currentData['processedEvents'] ?? []);
      } catch (_) {
        // Document likely doesn't exist
      }

      int newCorrect = 0;
      int newIncorrect = 0;
      int newTimeout = 0;
      int newSkip = 0;
      int totalResponseTimeMs = 0;
      int eligibleResponseCount = 0;
      Map<String, int> modeUpdates = {};

      int addedCount = 0;

      for (var eventDoc in batch) {
        if (processedEvents.contains(eventDoc.id)) continue;

        final data = eventDoc.map;
        final outcome = data['outcome'];
        final responseTimeMs = data['responseTime'] ?? 0;
        final mode = data['mode'] ?? 'practice';

        if (outcome == 'correct') {
          newCorrect++;
        } else if (outcome == 'incorrect') newIncorrect++;
        else if (outcome == 'timedOut') newTimeout++;
        else if (outcome == 'skipped') newSkip++;

        if (outcome != 'skipped' && outcome != 'timedOut') {
          totalResponseTimeMs += responseTimeMs as int;
          eligibleResponseCount++;
        }

        modeUpdates[mode] = (modeUpdates[mode] ?? 0) + 1;
        processedEvents.add(eventDoc.id);
        addedCount++;
      }

      if (addedCount == 0) {
        print('  Skipped: All events already processed for $docId.');
        continue;
      }

      // Calculate new aggregates
      final int totalAttempts = (currentData['totalAttempts'] ?? 0) + addedCount;
      final int correctAttempts = (currentData['correctAttempts'] ?? 0) + newCorrect;
      final int incorrectAttempts = (currentData['incorrectAttempts'] ?? 0) + newIncorrect;
      final int timeoutCount = (currentData['timeoutCount'] ?? 0) + newTimeout;
      final int skipCount = (currentData['skipCount'] ?? 0) + newSkip;

      final int oldAvg = currentData['averageResponseTime'] ?? 0;
      // Note: This is a simplified rolling average for the batch
      // Real prod implementation would be more precise with total total time
      final int newAvg = totalAttempts > 0 
          ? ((oldAvg * (totalAttempts - addedCount)) + totalResponseTimeMs) ~/ totalAttempts
          : 0;

      final Map<String, dynamic> modeBreakdown = Map<String, dynamic>.from(currentData['modeBreakdown'] ?? {});
      modeUpdates.forEach((key, value) {
        modeBreakdown[key] = (modeBreakdown[key] ?? 0) + value;
      });

      final firstEvent = batch.first.map;
      
      final updates = {
        'questionId': firstEvent['questionId'],
        'version': firstEvent['version'],
        'categoryId': firstEvent['categoryId'],
        'difficulty': firstEvent['difficulty'],
        'totalAttempts': totalAttempts,
        'correctAttempts': correctAttempts,
        'incorrectAttempts': incorrectAttempts,
        'timeoutCount': timeoutCount,
        'skipCount': skipCount,
        'averageResponseTime': newAvg,
        'modeBreakdown': modeBreakdown,
        'processedEvents': processedEvents,
        'lastAttemptAt': DateTime.now().toIso8601String(),
      };

      await perfDocRef.set(updates);
      print('  Success: Processed $addedCount new events for $docId.');
    }

    print('-----------------------------------------');
    print('AGGREGATION COMPLETE.');

  } catch (e) {
    print('Error: $e');
    exit(1);
  }
}
