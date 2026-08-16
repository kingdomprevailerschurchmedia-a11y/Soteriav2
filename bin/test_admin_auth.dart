import 'dart:io';
import 'package:soteria/core/network/firebase_admin_interop.dart';

/// Simple utility to verify that the Service Account is correctly configured.
/// Usage:
/// $env:GOOGLE_APPLICATION_CREDENTIALS="path/to/service-account.json"
/// dart run bin/test_admin_auth.dart

void main() async {
  print('============================================================');
  print('SOTERIA — ADMIN AUTH VERIFICATION');
  print('============================================================');

  final credPath = Platform.environment['GOOGLE_APPLICATION_CREDENTIALS'];
  if (credPath == null || credPath.isEmpty) {
    print('ERROR: GOOGLE_APPLICATION_CREDENTIALS environment variable is not set.');
    print('Please set it to the path of your service account JSON file.');
    exit(1);
  }

  print('Credential Path: $credPath');

  try {
    final admin = await FirebaseAdminInterop.initialize();
    
    if (admin == null) {
      print('ERROR: Failed to initialize Admin Interop.');
      exit(1);
    }

    print('Project ID:      ${admin.projectId}');
    print('Service Account: ${admin.serviceAccountEmail}');
    print('------------------------------------------------------------');
    print('Verifying Firestore connectivity and permissions...');

    await admin.verifyConnectivity();

    print('SUCCESS: Admin connectivity verified.');
    print('The service account has permission to read the "questions" collection.');
    print('It will be able to bypass security rules during import.');
    print('============================================================');
  } catch (e) {
    print('------------------------------------------------------------');
    print('CRITICAL FAILURE:');
    print(e);
    print('------------------------------------------------------------');
    print('Checklist:');
    print('1. Does the file exist at the path above?');
    print('2. Is the Project ID "soteriav2-b4042"?');
    print('3. Does the service account have "Cloud Firestore Editor" or "Owner" role?');
    print('============================================================');
    exit(1);
  }
}
