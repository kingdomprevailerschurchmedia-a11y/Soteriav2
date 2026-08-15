import 'dart:io';
import 'dart:convert';
import 'package:firedart/firedart.dart';
import 'package:soteria/features/question_content/data/models/question_dto.dart';
import 'package:soteria/features/question_content/data/mappers/question_mapper.dart';
import 'package:soteria/features/question_content/data/validators/question_validator.dart';
import 'package:soteria/features/question_content/domain/entities/question.dart';

// Standalone script for physical Firestore import.
// Usage: dart run bin/import_questions.dart [path_to_json] [--execute]

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: dart run bin/import_questions.dart <path_to_json> [--execute]');
    return;
  }

  final path = args[0];
  final execute = args.contains('--execute');
  const projectId = 'soteriav2-b4042';

  print('============================================================');
  print('SOTERIA — PRODUCTION QUESTION IMPORT');
  print('============================================================');
  print('Project ID:  $projectId');
  print('Collection:  questions');
  print('Target File: $path');
  print('Mode:        ${execute ? "EXECUTE (PHYSICAL WRITE)" : "DRY RUN"}');
  print('============================================================');

  try {
    // 1. Initialize Firestore
    Firestore.initialize(projectId);

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
        try {
          final doc = await Firestore.instance.collection('questions').document(dto.id).get();
          if (doc != null) {
            existingInFirestore++;
            // We do not overwrite existing questions
            continue;
          }
        } catch (e) {
          // If permission denied here, we'll likely fail on write too.
          // In some setups, read might be restricted while write is allowed for admins.
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
          await Firestore.instance.collection('questions').document(q.id).set(dataMap);
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
