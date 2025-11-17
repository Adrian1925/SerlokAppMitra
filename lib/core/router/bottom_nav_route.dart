import 'package:flutter/material.dart';
import 'package:serlok_mitra/presentation/page/home/home_page.dart';
import 'package:serlok_mitra/presentation/page/profile/profile_Page.dart';
import 'package:serlok_mitra/presentation/page/riwayat/riwayat_page.dart';
import '../../presentation/page/sewa_aktif/sewa_aktif_page.dart';
import '../../presentation/page/vhicle/vhicle_page.dart';

class BottomNavRouter {
  static List<Widget> pages = [
    HomePage(), 
    VhiclePage(),
    SewaActivePage(),
    RiwayatPage(),
    ProfilePage()
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
