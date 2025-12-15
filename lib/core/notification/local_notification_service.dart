import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initLocalNotification() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(android: android);

    await plugin.initialize(initSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'Channel for important notifications',
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('incoming_sound'),
    );

    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static String normalizeSoundName(String raw) {
    return raw
        .toLowerCase()
        .replaceAll(".mp3", "")
        .replaceAll(".wav", "")
        .replaceAll(".ogg", "")
        .trim();
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    String? soundNameFromFCM,
  }) async {
    final normalized = normalizeSoundName(soundNameFromFCM ?? "");

    const soundMap = {
      "incoming_sound": "incoming_sound",
    };

    final selectedSound = soundMap[normalized];

    final androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'Channel for important notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: selectedSound != null
          ? RawResourceAndroidNotificationSound(selectedSound)
          : null, 
    );

    final platformDetails = NotificationDetails(android: androidDetails);

    await plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      platformDetails,
    );
  }
}
