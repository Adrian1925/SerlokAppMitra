import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_device_imei/flutter_device_imei.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceHelper {
  String imei1 = "";
  String imei2 = "";
  String deviceId = "";
  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  }

  Future<void> initIMEI() async {
    final status = await Permission.phone.request();
    if (!status.isGranted) {
      print("Permission PHONE untuk IMEI tidak diberikan: $status");
      return;
    }

    try {
      imei1 = await FlutterDeviceImei.instance.getIMEI() ?? "";
      imei2 = await FlutterDeviceImei.instance.getIMEI() ?? "";
      deviceId = await getDeviceId();
      print("IMEI1: $imei1, IMEI2: $imei2, DeviceId: $deviceId");
    } catch (e) {
      print("Error mengambil IMEI / DeviceId: $e");
    }
  }

  Future<Map<String, dynamic>> getDeviceData() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw "Location service tidak aktif";
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw "Izin lokasi ditolak";
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw "Izin lokasi ditolak permanen";
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final firebaseToken = await FirebaseMessaging.instance.getToken();

    return {
      "latitude": position.latitude,
      "longitude": position.longitude,
      "firebase_token": firebaseToken ?? "",
      "imei1": imei1,
      "imei2": imei2,
      "deviceId": deviceId,
    };
  }
}
