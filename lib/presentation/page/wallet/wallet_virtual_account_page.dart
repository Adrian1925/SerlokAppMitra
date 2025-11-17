import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:serlok_mitra/core/utility/rupiah_formatter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../widgets/wallet/wallet_topup_info_card.dart';
import '../../widgets/primary_button.dart';

class WalletVirtualAccountPage extends StatefulWidget {
  const WalletVirtualAccountPage({super.key});

  @override
  State<WalletVirtualAccountPage> createState() =>
      _WalletVirtualAccountPageState();
}

class _WalletVirtualAccountPageState extends State<WalletVirtualAccountPage> {
  final TextEditingController _controller = TextEditingController();

  bool get _isValid =>
      int.tryParse(_controller.text.replaceAll('.', '')) != null &&
      int.parse(_controller.text.replaceAll('.', '')) >= 10000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Virtual Account', style: AppTextStyles.semi18),
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
              iconPath: 'assets/icons/virtualacc.png',
              title: 'Virtual Account / QRIS',
              subtitle: 'Proses instant. Biaya admin Rp 2500',
            ),
            const Divider(
              height: 1,
              color: AppColors.dividerGray,
              thickness: 1,
            ),
            const SizedBox(height: 28),

            Text('Ketikkan nominal topup', style: AppTextStyles.semi14),
            const SizedBox(height: 8),

            // input nominal
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

            PrimaryButton(
              text: 'Selanjutnya',
              enabled: _isValid,
              onPressed: _isValid
                  ? () {
                      FocusScope.of(context).unfocus();

                      final raw = _controller.text.replaceAll('.', '');
                      final amount = int.tryParse(raw) ?? 0;

                      // TODO: nanti kirim amount ke backend untuk bikin paymentUrl, skrg cukup ke webview yg redirect google
                      Navigator.pushNamed(context, '/wallet-va-webview');
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
