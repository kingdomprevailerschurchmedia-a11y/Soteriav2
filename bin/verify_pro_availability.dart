import 'package:firedart/firedart.dart';

void main() async {
  const projectId = 'soteriav2-b4042';
  Firestore.initialize(projectId);

  print('============================================================');
  print('SOTERIA — PRO MODE CONTENT AVAILABILITY VERIFICATION');
  print('============================================================');

  final snapshot = await Firestore.instance
      .collection('questions')
      .get();

  final questions = snapshot.where((doc) => doc['status'] == 'published').toList();
  print('Total Published: ${questions.length}');

  void check(String label, String? categoryId, String difficulty, int required) {
    var filtered = questions.where((q) => q['difficulty'] == difficulty);
    if (categoryId != null) {
      filtered = filtered.where((q) => q['categoryId'] == categoryId);
    }
    
    final count = filtered.length;
    final status = count >= required ? 'PASS' : 'INSUFFICIENT';
    print('  [$status] $label: $count / $required');
  }

  print('Checking configurations (Required: 10):');
  check('Any Category + Easy', null, 'easy', 10);
  check('Any Category + Medium', null, 'medium', 10);
  check('Any Category + Hard', null, 'hard', 10);
  check('Math + Easy', 'mathematics', 'easy', 10);
  check('Science + Easy', 'science', 'easy', 10);
  check('General Knowledge + Easy', 'general_knowledge', 'easy', 10);

  print('============================================================');
}
