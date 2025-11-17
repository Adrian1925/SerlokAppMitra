import 'package:flutter/material.dart';
import 'package:serlok_mitra/presentation/widgets/action_result_dialog.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../widgets/primary_button.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _oldPasswordController.addListener(_onFormChanged);
    _newPasswordController.addListener(_onFormChanged);
    _confirmPasswordController.addListener(_onFormChanged);
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onFormChanged() {
    setState(() {});
  }

  bool get _isFormValid {
    return _oldPasswordController.text.length >= 8 &&
        _newPasswordController.text.length >= 8 &&
        _confirmPasswordController.text.length >= 8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: AppColors.secondary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ubah Password',
          style: AppTextStyles.semi16.copyWith(color: AppColors.secondary),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('Password Lama'),
              const SizedBox(height: 8),
              _PasswordField(
                controller: _oldPasswordController,
                hintText: 'isikan passwordmu saat ini',
                obscureText: _obscureOld,
                onToggleObscure: () {
                  setState(() => _obscureOld = !_obscureOld);
                },
              ),
              const SizedBox(height: 24),
              _buildLabel('Password Baru'),
              const SizedBox(height: 8),
              _PasswordField(
                controller: _newPasswordController,
                hintText: 'Minimal 8 karakter',
                obscureText: _obscureNew,
                onToggleObscure: () {
                  setState(() => _obscureNew = !_obscureNew);
                },
              ),
              const SizedBox(height: 24),
              _buildLabel('Ulangi Password Baru'),
              const SizedBox(height: 8),
              _PasswordField(
                controller: _confirmPasswordController,
                hintText: 'Minimal 8 karakter',
                obscureText: _obscureConfirm,
                onToggleObscure: () {
                  setState(() => _obscureConfirm = !_obscureConfirm);
                },
              ),

              const SizedBox(height: 32),

              PrimaryButton(
                text: 'Ganti Password',
                enabled: _isFormValid,
                onPressed: _isFormValid
                    ? () async {
                        if (_newPasswordController.text !=
                            _confirmPasswordController.text) {
                          await showActionResultDialog(
                            context: context,
                            isSuccess: false,
                            message: 'Ulangi password baru\ndengan benar!',
                            buttonText: 'Ulangi',
                            onAfterClose: () {},
                          );
                          return;
                        }

                        // TODO: panggil API / logic cek password lama
                        // Contoh dummy
                        final bool isOldPasswordCorrect =
                            _oldPasswordController.text == 'passwordlama';

                        if (!isOldPasswordCorrect) {
                          await showActionResultDialog(
                            context: context,
                            isSuccess: false,
                            message: 'Password lama anda\nsalah',
                            buttonText: 'Ulangi',
                            onAfterClose: () {},
                          );
                          return;
                        }
                        await showActionResultDialog(
                          context: context,
                          isSuccess: true,
                          message: 'Password telah berhasil\ndi ubah',
                          buttonText: 'Oke',
                          onAfterClose: () {
                            Navigator.of(context).pop();

                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/main-tab',
                              (route) => false,
                            );
                          },
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTextStyles.semi16.copyWith(color: AppColors.secondary),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggleObscure;

  const _PasswordField({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.onToggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hintText,

                hintStyle: controller.text.isEmpty
                    ? AppTextStyles.semi16.copyWith(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w400,
                      )
                    : AppTextStyles.regular15.copyWith(
                        color: Colors.grey.shade400,
                      ),
              ),

              style: controller.text.isEmpty
                  ? AppTextStyles.semi16.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    )
                  : AppTextStyles.regular15.copyWith(color: Colors.black),
            ),
          ),

          GestureDetector(
            onTap: onToggleObscure,
            child: Icon(
              obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 20,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
