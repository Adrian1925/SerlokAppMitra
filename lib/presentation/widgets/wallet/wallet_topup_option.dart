import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class WalletTopupOption extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const WalletTopupOption({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 6,
          ),
          leading: CircleAvatar(
            backgroundColor: AppColors.grey.withOpacity(0.2),
            radius: 22,
            child: Image.asset(iconPath, width: 26),
          ),
          title: Text(
            title,
            style: AppTextStyles.semi15.copyWith(
              color: AppColors.textProfileOption,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: AppTextStyles.regular13.copyWith(
              color: AppColors.textGrayScale70,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: AppColors.textGrayScale70,
          ),
        ),
        const Divider(height: 1, color: AppColors.dividerGray, thickness: 1),
      ],
    );
  }
}
