
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class InfoBanner extends StatelessWidget {
  final String title, subtitle;
  final String? buttonLabel;
  final VoidCallback? onPressed;

  const InfoBanner({
    required this.title,
    required this.subtitle,
    this.buttonLabel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          if (buttonLabel != null && onPressed != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  buttonLabel!,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}