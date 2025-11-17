import 'package:flutter/material.dart';
import 'package:serlok_mitra/core/constants/app_colors.dart';
import 'package:serlok_mitra/core/constants/app_text_styles.dart';
import 'package:serlok_mitra/core/utility/rupiah_formatter.dart';

class WalletBalanceHeader extends StatelessWidget {
  final int balance;
  final String lastUpdatedText;
  final VoidCallback? onBackPressed;

  const WalletBalanceHeader({
    super.key,
    required this.balance,
    required this.lastUpdatedText,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.violet,
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header/appbar
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: AppColors.white,
                    size: 24,
                  ),
                  onPressed: onBackPressed,
                ),
              ),
              const Center(
                child: Text(
                  'Dompet Saya',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saldo Saya',
                  style: AppTextStyles.semi14.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp ${formatRupiah(balance)}',
                  style: AppTextStyles.bold30.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  lastUpdatedText,
                  style: AppTextStyles.regular13.copyWith(
                    color: AppColors.white.withOpacity(0.7),
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
