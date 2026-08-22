import 'dart:io';
import 'dart:convert';
import 'package:googleapis/firestore/v1.dart';
import 'package:googleapis_auth/auth_io.dart';

class FirebaseAdminInterop {
  static const String _expectedProjectId = 'soteriav2-b4042';
  
  final FirestoreApi api;
  final String projectId;
  final String serviceAccountEmail;

  FirebaseAdminInterop({
    required this.api,
    required this.projectId,
    required this.serviceAccountEmail,
  });

  static Future<FirebaseAdminInterop?> initialize() async {
    final credPath = Platform.environment['GOOGLE_APPLICATION_CREDENTIALS'];
    
    if (credPath == null || credPath.isEmpty) {
      return null;
    }

    final file = File(credPath);
    if (!file.existsSync()) {
      throw Exception('Service account file not found at: $credPath');
    }

    final jsonContent = await file.readAsString();
    final Map<String, dynamic> credentials = jsonDecode(jsonContent);
    
    final email = credentials['client_email'] as String?;
    final pId = credentials['project_id'] as String?;

    if (pId != _expectedProjectId) {
      throw Exception('Project ID mismatch. Expected $_expectedProjectId, found $pId');
    }

    if (email == null) {
      throw Exception('Invalid service account JSON: missing client_email');
    }

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(jsonContent),
      [FirestoreApi.datastoreScope],
    );

    return FirebaseAdminInterop(
      api: FirestoreApi(client),
      projectId: pId!,
      serviceAccountEmail: email,
    );
  }

  /// Performs a lightweight read check to verify IAM permissions.
  /// Does not modify any data.
  Future<void> verifyConnectivity() async {
    try {
      final parent = 'projects/$projectId/databases/(default)/documents';
      // Just try to list a tiny bit of the collection to see if we have access.
      await api.projects.databases.documents.list(parent, 'questions', pageSize: 1);
    } catch (e) {
      throw Exception('Firestore Admin Connectivity Check Failed: $e');
    }
  }

  /// Securely writes a document to Firestore, bypassing security rules.
  Future<void> writeQuestion(String id, Map<String, dynamic> data) async {
    final parent = 'projects/$projectId/databases/(default)/documents';
    final collection = 'questions';
    
    final document = Document()
      ..fields = _convertToValueMap(data);

    await api.projects.databases.documents.patch(
      document,
      '$parent/$collection/$id',
      updateMask_fieldPaths: data.keys.toList(),
    );
  }

  /// Helper to convert a plain Dart map to Firestore Value map.
  Map<String, Value> _convertToValueMap(Map<String, dynamic> data) {
    return data.map((key, value) => MapEntry(key, _toValue(value)));
  }

  Value _toValue(dynamic value) {
    if (value == null) return Value()..nullValue = 'NULL_VALUE';
    if (value is String) return Value()..stringValue = value;
    if (value is bool) return Value()..booleanValue = value;
    if (value is int) return Value()..integerValue = value.toString();
    if (value is double) return Value()..doubleValue = value;
    if (value is List) {
      return Value()
        ..arrayValue = (ArrayValue()..values = value.map((e) => _toValue(e)).toList());
    }
    if (value is Map) {
      return Value()
        ..mapValue = (MapValue()..fields = _convertToValueMap(value.cast<String, dynamic>()));
    }
    // Default to string representation for complex types like DateTime if not handled
    return Value()..stringValue = value.toString();
  }
}
