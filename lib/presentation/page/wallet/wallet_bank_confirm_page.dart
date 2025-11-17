import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serlok_mitra/core/utility/rupiah_formatter.dart';
import 'package:serlok_mitra/presentation/widgets/primary_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class WalletBankConfirmPage extends StatefulWidget {
  const WalletBankConfirmPage({super.key});

  @override
  State<WalletBankConfirmPage> createState() => _WalletBankConfirmPageState();
}

class _WalletBankConfirmPageState extends State<WalletBankConfirmPage> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1500,
        maxHeight: 1500,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      final file = File(pickedFile.path);
      final bytes = await file.length();

      const maxSize = 5 * 1024 * 1024; // 5MB
      if (bytes > maxSize) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ukuran file maksimal 5MB'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      if (!mounted) return;
      setState(() {
        _selectedImage = file;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memilih gambar'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String logo = args['logo'] as String;
    final String name = args['name'] as String;
    final String account = args['account'] as String;
    final int amount = args['amount'] as int;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Bank Transfer', style: AppTextStyles.medium18),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: const Border(
          bottom: BorderSide(color: AppColors.dividerGray, width: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tujuan Transfer',
              style: AppTextStyles.semi14.copyWith(
                color: AppColors.textProfileOption,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(logo, width: 60),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTextStyles.semi14.copyWith(
                          color: AppColors.textProfileOption,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        account,
                        style: AppTextStyles.regular13.copyWith(
                          color: AppColors.textGrayScale70,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: account));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Nomor rekening disalin'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text(
                    'Salin',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.greyBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Transfer ke rekening diatas sebesar',
                    style: AppTextStyles.regular13.copyWith(
                      color: AppColors.textProfileOption,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp ${formatRupiah(amount)}',
                    style: AppTextStyles.semi18.copyWith(
                      color: AppColors.textProfileOption,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Bukti Transfer (opsional)',
              style: AppTextStyles.semi14.copyWith(
                color: AppColors.textProfileOption,
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // tempat gambar
                  Expanded(
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: AppColors.greyBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _selectedImage == null
                          ? const Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 40,
                                color: AppColors.textGrayScale70,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // teks & tombol pilih gambar
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload file maksimal 5MB',
                          style: AppTextStyles.regular12.copyWith(
                            color: AppColors.textGrayScale70,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: OutlinedButton(
                            onPressed: _pickImage,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColors.primary,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                            ),
                            child: Text(
                              'Pilih Gambar',
                              style: AppTextStyles.semi12.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            PrimaryButton(
              text: "Saya sudah transfer",
              enabled: true,
              onPressed: () {
                // TODO: submit konfirmasi transfer
                // bisa kirim _selectedImage (jika tidak null) ke backend
              },
            ),

            const SizedBox(height: 8),

            Text(
              'Tekan tombol diatas hanya jika anda sudah melakukan transfer ke rekening tujuan.',
              textAlign: TextAlign.center,
              style: AppTextStyles.regular11.copyWith(
                color: AppColors.textGrayScale70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
