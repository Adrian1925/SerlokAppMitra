import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../firebase_options.dart';

class FCMService {
  static Future<void> backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print("📩 [BG] Message ID: ${message.messageId}");
    print("📦 [BG] Data: ${message.data}");
  }

  static Future<void> initFCM() async {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print("⚙️ Permission: ${settings.authorizationStatus}");

    final token = await FirebaseMessaging.instance.getToken();
    print("🎯 FCM TOKEN: $token");
  }
}
