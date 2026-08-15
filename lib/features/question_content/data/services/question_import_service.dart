import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/question_dto.dart';
import '../mappers/question_mapper.dart';
import '../validators/question_validator.dart';
import '../data_sources/firestore_data_source.dart';
import '../../domain/entities/question.dart';

class ImportResult {
  final int total;
  final int valid;
  final int invalid;
  final int duplicates;
  final List<String> errors;
  final List<QuestionDto> toCreate;

  ImportResult({
    required this.total,
    required this.valid,
    required this.invalid,
    required this.duplicates,
    required this.errors,
    required this.toCreate,
  });

  @override
  String toString() {
    return 'ImportResult(total: $total, valid: $valid, invalid: $invalid, duplicates: $duplicates, errors: ${errors.length})';
  }
}

class QuestionImportService {
  final FirestoreQuestionDataSource _dataSource;

  QuestionImportService(this._dataSource);

  Future<ImportResult> dryRun(String jsonContent) async {
    final List<dynamic> data = jsonDecode(jsonContent);
    final List<String> errors = [];
    final List<QuestionDto> toCreate = [];
    int valid = 0;
    int invalid = 0;
    int duplicates = 0;

    final Set<String> batchIds = {};

    for (var i = 0; i < data.length; i++) {
      try {
        final dto = QuestionDto.fromJson(data[i]);
        
        // 1. Internal duplicate check
        if (batchIds.contains(dto.id)) {
          duplicates++;
          errors.add('Row $i: Duplicate ID "${dto.id}" in batch.');
          continue;
        }
        batchIds.add(dto.id);

        // 2. Schema/Domain validation
        final entity = QuestionMapper.fromDto(dto);
        final validationErrors = QuestionValidator.validate(entity);
        
        if (validationErrors.isNotEmpty) {
          invalid++;
          errors.add('Row $i (${dto.id}): ${validationErrors.join(", ")}');
          continue;
        }

        // 3. Existing ID check in Firestore
        final existing = await _dataSource.fetchQuestionById(dto.id);
        if (existing != null) {
          duplicates++;
          errors.add('Row $i (${dto.id}): ID already exists in Firestore.');
          continue;
        }

        valid++;
        toCreate.add(dto);
      } catch (e) {
        invalid++;
        errors.add('Row $i: JSON Parsing error: $e');
      }
    }

    return ImportResult(
      total: data.length,
      valid: valid,
      invalid: invalid,
      duplicates: duplicates,
      errors: errors,
      toCreate: toCreate,
    );
  }

  Future<void> executeImport(List<QuestionDto> questions) async {
    await _dataSource.saveQuestionsBatch(questions);
  }
}
