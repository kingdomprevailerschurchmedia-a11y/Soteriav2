import 'dart:io';
import 'package:soteria/core/network/firebase_admin_interop.dart';
import 'package:googleapis/firestore/v1.dart';

void main() async {
  final admin = await FirebaseAdminInterop.initialize();
  if (admin == null) exit(1);
  final parent = 'projects/${admin.projectId}/databases/(default)/documents';
  String? nextPageToken;
  int totalFetched = 0;
  final List<Document> allDocs = [];

  do {
    final response = await admin.api.projects.databases.documents.list(
      parent,
      'questions',
      pageSize: 300,
      pageToken: nextPageToken,
    );
    final documents = response.documents ?? [];
    allDocs.addAll(documents);
    totalFetched += documents.length;
    nextPageToken = response.nextPageToken;
  } while (nextPageToken != null);

  print('Total Documents fetched: $totalFetched');
  final published = allDocs.where((d) => d.fields?['status']?.stringValue == 'published').toList();

  final Map<String, Map<String, int>> matrix = {};
  for (final doc in published) {
    final cat = doc.fields?['categoryId']?.stringValue ?? 'unknown';
    final diff = doc.fields?['difficulty']?.stringValue ?? 'unknown';
    matrix.putIfAbsent(cat, () => {'easy': 0, 'medium': 0, 'hard': 0})[diff] = (matrix[cat]![diff] ?? 0) + 1;
  }

  print('PUBLISHED CATEGORY x DIFFICULTY MATRIX:');
  matrix.forEach((cat, diffs) {
    print('  - $cat: $diffs');
  });
  print('Total Published: ${published.length}');
}
