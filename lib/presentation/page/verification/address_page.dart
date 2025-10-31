import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serlok_mitra/presentation/page/main_page.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utility/snackbar_helper.dart';
import '../../bloc/verification/verification_bloc.dart';
import '../../widgets/profile_action_button.dart';

class AddressPage extends StatefulWidget {
  final VoidCallback? sendData;
  const AddressPage({super.key, this.sendData});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController _addressController = TextEditingController();

  void _onTextChange() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _addressController.addListener(_onTextChange);
  }

  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  bool get _isAddressValid => _addressController.text.trim().isNotEmpty;

  void _handleSubmit(BuildContext context) async {
    if (!_isAddressValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alamat tidak boleh kosong.')),
      );

      return;
    }

    context.read<UpgradeAccountBloc>().add(SubmitData(_addressController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpgradeAccountBloc, UpgradeAccountState>(
      listener: (context, state) {
        if (state.isSuccess) {
          showDialogStyleSnackBar(
            context: context,
            type: SnackBarType.success,
            message: 'Data berhasil dikirim.',
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainTabPage()),
          );
        }

        if (state.error != null) {
          showDialogStyleSnackBar(
            context: context,
            type: SnackBarType.error,
            message: 'Terjadi kesalahan saat mengirim data.',
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Masukkan alamat lengkap Anda.',
                style: AppTextStyles.semi16.copyWith(
                  color: AppColors.textProfileOption,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                      'Jalan Ngagel Rejo Kidul no 127 Surabaya Jawa Timur',
                  hintStyle: AppTextStyles.regular15.copyWith(
                    color: AppColors.textProfileOption.withValues(alpha: 0.5),
                  ),
                  filled: true,
                  fillColor: AppColors.textProfileOption.withValues(
                    alpha: 0.03,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Spacer(),
              ProfileActionButton(
                backgroundColor: _isAddressValid
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.5),
                text: state.isSubmitting
                    ? CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 5,
                      )
                    : Text('Selesai', style: AppTextStyles.semi16),
                onPressed: () {
                  _handleSubmit(context);
                },
              ),
              SizedBox(height: 36),
            ],
          ),
        );
      },
    );
  }
}
