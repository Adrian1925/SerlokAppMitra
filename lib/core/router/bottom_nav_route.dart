import 'package:flutter/material.dart';
import 'package:serlok_mitra/presentation/page/home/home_page.dart';
import 'package:serlok_mitra/presentation/page/profile/profile_page.dart';
import '../../presentation/page/vhicle/vhicle_page.dart';

class BottomNavRouter {
  static List<Widget> pages = [
    const HomePage(),
    const VhiclePage(),
    // TODO: halaman Sewa Aktif, sementara saya isi homepage dulu (agar index profile sesuai)
    const HomePage(),
    // TODO: halaman Riwayat, sementara saya isi homepage dulu
    const HomePage(),
    const ProfilePage(),
  ];

  static void onTabSelected(
    int index,
    void Function(void Function()) setState,
    void Function(int) updateIndex,
  ) {
    setState(() => updateIndex(index));
  }

  static void goToHome(
    void Function(void Function()) setState,
    void Function(int) updateIndex,
  ) {
    setState(() => updateIndex(0));
  }
}
