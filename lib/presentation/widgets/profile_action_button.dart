import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class ProfileActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Size? size;
  final Color? backgroundColor;
  final Widget text;

  const ProfileActionButton({
    super.key,
    this.onPressed,
    this.size,
    this.backgroundColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: size ?? Size(double.infinity, 56),
        backgroundColor: backgroundColor ?? AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: text,
    );
  }
}
