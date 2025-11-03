import 'package:flutter/material.dart';
import 'package:serlok_mitra/presentation/page/home/home_page.dart';


class BottomNavRouter {
  static List<Widget> pages = [
    //tambahkan page baru nanti disini
    HomePage()
  ];

  static void onTabSelected(
    int index,
    void Function(void Function()) setState,
    void Function(int) updateIndex,
  ) {
    setState(() => updateIndex(index + 1));
  }

  static void goToHome(
    void Function(void Function()) setState,
    void Function(int) updateIndex,
  ) {
    setState(() => updateIndex(0));
  }
}
