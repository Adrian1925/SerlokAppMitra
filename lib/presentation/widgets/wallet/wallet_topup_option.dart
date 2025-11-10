import 'package:flutter/material.dart';
import 'package:serlok_mitra/core/constants/app_colors.dart';
import 'package:serlok_mitra/core/constants/app_text_styles.dart';

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
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.grey.withOpacity(0.25),
        child: Image.asset(
          iconPath,
          width: 26,
          height: 26,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        title,
        style: AppTextStyles.semi15.copyWith(
          color: AppColors.textProfileOption,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.regular12.copyWith(
          color: AppColors.textGrayScale70,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: AppColors.textGrayScale70,
      ),
    );
  }
}
