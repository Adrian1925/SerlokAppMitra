import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notification_service.dart';

class NotificationHandler {
  static void setupNotificationListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print("🔥🔥🔥 FCM MESSAGE RECEIVED (FOREGROUND) 🔥🔥🔥");

  print("📌 FULL MESSAGE: ${message.toMap()}");

  print("🔹 Message ID: ${message.messageId}");
  print("🔹 Sender ID: ${message.from}");
  print("🔹 Sent Time : ${message.sentTime}");

  print("🔔 Notification Title: ${message.notification?.title}");
  print("🔔 Notification Body : ${message.notification?.body}");
  print("🖼️ Image: ${message.notification?.android?.imageUrl}");

  print("🔊 Android Sound: ${message.notification?.android?.sound}");

  print("📦 DATA PAYLOAD => ${message.data}");
  message.data.forEach((key, value) {
    print("   🔸 $key : $value");
  });

  LocalNotificationService.showNotification(
    title: message.notification?.title ?? "",
    body: message.notification?.body ?? "",
    soundNameFromFCM: message.notification?.android?.sound ?? message.data['sound'],
  );
});


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📌 [OPENED FROM BACKGROUND]");
      print("➡️ Data: ${message.data}");
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print("📌 [OPENED FROM TERMINATED]");
        print("➡️ Data: ${message.data}");
      }
    });
  }
}
