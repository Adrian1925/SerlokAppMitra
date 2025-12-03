import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notification_service.dart';

class NotificationHandler {
  static void setupNotificationListener() {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        LocalNotificationService.showNotification(
          title: message.notification!.title ?? "",
          body: message.notification!.body ?? "",
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Notifikasi dibuka: ${message.data}");
    });
  }
}
