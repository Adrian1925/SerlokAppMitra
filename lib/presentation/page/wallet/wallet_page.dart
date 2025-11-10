import 'package:flutter/material.dart';
import 'package:serlok_mitra/presentation/widgets/wallet/wallet_balance_header.dart';
import 'package:serlok_mitra/presentation/widgets/wallet/wallet_topup_option.dart';
import 'package:serlok_mitra/presentation/widgets/wallet/wallet_transaction_item.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WalletBalanceHeader(
                balance: 1000000,
                lastUpdatedText: 'Last updated 2 mins ago.',
                onBackPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 24),

              // isi saldo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Isi Saldo',
                  style: AppTextStyles.semi14.copyWith(
                    color: AppColors.textProfileOption,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              const WalletTopupOption(
                iconPath: 'assets/icons/bank.png',
                title: 'Bank Transfer',
                subtitle: 'Tanpa biaya admin, proses sekitar 30–60 menit',
              ),
              const WalletTopupOption(
                iconPath: 'assets/icons/virtualacc.png',
                title: 'Virtual Account / QRIS',
                subtitle: 'Proses instant. Biaya admin Rp 2500',
              ),
              const WalletTopupOption(
                iconPath: 'assets/icons/hubungics.png',
                title: 'Hubungi Customer Service',
                subtitle: 'Estimasi response rata-rata 3 menit',
              ),

              const SizedBox(height: 24),

              // history terakhir
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Transaksi Terakhir',
                  style: AppTextStyles.semi14.copyWith(
                    color: AppColors.textProfileOption,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              const WalletTransactionItem(
                title: 'Add Money - Bank Card',
                dateTimeText: '17 Oktober 2025, 08:32',
                amount: 2000000,
                isIncoming: true,
              ),
              const WalletTransactionItem(
                title: 'Komisi transaksi #123121',
                dateTimeText: '20 Oktober 2025, 15:48',
                amount: -100000,
              ),
              const WalletTransactionItem(
                title: 'Komisi transaksi #123122',
                dateTimeText: '21 Oktober 2025, 15:48',
                amount: -600000,
              ),
              const WalletTransactionItem(
                title: 'Komisi transaksi #123123',
                dateTimeText: '22 Oktober 2025, 15:48',
                amount: -300000,
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
