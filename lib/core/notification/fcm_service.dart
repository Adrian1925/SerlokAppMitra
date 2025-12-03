import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  static Future<void> backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Background message: ${message.messageId}");
  }

  static Future<void> initFCM() async {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print("Permission: ${settings.authorizationStatus}");

    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM TOKEN: $fcmToken");
  }
}
