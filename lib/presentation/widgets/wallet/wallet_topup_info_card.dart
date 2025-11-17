import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class WalletTopupInfoCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;

  const WalletTopupInfoCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.grey.withOpacity(0.25),
            radius: 22,
            child: Image.asset(iconPath, width: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.semi15),
                Text(
                  subtitle,
                  style: AppTextStyles.regular13.copyWith(
                    color: AppColors.textGrayScale70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
