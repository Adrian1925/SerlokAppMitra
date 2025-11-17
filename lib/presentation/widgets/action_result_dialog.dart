import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class ActionResultDialog extends StatelessWidget {
  final String message;
  final String buttonText;
  final bool isSuccess;
  final VoidCallback onButtonPressed;

  const ActionResultDialog({
    super.key,
    required this.message,
    required this.buttonText,
    required this.isSuccess,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSuccess
                    ? const Color(0xFF2AC267)
                    : const Color(0xFFFF6B6B),
              ),
              child: Icon(
                isSuccess ? Icons.check : Icons.close,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),

            // Pesan
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.semi16.copyWith(color: AppColors.secondary),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: 140,
              height: 44,
              child: ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.violet,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  buttonText,
                  style: AppTextStyles.semi16.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showActionResultDialog({
  required BuildContext context,
  required String message,
  required String buttonText,
  required bool isSuccess,
  required VoidCallback onAfterClose,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return ActionResultDialog(
        message: message,
        buttonText: buttonText,
        isSuccess: isSuccess,
        onButtonPressed: () {
          Navigator.of(dialogContext).pop();
          onAfterClose();
        },
      );
    },
  );
}
