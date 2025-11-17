import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../core/router/bottom_nav_route.dart';
import '../widgets/bottom_navbar_widgets.dart';
import '../widgets/floating_button_widgets.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  int _selectedIndex = 0; // 0 = Home, 1 = Vhicle, 2 = SewaActive, 3 = Riwayat, 4 = Profile

  @override
  Widget build(BuildContext context) {
    final pages = BottomNavRouter.pages;

    // Nav index untuk BottomNav (BottomNav hanya punya 4 item -> mapping ke pages[1..4])
    final int navIndex = _selectedIndex > 0 ? _selectedIndex - 1 : -1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      floatingActionButton: FloatingButtonWidgets(
        onTab: () => BottomNavRouter.goToHome(setState, (i) => _selectedIndex = i),
        selectedIndex: _selectedIndex == 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: CustomBottomNav(
        // kirimkan navIndex (0..3) atau -1 jika home
        selectedIndex: navIndex,
        onItemTapped: (navTappedIndex) {
          // navTappedIndex adalah 0..3, convert ke page index (1..4)
          BottomNavRouter.onTabSelected(
            navTappedIndex + 1,
            setState,
            (i) => _selectedIndex = i,
          );
        },
      ),
    );
  }
}