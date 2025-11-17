import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class WalletBankSelectPage extends StatelessWidget {
  const WalletBankSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final banks = [
      {
        'logo': 'assets/images/bca.png',
        'name': 'Bank Central Asia',
        'account': '0812533556455',
      },
      {
        'logo': 'assets/images/mandiri.png',
        'name': 'Bank Mandiri',
        'account': '1235860145454854125',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pilih Bank Tujuan', style: AppTextStyles.semi18),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.3,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: banks.length,
        itemBuilder: (context, index) {
          final bank = banks[index];
          return Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/wallet-bank-transfer',
                    arguments: {
                      'logo': bank['logo'],
                      'name': bank['name'],
                      'account': bank['account'],
                    },
                  );
                },
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                leading: Image.asset(bank['logo']!, width: 50),
                title: Text(
                  bank['name']!,
                  style: AppTextStyles.semi15.copyWith(
                    color: AppColors.textProfileOption,
                  ),
                ),
                subtitle: Text(
                  bank['account']!,
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
              const Divider(
                height: 1,
                color: AppColors.dividerGray,
                thickness: 1,
              ),
            ],
          );
        },
      ),
    );
  }
}
