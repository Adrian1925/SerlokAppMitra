
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class FloatingButtonWidgets extends StatelessWidget {
  final VoidCallback? onTab;
  final bool selectedIndex;
  const FloatingButtonWidgets({super.key, this.onTab, this.selectedIndex = false});

  @override
 Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 18),
      child: FloatingActionButton(
        backgroundColor: selectedIndex ? AppColors.primary : Colors.white,
        shape: const CircleBorder(),
        elevation: 12,
        onPressed: onTab,
        child: Image.asset(
          'assets/images/icon.png',
          width: 26,
          height: 26,
          color: selectedIndex ? Colors.white : AppColors.primary,
          colorBlendMode: BlendMode.srcIn,
        )
      ),
    );
  }
}