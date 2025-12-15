import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../firebase_options.dart';

class FCMService {
  @pragma('vm:entry-point')
  static Future<void> backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print("📩 [BG] Message ID: ${message.messageId}");
    print("🕒 [BG] Sent Time: ${message.sentTime}");
    print("📤 [BG] From: ${message.from}");
    print("📦 [BG] Data Payload: ${message.data}");

    if (message.notification != null) {
      print("🔔 [BG] Notification Title: ${message.notification?.title}");
      print("📝 [BG] Notification Body: ${message.notification?.body}");
      if (message.notification?.android != null) {
        print("🤖 [BG] Android Channel ID: ${message.notification?.android?.channelId}");
      }
      if (message.notification?.apple != null) {
        print("🍎 [BG] iOS badge: ${message.notification?.apple?.badge}");
      }
    }
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

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 [FG] Message ID: ${message.messageId}");
      print("🕒 Sent Time: ${message.sentTime}");
      print("📤 From: ${message.from}");
      print("📦 [FG] Data Payload: ${message.data}");

      if (message.notification != null) {
        print("🔔 [FG] Notification Title: ${message.notification?.title}");
        print("📝 [FG] Notification Body: ${message.notification?.body}");
        if (message.notification?.android != null) {
          print("🤖 [FG] Android Channel ID: ${message.notification?.android?.channelId}");
        }
        if (message.notification?.apple != null) {
          print("🍎 [FG] iOS badge: ${message.notification?.apple?.badge}");
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📲 [OPENED APP] Message ID: ${message.messageId}");
      print("📦 Payload: ${message.data}");
      if (message.notification != null) {
        print("🔔 Notification Title: ${message.notification?.title}");
        print("📝 Notification Body: ${message.notification?.body}");
      }
    });
  }
}
