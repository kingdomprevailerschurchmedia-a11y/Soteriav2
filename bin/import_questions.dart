import 'dart:io';
import 'dart:convert';
import 'package:firedart/firedart.dart';
import 'package:soteria/features/question_content/data/models/question_dto.dart';
import 'package:soteria/features/question_content/data/mappers/question_mapper.dart';
import 'package:soteria/features/question_content/data/validators/question_validator.dart';
import 'package:soteria/core/network/firebase_admin_interop.dart';

// Standalone script for physical Firestore import.
// Usage: dart run bin/import_questions.dart [path_to_json] [--execute] [--auth <email>:<password>]

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: dart run bin/import_questions.dart <path_to_json> [--execute] [--auth <email>:<password>]');
    return;
  }

  final path = args[0];
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

  const projectId = 'soteriav2-b4042';
  const apiKey = 'AIzaSyAo1el2cRS6VtggUY9FgXexDIe1f0ElAwo'; // From firebase_options.dart

  // Initialize Admin Interop (Service Account) if available via environment variable
  FirebaseAdminInterop? admin;
  try {
    admin = await FirebaseAdminInterop.initialize();
  } catch (e) {
    print('WARNING: Failed to initialize Admin SDK: $e');
  }

  print('============================================================');
  print('SOTERIA — PRODUCTION QUESTION IMPORT');
  print('============================================================');
  print('Project ID:  $projectId');
  print('Collection:  questions');
  print('Target File: $path');
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
    // 1. Initialize Firebase Auth and Sign In if provided (Fallback for non-admin)
    if (authEmail != null && authPassword != null) {
      FirebaseAuth.initialize(apiKey, VolatileStore());
      await FirebaseAuth.instance.signIn(authEmail, authPassword);
      print('Successfully authenticated as user.');
    }

    // 2. Initialize Firestore (Firedart fallback)
    Firestore.initialize(projectId);

    // 3. Pre-flight connectivity check for Admin SDK if executing
    if (execute && admin != null) {
      print('Verifying Admin Connectivity...');
      await admin.verifyConnectivity();
      print('Admin connectivity verified.');
    }

    final file = File(path);
    if (!file.existsSync()) {
      print('Error: File not found at $path');
      return;
    }

    final jsonContent = await file.readAsString();
    final List<dynamic> data = jsonDecode(jsonContent);
    
    int valid = 0;
    int invalid = 0;
    int duplicatesInBatch = 0;
    int nearDuplicatesInBatch = 0;
    int existingInFirestore = 0;
    List<QuestionDto> toCreate = [];

    final Set<String> batchIds = {};
    final Set<String> normalizedTexts = {};

    print('Starting Validation...');

    String normalize(String text) {
      return text.trim().toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '');
    }

    for (var i = 0; i < data.length; i++) {
      try {
        final dto = QuestionDto.fromJson(data[i] as Map<String, dynamic>);
        
        // Internal ID duplicate check
        if (batchIds.contains(dto.id)) {
          duplicatesInBatch++;
          continue;
        }
        batchIds.add(dto.id);

        // Near-duplicate text detection
        final norm = normalize(dto.text);
        if (normalizedTexts.contains(norm)) {
          nearDuplicatesInBatch++;
          print('  [WARNING] Row $i (${dto.id}): Possible near-duplicate detected in batch.');
        }
        normalizedTexts.add(norm);

        // Domain validation
        final entity = QuestionMapper.fromDto(dto);
        final validationErrors = QuestionValidator.validate(entity);
        
        if (validationErrors.isNotEmpty) {
          invalid++;
          print('  [INVALID] Row $i (${dto.id}): ${validationErrors.join(", ")}');
          continue;
        }

        // Firestore existence check
        bool exists = false;
        try {
          if (admin != null) {
            // Admin SDK bypasses rules
            final docPath = 'projects/$projectId/databases/(default)/documents/questions/${dto.id}';
            await admin.api.projects.databases.documents.get(docPath);
            exists = true;
          } else {
            // Firedart fallback (subject to rules)
            final doc = await Firestore.instance.collection('questions').document(dto.id).get();
            exists = doc != null;
          }
        } catch (e) {
          // If 404/NotFound, document doesn't exist.
          // Firedart returns null on not found. 
          // googleapis throws DetailedApiRequestError with 404.
          exists = false;
        }

        if (exists) {
          existingInFirestore++;
          // We do not overwrite existing questions
          continue;
        }

        valid++;
        toCreate.add(dto);
      } catch (e) {
        invalid++;
        print('  [ERROR] Row $i: Parsing failed: $e');
      }
    }

    print('------------------------------------------------------------');
    print('DRY RUN RESULT:');
    print('Total Records:      ${data.length}');
    print('Valid:              $valid');
    print('Invalid:            $invalid');
    print('Duplicates (ID):    $duplicatesInBatch');
    print('Near-Duplicates:    $nearDuplicatesInBatch');
    print('Existing (DB):      $existingInFirestore');
    print('New to Create:      ${toCreate.length}');
    print('------------------------------------------------------------');

    if (execute) {
      if (toCreate.isEmpty) {
        print('ABORT: Nothing to import.');
        return;
      }

      print('Executing physical import...');
      int successCount = 0;
      int failureCount = 0;

      for (final q in toCreate) {
        try {
          // 1. Convert DTO to JSON map
          final dataMap = jsonDecode(jsonEncode(q.toJson())) as Map<String, dynamic>;
          
          // 2. Remove ID (it becomes the document ID)
          dataMap.remove('id');
          
          // 3. Physical write
          if (admin != null) {
            // Use Admin SDK (Bypasses rules)
            await admin.writeQuestion(q.id, dataMap);
          } else {
            // Use Firedart (Subject to rules)
            await Firestore.instance.collection('questions').document(q.id).set(dataMap);
          }
          
          successCount++;
          print('  [CREATED] ${q.id}');
        } catch (e) {
          failureCount++;
          print('  [FAILED]  ${q.id}: $e');
        }
      }

      print('============================================================');
      print('IMPORT COMPLETE');
      print('Succeeded: $successCount');
      print('Failed:    $failureCount');
      print('============================================================');
      
      if (failureCount > 0) {
        print('WARNING: Some imports failed. Check credentials/rules.');
      }
    } else {
      print('SUCCESS: Dry run finished without errors.');
      print('Use --execute flag to perform actual physical write.');
    }
  } catch (e) {
    print('CRITICAL PIPELINE FAILURE: $e');
  }
}
