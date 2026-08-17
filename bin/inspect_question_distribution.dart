import 'dart:io';
import 'package:soteria/core/network/firebase_admin_interop.dart';
import 'package:googleapis/firestore/v1.dart';

/// Read-only diagnostic script to report the current Firestore status distribution for the questions collection.
/// Usage:
/// $env:GOOGLE_APPLICATION_CREDENTIALS="path/to/service-account.json"
/// dart run bin/inspect_question_distribution.dart

void main() async {
  print('============================================================');
  print('SOTERIA — FIREBASE QUESTION DISTRIBUTION INSPECTOR');
  print('============================================================');

  FirebaseAdminInterop? admin;
  try {
    admin = await FirebaseAdminInterop.initialize();
  } catch (e) {
    print('ERROR: Failed to initialize Admin SDK: $e');
    exit(1);
  }

  if (admin == null) {
    print('ERROR: GOOGLE_APPLICATION_CREDENTIALS not set.');
    exit(1);
  }

  print('Project ID:      ${admin.projectId}');
  print('Service Account: ${admin.serviceAccountEmail}');
  print('------------------------------------------------------------');

  final Map<String, int> statusDistribution = {};
  final Map<String, int> categoryDistribution = {};
  int totalDocuments = 0;

  try {
    print('Fetching all questions (paginated)...');
    
    String? nextPageToken;
    final parent = 'projects/${admin.projectId}/databases/(default)/documents';
    
    do {
      final response = await admin.api.projects.databases.documents.list(
        parent,
        'questions',
        pageSize: 300,
        pageToken: nextPageToken,
      );

      final documents = response.documents ?? [];
      totalDocuments += documents.length;

      for (final doc in documents) {
        final fields = doc.fields ?? {};
        
        // Extract status
        final statusValue = fields['status']?.stringValue ?? 'unknown';
        statusDistribution[statusValue] = (statusDistribution[statusValue] ?? 0) + 1;

        // Extract categoryId
        final categoryId = fields['categoryId']?.stringValue ?? 'unknown';
        categoryDistribution[categoryId] = (categoryDistribution[categoryId] ?? 0) + 1;
      }

      nextPageToken = response.nextPageToken;
    } while (nextPageToken != null);

    print('------------------------------------------------------------');
    print('SUMMARY:');
    print('Total Question Documents: $totalDocuments');
    print('------------------------------------------------------------');
    print('STATUS DISTRIBUTION:');
    statusDistribution.forEach((status, count) {
      print('  - ${status.padRight(15)}: $count');
    });

    print('------------------------------------------------------------');
    print('CATEGORY DISTRIBUTION:');
    final sortedCategories = categoryDistribution.keys.toList()..sort();
    for (final cat in sortedCategories) {
      print('  - ${cat.padRight(20)}: ${categoryDistribution[cat]}');
    }

    print('============================================================');
    
    // Check specific user requirements
    final approvedCount = statusDistribution['approved'] ?? 0;
    if (approvedCount >= 933) {
      print('NEW IMPORT VERIFICATION: At least 933 questions have status "approved".');
    } else {
      print('WARNING: Only $approvedCount questions have status "approved".');
    }

  } catch (e) {
    print('CRITICAL ERROR DURING INSPECTION: $e');
    exit(1);
  }
}
