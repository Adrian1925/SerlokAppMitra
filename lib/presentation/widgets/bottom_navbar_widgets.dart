import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/responsive.dart';

class SmoothHillNotchedShape extends NotchedShape {
  final double height;
  final double width;
  final double smoothness;

  const SmoothHillNotchedShape({
    this.height = 28.0,
    this.width = 120.0,
    this.smoothness = 50.0,
  });

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    final top = host.top;
    final center = guest?.center.dx ?? host.center.dx;
    final left = center - width / 2;
    final right = center + width / 2;
    final radius = 20.0;

    return Path()
      ..moveTo(host.left, host.bottom)
      ..lineTo(host.left, top + radius)
      ..quadraticBezierTo(host.left, top, host.left + radius, top)
      ..lineTo(left, top)
      ..cubicTo(
        left + smoothness / 2,
        top,
        center - smoothness / 2,
        top - height,
        center,
        top - height,
      )
      ..cubicTo(
        center + smoothness / 2,
        top - height,
        right - smoothness / 2,
        top,
        right,
        top,
      )
      ..lineTo(host.right - radius, top)
      ..quadraticBezierTo(host.right, top, host.right, top + radius)
      ..lineTo(host.right, host.bottom)
      ..close();
  }
}

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    print('Selected Index in BottomNav: $selectedIndex');
    final bw = baseWidth;
    final bh = baseHeight;

    return BottomAppBar(
      color: const Color(0xFF1A1536),
      elevation: 8,
      shape: SmoothHillNotchedShape(
        height: 24 * bh / 812,
        width: 156 * bw / 375,
        smoothness: 60 * bw / 375,
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 78 * bh / 812,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4 * bw / 375),
          child: Row(
            children: [
              _NavItem(
                icon: FontAwesomeIcons.carSide,
                label: 'Kendaraan',
                index: 0,
                selectedIndex: selectedIndex,
                onTap: onItemTapped,
              ),
              SizedBox(width: 8 * bw / 375),
              _NavItem(
                icon: FontAwesomeIcons.road,
                label: 'Sewa Aktif',
                index: 0,
                selectedIndex: selectedIndex,
                onTap: onItemTapped,
              ),
              SizedBox(width: 65 * bw / 375),
              _NavItem(
                icon: Icons.list_alt_outlined,
                label: 'Riwayat',
                index: 1,
                selectedIndex: selectedIndex,
                onTap: onItemTapped,
              ),
              SizedBox(width: 18 * bw / 375),
              _NavItem(
                icon: selectedIndex == 2 ? Icons.person : Icons.person_outline,
                label: 'Profil',
                index: 2,
                selectedIndex: selectedIndex,
                onTap: onItemTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bw = baseWidth;
    final bh = baseHeight;
    final isSelected = selectedIndex == index;
    final color = isSelected ? AppColors.primary : Colors.white;

    return InkWell(
      onTap: () => onTap(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 0.85 * (78 * bh / 812)),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 6 * bw / 375,
              vertical: 4 * bh / 812,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(icon, size: 22 * bw / 375, color: color),
                    if (label == 'Sewa Aktif')
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 3 * bh / 812),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}