import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

Future<bool> showExitConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String cancelText,
  required String confirmText,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.background,
          title: Center(child: Text(title, style: AppTextStyles.bold24)),
          content: Text(content),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.white,
              ),
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                cancelText,
                style: AppTextStyles.semi12.copyWith(
                  color: AppColors.textProfileOption,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redAlert,
                foregroundColor: AppColors.white,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                confirmText,
                style: AppTextStyles.semi12.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
      ) ??
      false;
}
