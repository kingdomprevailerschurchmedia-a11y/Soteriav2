import 'dart:io';
import 'package:firedart/firedart.dart';

// Standalone script for production question publication.
// Usage: dart run bin/publish_ready_questions.dart [--execute] [--auth <email>:<password>]

void main(List<String> args) async {
  const projectId = 'soteriav2-b4042';
  const apiKey = 'AIzaSyAo1el2cRS6VtggUY9FgXexDIe1f0ElAwo'; // From firebase_options.dart

  final execute = args.contains('--execute');
  
  String? authEmail;
  String? authPassword;
  
  final authIdx = args.indexOf('--auth');
  if (authIdx != -1 && args.length > authIdx + 1) {
    final credentials = args[authIdx + 1].split(':');
    if (credentials.length == 2) {
      authEmail = credentials[0];
      authPassword = credentials[1];
    }
  }

  print('============================================================');
  print('SOTERIA — PRODUCTION QUESTION PUBLICATION');
  print('============================================================');
  print('Project ID:  $projectId');
  print('Mode:        ${execute ? "EXECUTE (PHYSICAL WRITE)" : "DRY RUN"}');
  if (authEmail != null) {
    print('Auth:        $authEmail');
  }
  print('============================================================');

  try {
    // 1. Initialize Firebase Auth and Sign In if provided
    if (authEmail != null && authPassword != null) {
      FirebaseAuth.initialize(apiKey, VolatileStore());
      await FirebaseAuth.instance.signIn(authEmail, authPassword);
      print('Successfully authenticated as admin.');
    }

    // 2. Initialize Firestore
    Firestore.initialize(projectId);

    final snapshot = await Firestore.instance
        .collection('questions')
        .get();

    print('Total Questions in DB: ${snapshot.length}');

    final List<String> readyIds = [];
    final List<String> blockedIds = [];
    final List<String> alreadyPublishedIds = [];

    for (final doc in snapshot) {
      final id = doc.id;
      final status = doc['status'];
      
      if (status == 'published') {
        alreadyPublishedIds.add(id);
        continue;
      }
      
      if (status == 'approved') {
        if (id.startsWith('prod_ca_')) {
          blockedIds.add(id);
        } else {
          readyIds.add(id);
        }
      }
    }

    print('Already PUBLISHED: ${alreadyPublishedIds.length}');
    print('READY to publish (Approved): ${readyIds.length}');
    print('BLOCKED (Current Affairs): ${blockedIds.length}');

    if (readyIds.isEmpty) {
       print('No new questions are ready for publication.');
    }

    if (execute) {
      if (readyIds.isEmpty) {
        print('ABORT: Nothing to publish.');
        return;
      }

      print('Executing batch publication...');
      int successCount = 0;
      for (final id in readyIds) {
        try {
          await Firestore.instance.collection('questions').document(id).update({
            'status': 'published',
            'updatedAt': DateTime.now().toIso8601String(),
          });
          successCount++;
          print('  [PUBLISHED] $id');
        } catch (e) {
          print('  [FAILED]  $id: $e');
        }
      }
      print('------------------------------------------------------------');
      print('Publication Complete. Succeeded: $successCount');
    } else {
      print('------------------------------------------------------------');
      print('Dry run successful.');
      if (readyIds.isNotEmpty) {
        print('Use --execute to publish ${readyIds.length} questions.');
      }
    }
  } catch (e) {
    print('CRITICAL ERROR: $e');
    exit(1);
  }
}
