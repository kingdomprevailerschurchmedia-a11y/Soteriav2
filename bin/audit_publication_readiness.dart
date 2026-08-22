import 'dart:io';
import 'package:soteria/core/network/firebase_admin_interop.dart';
import 'package:googleapis/firestore/v1.dart';

void main() async {
  print('============================================================');
  print('SOTERIA — PUBLICATION READINESS AUDIT');
  print('============================================================');

  final admin = await FirebaseAdminInterop.initialize();
  if (admin == null) {
    print('ERROR: GOOGLE_APPLICATION_CREDENTIALS not set.');
    exit(1);
  }

  print('Project ID:      ${admin.projectId}');
  print('Service Account: ${admin.serviceAccountEmail}');
  print('------------------------------------------------------------');

  final List<String> canonicalCategories = [
    'general_knowledge', 'mathematics', 'science', 'technology',
    'history', 'geography', 'business', 'literature', 'sports',
    'current_affairs', 'medicine', 'arts', 'programming',
    'engineering', 'languages', 'law', 'finance', 'psychology', 'design'
  ];

  final List<Document> allQuestions = [];
  String? nextPageToken;
  final parent = 'projects/${admin.projectId}/databases/(default)/documents';

  print('Fetching all documents from "questions" collection...');
  try {
    do {
      final response = await admin.api.projects.databases.documents.list(
        parent,
        'questions',
        pageSize: 300,
        pageToken: nextPageToken,
      );
      allQuestions.addAll(response.documents ?? []);
      nextPageToken = response.nextPageToken;
    } while (nextPageToken != null);
  } catch (e) {
    print('ERROR FETCHING DOCUMENTS: $e');
    exit(1);
  }

  print('Total documents found: ${allQuestions.length}');

  final List<Document> approved = allQuestions.where((d) => d.fields?['status']?.stringValue == 'approved').toList();
  final List<Document> published = allQuestions.where((d) => d.fields?['status']?.stringValue == 'published').toList();

  print('Approved:  ${approved.length}');
  print('Published: ${published.length}');
  print('------------------------------------------------------------');

  // 1. Category Distribution for Approved
  final Map<String, int> catDistribution = {};
  for (final cat in canonicalCategories) {
    catDistribution[cat] = 0;
  }

  final Map<String, Map<String, int>> matrix = {};
  for (final cat in canonicalCategories) {
    matrix[cat] = {'easy': 0, 'medium': 0, 'hard': 0};
  }

  int invalidSchemaCount = 0;
  final Set<String> duplicateIds = {};
  final Set<String> seenIds = {};
  final Map<String, List<String>> textOverlap = {}; // normalizedText -> [ids]

  String normalize(String text) {
    return text.trim().toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '');
  }

  // Pre-populate seen published text
  final Set<String> publishedTexts = published.map((d) => normalize(d.fields?['text']?.stringValue ?? '')).toSet();
  final List<String> overlapsWithPublished = [];

  for (final doc in approved) {
    final fields = doc.fields;
    if (fields == null) {
      invalidSchemaCount++;
      continue;
    }

    final id = fields['id']?.stringValue;
    final docId = doc.name!.split('/').last;
    if (id != docId) {
      duplicateIds.add(docId);
    }
    if (seenIds.contains(docId)) {
      duplicateIds.add(docId);
    }
    seenIds.add(docId);

    final categoryId = fields['categoryId']?.stringValue ?? 'unknown';
    final difficulty = fields['difficulty']?.stringValue ?? 'unknown';
    final text = fields['text']?.stringValue ?? '';
    final normText = normalize(text);

    if (catDistribution.containsKey(categoryId)) {
      catDistribution[categoryId] = catDistribution[categoryId]! + 1;
    } else {
      catDistribution[categoryId] = 1;
    }

    if (matrix.containsKey(categoryId)) {
      if (matrix[categoryId]!.containsKey(difficulty)) {
        matrix[categoryId]![difficulty] = matrix[categoryId]![difficulty]! + 1;
      }
    }

    // Duplicate text check
    textOverlap.putIfAbsent(normText, () => []).add(docId);

    // Overlap with published
    if (publishedTexts.contains(normText)) {
      overlapsWithPublished.add(docId);
    }

    // Basic schema check
    if (fields['options']?.arrayValue?.values == null || 
        fields['correctOptionIds']?.arrayValue?.values == null ||
        fields['type']?.stringValue == null) {
      invalidSchemaCount++;
    }
  }

  print('CATEGORY DISTRIBUTION (APPROVED):');
  for (final cat in canonicalCategories) {
    final count = catDistribution[cat];
    print('  - ${cat.padRight(20)}: $count ${count == 0 ? "!!! ZERO !!!" : ""}');
  }

  print('\nDIFFICULTY DISTRIBUTION (APPROVED):');
  final Map<String, int> diffDist = {'easy': 0, 'medium': 0, 'hard': 0};
  for (final cat in canonicalCategories) {
    diffDist['easy'] = diffDist['easy']! + matrix[cat]!['easy']!;
    diffDist['medium'] = diffDist['medium']! + matrix[cat]!['medium']!;
    diffDist['hard'] = diffDist['hard']! + matrix[cat]!['hard']!;
  }
  diffDist.forEach((k, v) => print('  - ${k.padRight(10)}: $v'));

  print('\nCATEGORY × DIFFICULTY MATRIX (APPROVED):');
  print('  ${"Category".padRight(20)} | Easy | Med  | Hard | Total');
  print('  ${'-' * 50}');
  for (final cat in canonicalCategories) {
    final m = matrix[cat]!;
    final total = m['easy']! + m['medium']! + m['hard']!;
    print('  ${cat.padRight(20)} | ${m['easy'].toString().padLeft(4)} | ${m['medium'].toString().padLeft(4)} | ${m['hard'].toString().padLeft(4)} | $total');
  }

  print('\nLOW AVAILABILITY WARNINGS (< 20 per cell):');
  for (final cat in canonicalCategories) {
    matrix[cat]!.forEach((diff, count) {
      if (count < 20) {
        print('  [!] $cat ($diff): $count');
      }
    });
  }

  print('\nSCHEMA & INTEGRITY:');
  print('  - Invalid Schema Count: $invalidSchemaCount');
  print('  - Duplicate Doc IDs:    ${duplicateIds.length}');
  
  final textDuplicates = textOverlap.entries.where((e) => e.value.length > 1).toList();
  print('  - Duplicate Text Groups: ${textDuplicates.length}');
  if (textDuplicates.isNotEmpty) {
     for (var i = 0; i < (textDuplicates.length > 5 ? 5 : textDuplicates.length); i++) {
       print('    - Example: "${textDuplicates[i].key.substring(0, 30)}..." ids: ${textDuplicates[i].value}');
     }
  }
  print('  - Overlap with Published: ${overlapsWithPublished.length}');

  print('\nCURRENT AFFAIRS AUDIT:');
  final caQuestions = approved.where((d) => d.fields?['categoryId']?.stringValue == 'current_affairs').toList();
  print('  - Count: ${caQuestions.length}');
  final caDiff = {'easy': 0, 'medium': 0, 'hard': 0};
  for (final q in caQuestions) {
    final d = q.fields?['difficulty']?.stringValue ?? 'unknown';
    if (caDiff.containsKey(d)) caDiff[d] = caDiff[d]! + 1;
  }
  print('  - Distribution: $caDiff');
  
  print('\n  - Sample Content (to check for outdated events):');
  for (var i = 0; i < (caQuestions.length > 10 ? 10 : caQuestions.length); i++) {
    print('    - [${caQuestions[i].fields?['id']?.stringValue}] ${caQuestions[i].fields?['text']?.stringValue}');
  }

  print('============================================================');
}
