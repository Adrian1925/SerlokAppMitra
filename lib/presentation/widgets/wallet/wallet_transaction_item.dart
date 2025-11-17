import 'package:flutter/material.dart';
import 'package:serlok_mitra/core/constants/app_colors.dart';
import 'package:serlok_mitra/core/constants/app_text_styles.dart';
import 'package:serlok_mitra/core/utility/rupiah_formatter.dart';

class WalletTransactionItem extends StatelessWidget {
  final String title;
  final String dateTimeText;
  final int amount;
  final bool isIncoming;

  const WalletTransactionItem({
    super.key,
    required this.title,
    required this.dateTimeText,
    required this.amount,
    this.isIncoming = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool positive = isIncoming || amount > 0;
    final Color accentColor = positive ? Colors.blue : AppColors.strongRed;
    final IconData iconData = positive
        ? Icons.arrow_upward
        : Icons.arrow_downward;
    final String sign = positive ? '+' : '-';
    final int displayAmount = amount.abs();

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 4,
          ),
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: accentColor.withOpacity(0.12),
            child: Icon(iconData, color: accentColor, size: 18),
          ),
          title: Text(
            title,
            style: AppTextStyles.regular14.copyWith(
              color: AppColors.textProfileOption,
            ),
          ),
          subtitle: Text(
            dateTimeText,
            style: AppTextStyles.regular13.copyWith(
              color: AppColors.textHistoryLocation,
            ),
          ),
          trailing: Text(
            '$sign${formatRupiah(displayAmount)}',
            style: AppTextStyles.semi14.copyWith(color: accentColor),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: const Divider(
            height: 1,
            color: AppColors.dividerGray,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
