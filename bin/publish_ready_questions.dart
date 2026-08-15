import 'package:firedart/firedart.dart';

void main(List<String> args) async {
  const projectId = 'soteriav2-b4042';
  Firestore.initialize(projectId);

  final execute = args.contains('--execute');

  print('============================================================');
  print('SOTERIA — PRODUCTION QUESTION PUBLICATION');
  print('============================================================');
  print('Mode: ${execute ? "EXECUTE (PHYSICAL WRITE)" : "DRY RUN"}');

  try {
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

    if (readyIds.length != 40) {
      print('STOP: Discrepancy detected. Expected 40 READY questions, found ${readyIds.length}.');
      return;
    }

    if (execute) {
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
          print('  [FAILED] $id: $e');
        }
      }
      print('------------------------------------------------------------');
      print('Publication Complete. Succeeded: $successCount');
    } else {
      print('------------------------------------------------------------');
      print('Dry run successful. Use --execute to publish 40 questions.');
    }
  } catch (e) {
    print('CRITICAL ERROR: $e');
  }
}
