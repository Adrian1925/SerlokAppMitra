import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:dash_bubble/dash_bubble.dart';
import 'package:flutter/services.dart';

const platform = MethodChannel('serlok/open_app');

class AppLifecycleBubble with WidgetsBindingObserver {

  static final AppLifecycleBubble instance = AppLifecycleBubble._();
  AppLifecycleBubble._();

  bool isBubbleActive = false;

  void start() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!Platform.isAndroid) return;

    switch (state) {

      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:

        if (!isBubbleActive) {
          final permitted = await DashBubble.instance.hasOverlayPermission();
          if (permitted) {
            isBubbleActive = true;
            await DashBubble.instance.startBubble(
              bubbleOptions: BubbleOptions(
                bubbleIcon: "icon",
                enableClose: true,
              ),
              notificationOptions: NotificationOptions(
                title: "Serlok Mitra",
                body: "Bubble aktif",
              ),
              onTap: () async {
                await platform.invokeMethod("openApp");
              },
            );
          }
        }
        break;

      case AppLifecycleState.resumed:
        if (isBubbleActive) {
          isBubbleActive = false;
          await DashBubble.instance.stopBubble();
        }
        break;

      default:
        break;
    }
  }
}
