import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  Future<bool> requestPhonePermission() async {
    final status = await Permission.phone.request();
    if (status.isGranted) {
      print("Permission PHONE diberikan");
      return true;
    } else {
      print("Permission PHONE tidak diberikan: $status");
      return false;
    }
  }

  Future<void> ensureLocationPermission() async {
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

    print("Permission lokasi: $permission");
  }
}