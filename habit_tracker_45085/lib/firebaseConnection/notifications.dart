import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.

    print("Handling a background message: ${message.messageId}");
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token: $fCMToken");
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}
