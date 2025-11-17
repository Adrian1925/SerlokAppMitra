import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:serlok_mitra/core/utility/rupiah_formatter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../widgets/wallet/wallet_topup_info_card.dart';
import '../../widgets/primary_button.dart';

class WalletBankTransferPage extends StatefulWidget {
  const WalletBankTransferPage({super.key});

  @override
  State<WalletBankTransferPage> createState() => _WalletBankTransferPageState();
}

class _WalletBankTransferPageState extends State<WalletBankTransferPage> {
  final TextEditingController _controller = TextEditingController();
  bool get _isValid =>
      int.tryParse(_controller.text.replaceAll('.', '')) != null &&
      int.parse(_controller.text.replaceAll('.', '')) >= 10000;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    assert(
      args != null && args is Map<String, dynamic>,
      'Bank data must be provided!',
    );

    final bankArgs = args as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Bank Transfer', style: AppTextStyles.semi18),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.3,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WalletTopupInfoCard(
              iconPath: 'assets/icons/bank.png',
              title: 'Bank Transfer',
              subtitle: 'Tanpa biaya admin, proses sekitar 30–60 menit',
            ),
            const Divider(
              height: 1,
              color: AppColors.dividerGray,
              thickness: 1,
            ),
            const SizedBox(height: 28),
            Text('Ketikkan nominal topup', style: AppTextStyles.semi14),
            const SizedBox(height: 8),

            // Input nominal
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RupiahInputFormatter(),
              ],
              decoration: InputDecoration(
                hintText: 'Belum ditentukan',
                hintStyle: AppTextStyles.regular12.copyWith(
                  color: AppColors.textGrayScale70,
                ),
                filled: true,
                fillColor: AppColors.white,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    color: AppColors.dividerGray,
                    width: 1,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    color: AppColors.dividerGray,
                    width: 1,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              style: AppTextStyles.regular12.copyWith(
                color: _controller.text.isEmpty
                    ? AppColors.textGrayScale70
                    : Colors.black,
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 10),

            // info minimal saldo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.greyBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Minimal isi saldo Rp 10.000',
                style: AppTextStyles.regular13.copyWith(
                  color: AppColors.textGrayScale70,
                ),
              ),
            ),
            const SizedBox(height: 36),

            // tombol next
            PrimaryButton(
              text: 'Selanjutnya',
              enabled: _isValid,
              onPressed: _isValid
                  ? () {
                      FocusScope.of(context).unfocus();

                      final raw = _controller.text.replaceAll('.', '');
                      final amount = int.tryParse(raw) ?? 0;

                      Navigator.pushNamed(
                        context,
                        '/wallet-bank-confirm',
                        arguments: {...bankArgs, 'amount': amount},
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
