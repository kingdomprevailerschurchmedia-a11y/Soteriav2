import 'package:firedart/firedart.dart';

void main() async {
  const projectId = 'soteriav2-b4042';
  Firestore.initialize(projectId);

  final testIds = [
    'prod_gk_001',
    'prod_gk_002',
    'prod_gk_003',
    'prod_gk_004',
    'prod_gk_005',
  ];

  print('Publishing 5 questions for testing...');

  for (final id in testIds) {
    try {
      await Firestore.instance.collection('questions').document(id).update({
        'status': 'published',
        'updatedAt': DateTime.now().toIso8601String(),
      });
      print('  [PUBLISHED] $id');
    } catch (e) {
      print('  [FAILED] $id: $e');
    }
  }

  print('Done.');
}
