import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:dash_bubble/dash_bubble.dart';
import 'package:flutter/services.dart';

const platform = MethodChannel('serlok/open_app');

class AppLifecycleBubble with WidgetsBindingObserver {

  static final AppLifecycleBubble instance = AppLifecycleBubble._();
  AppLifecycleBubble._();

  bool isBubbleActive = false;
  Timer? _closeTimer;

  void start() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!Platform.isAndroid) return;

    switch (state) {

      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:

        _closeTimer?.cancel();

        _closeTimer = Timer(const Duration(seconds: 1), () async {

          if (!isBubbleActive) {
            final permitted = await DashBubble.instance.hasOverlayPermission();
            if (permitted) {
              isBubbleActive = true;
              await DashBubble.instance.startBubble(
                bubbleOptions: BubbleOptions(
                  bubbleIcon: "icon",
                  enableClose: false, 
                ),
                notificationOptions: NotificationOptions(
                  title: "Serlok Mitra",
                  body: "Klik untuk membuka kembali",
                ),
                onTap: () async {
                  await platform.invokeMethod("openApp");
                },
              );
            }
          }
        });

        break;

      case AppLifecycleState.resumed:
        _closeTimer?.cancel();

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
