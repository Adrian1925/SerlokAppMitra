import 'package:flutter/material.dart';
import 'package:serlok_mitra/core/constants/app_colors.dart';

enum SnackBarType { success, error }

void showDialogStyleSnackBar({
  required BuildContext context,
  required SnackBarType type,
  required String message,
  Duration duration = const Duration(seconds: 2),
}) {
  final Color backgroundColor = type == SnackBarType.success ? Colors.green : Colors.red;
  final IconData iconData = type == SnackBarType.success ? Icons.check : Icons.close;

  // OverlayEntry memungkinkan widget muncul di atas layout lain
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 40,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(iconData, color: AppColors.white, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  // Tampilkan overlay
  overlay.insert(overlayEntry);

  // Hapus setelah durasi selesai
  Future.delayed(duration, () {
    overlayEntry.remove();
  });
}
