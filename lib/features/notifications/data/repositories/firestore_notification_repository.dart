import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soteria/core/firebase/services/firebase_interfaces.dart';
import '../../domain/models/app_notification.dart';
import '../../domain/repositories/notification_repository.dart';

class FirestoreNotificationRepository implements NotificationRepository {
  final IDatabaseService _database;
  final IMessagingService _fcm;
  final String? _userId;

  FirestoreNotificationRepository({
    required this._database,
    required this._fcm,
    this._userId,
  });

  CollectionReference<Map<String, dynamic>> get _notificationsCollection =>
      _database.collection('users').doc(_userId).collection('notifications');

  @override
  Future<List<AppNotification>> getNotifications() async {
    if (_userId == null) return [];

    final snapshot = await _notificationsCollection
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();

    return snapshot.docs.map((doc) => _mapFromFirestore(doc)).toList();
  }

  @override
  Future<void> saveNotification(AppNotification notification) async {
    if (_userId == null) return;

    // Deduplication check
    final dedupeKey = notification.payload['deduplicationKey'];
    if (dedupeKey != null) {
      final exists = await _notificationsCollection
          .where('payload.deduplicationKey', isEqualTo: dedupeKey)
          .limit(1)
          .get();
      if (exists.docs.isNotEmpty) return;
    }

    await _notificationsCollection.doc(notification.id).set({
      ...notification.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> markAsRead(String id) async {
    if (_userId == null) return;
    await _notificationsCollection.doc(id).update({'read': true});
  }

  @override
  Future<void> deleteNotification(String id) async {
    if (_userId == null) return;
    await _notificationsCollection.doc(id).delete();
  }

  @override
  Future<void> clearAll() async {
    if (_userId == null) return;
    final snapshot = await _notificationsCollection.get();
    final batch = _database.instance.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  @override
  Future<String?> getFCMToken() => _fcm.getToken();

  @override
  Future<void> deleteFCMToken() => _fcm.instance.deleteToken();

  @override
  Stream<String> get onTokenRefresh => _fcm.instance.onTokenRefresh;

  AppNotification _mapFromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    final createdAt = data['createdAt'];
    
    DateTime dateTime;
    if (createdAt is Timestamp) {
      dateTime = createdAt.toDate();
    } else if (createdAt is String) {
      dateTime = DateTime.parse(createdAt);
    } else {
      dateTime = DateTime.now();
    }

    return AppNotification.fromJson({
      ...data,
      'id': doc.id,
      'createdAt': dateTime.toIso8601String(),
    });
  }
}
