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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = BottomNavRouter.pages;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      // Floating button hanya aktif di HomePage
      floatingActionButton: FloatingButtonWidgets(
        onTab: () =>
            BottomNavRouter.goToHome(setState, (i) => _selectedIndex = i),
        selectedIndex: _selectedIndex == 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom navigation aktif hanya untuk index > 0
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex == 0 ? -1 : 0,
        onItemTapped: (index) => BottomNavRouter.onTabSelected(
            index + 1, setState, (i) => _selectedIndex = i),
      ),
    );
  }
}
