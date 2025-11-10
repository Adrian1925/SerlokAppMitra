import 'package:flutter/material.dart';
import 'package:serlok_mitra/presentation/page/home/home_page.dart';
import '../../presentation/page/vhicle/vhicle_page.dart';

class BottomNavRouter {
  static List<Widget> pages = [
    HomePage(),
    VhiclePage(),
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
