import 'package:firedart/firedart.dart';

void main() async {
  const projectId = 'soteriav2-b4042';
  Firestore.initialize(projectId);

  print('Verifying All Questions in Collection "questions"...');

  try {
    final snapshot = await Firestore.instance
        .collection('questions')
        .get();

    print('Total Questions Found: ${snapshot.length}');

    int published = 0;
    int approved = 0;

    for (final doc in snapshot) {
      final status = doc['status'];
      if (status == 'published') {
        published++;
        print('  [PUBLISHED] ${doc.id}');
      } else if (status == 'approved') {
        approved++;
      }
    }

    print('------------------------------------------------------------');
    print('Published: $published');
    print('Approved:  $approved');
    print('------------------------------------------------------------');
    
    if (published == 5 && approved == 45) {
      print('SUCCESS: Verified 5 published and 45 approved questions.');
    }
  } catch (e) {
    print('Error during verification: $e');
  }
}
