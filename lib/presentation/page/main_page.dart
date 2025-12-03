import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../core/router/bottom_nav_route.dart';
import '../widgets/bottom_navbar_widgets.dart';
import '../widgets/floating_button_widgets.dart';

class MainTabPage extends StatefulWidget {
  final int initialIndex;
  const MainTabPage({super.key, this.initialIndex = 0});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final pages = BottomNavRouter.pages;

    /// CustomBottomNav index: -1 = none, 0 = vehicle, 1 = sewa, 2 = riwayat, 3 = profile
    final int navIndex = _selectedIndex > 0 ? _selectedIndex - 1 : -1;

    return Scaffold(
      backgroundColor: AppColors.background,
      
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),

      floatingActionButton: FloatingButtonWidgets(
        onTab: () {
          setState(() {
            _selectedIndex = 0;
          });
        },
        selectedIndex: _selectedIndex == 0,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: CustomBottomNav(
        selectedIndex: navIndex,
        onItemTapped: (navTappedIndex) {
          /// navTappedIndex: 0 = vehicle, 1 = sewa, 2 = riwayat, 3 = profile
          setState(() {
            _selectedIndex = navTappedIndex + 1;
          });
        },
      ),
    );
  }
}
