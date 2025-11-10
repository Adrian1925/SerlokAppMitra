import 'package:flutter/material.dart';
import 'package:serlok_mitra/core/constants/app_colors.dart';
import 'package:serlok_mitra/core/constants/app_text_styles.dart';

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

  String _formatRupiah(int value) {
    final str = value.abs().toString();
    final buffer = StringBuffer();
    int count = 0;

    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count == 3 && i != 0) {
        buffer.write('.');
        count = 0;
      }
    }
    return buffer.toString().split('').reversed.join('');
  }

  @override
  Widget build(BuildContext context) {
    final bool positive = isIncoming || amount > 0;
    final Color accentColor = positive ? Colors.blue : AppColors.strongRed;
    final IconData iconData = positive
        ? Icons.arrow_upward
        : Icons.arrow_downward;
    final String sign = positive ? '+' : '-';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: accentColor.withOpacity(0.12),
        child: Icon(iconData, color: accentColor, size: 18),
      ),
      title: Text(
        title,
        style: AppTextStyles.regular12.copyWith(
          color: AppColors.textProfileOption,
        ),
      ),
      subtitle: Text(
        dateTimeText,
        style: AppTextStyles.regular11.copyWith(
          color: AppColors.textHistoryLocation,
        ),
      ),
      trailing: Text(
        '$sign${_formatRupiah(amount)}',
        style: AppTextStyles.semi12.copyWith(color: accentColor),
      ),
    );
  }
}
