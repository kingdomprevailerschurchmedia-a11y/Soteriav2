import 'dart:io';
import 'package:firedart/firedart.dart';
import 'package:soteria/core/network/firebase_admin_interop.dart';

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

  // Initialize Admin Interop (Service Account) if available via environment variable
  FirebaseAdminInterop? admin;
  try {
    admin = await FirebaseAdminInterop.initialize();
  } catch (e) {
    print('WARNING: Failed to initialize Admin SDK: $e');
  }

  print('============================================================');
  print('SOTERIA — PRODUCTION QUESTION PUBLICATION');
  print('============================================================');
  print('Project ID:  $projectId');
  print('Mode:        ${execute ? "EXECUTE (PHYSICAL WRITE)" : "DRY RUN"}');

  if (admin != null) {
    print('Auth Source: Service Account (ADC)');
    print('Admin Email: ${admin.serviceAccountEmail}');
  } else if (authEmail != null) {
    print('Auth Source: Client Firebase Auth');
    print('User Email:  $authEmail');
  } else {
    print('Auth Source: Unauthenticated (Read-only if rules allow)');
  }
  print('============================================================');

  try {
    // 1. Initialize Firebase Auth and Sign In if provided (Fallback)
    if (authEmail != null && authPassword != null) {
      FirebaseAuth.initialize(apiKey, VolatileStore());
      await FirebaseAuth.instance.signIn(authEmail, authPassword);
      print('Successfully authenticated as user.');
    }

    // 2. Initialize Firestore (Firedart fallback)
    Firestore.initialize(projectId);

    // 3. Pre-flight connectivity check for Admin SDK
    if (admin != null) {
      print('Verifying Admin Connectivity...');
      await admin.verifyConnectivity();
      print('Admin connectivity verified.');
    }

    final List<String> readyIds = [];
    final List<String> blockedIds = [];
    final List<String> alreadyPublishedIds = [];

    print('Fetching current question states...');

    if (admin != null) {
      // Use Admin SDK to list documents (bypasses rules)
      String? nextPageToken;
      final parent = 'projects/$projectId/databases/(default)/documents';
      
      do {
        final response = await admin.api.projects.databases.documents.list(
          parent,
          'questions',
          pageSize: 300,
          pageToken: nextPageToken,
        );

        final documents = response.documents ?? [];
        for (final doc in documents) {
          final id = doc.name!.split('/').last;
          final status = doc.fields?['status']?.stringValue;
          
          if (status == 'published') {
            alreadyPublishedIds.add(id);
          } else if (status == 'approved') {
            if (id.startsWith('prod_ca_')) {
              blockedIds.add(id);
            } else {
              readyIds.add(id);
            }
          }
        }
        nextPageToken = response.nextPageToken;
      } while (nextPageToken != null);
    } else {
      // Use Firedart (Subject to rules)
      final snapshot = await Firestore.instance
          .collection('questions')
          .get();

      for (final doc in snapshot) {
        final id = doc.id;
        final status = doc['status'];
        
        if (status == 'published') {
          alreadyPublishedIds.add(id);
        } else if (status == 'approved') {
          if (id.startsWith('prod_ca_')) {
            blockedIds.add(id);
          } else {
            readyIds.add(id);
          }
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
          final updates = {
            'status': 'published',
            'updatedAt': DateTime.now().toIso8601String(),
          };

          if (admin != null) {
            // Use Admin SDK (Bypasses rules)
            await admin.writeQuestion(id, updates);
          } else {
            // Use Firedart (Subject to rules)
            await Firestore.instance.collection('questions').document(id).update(updates);
          }
          
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
