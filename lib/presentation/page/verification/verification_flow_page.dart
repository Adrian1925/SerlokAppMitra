import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../bloc/verification/verification_bloc.dart';
import '../../widgets/exit_confirmation_dialog.dart';
import '../../widgets/step_progress_indicator_widget.dart';
import 'address_page.dart';
import 'identity_photo_page.dart';
import 'selfie_photo_page.dart';

class VerificationFlowPage extends StatefulWidget {
  const VerificationFlowPage({super.key});

  @override
  State<VerificationFlowPage> createState() => _VerificationFlowPageState();
}

class _VerificationFlowPageState extends State<VerificationFlowPage> {
  int _currentStep = 0;

  List<Widget> get pages => [
    SelfiePhotoPage(nextStep: nextStep),
    IdentityPhotoPage(nextStep: nextStep),
    AddressPage(),
  ];

  final List<String> titles = const [
    'Foto Selfie Anda',
    'Kartu Tanda Penduduk',
    'Alamat Lengkap',
  ];

  void nextStep() {
    if (_currentStep < pages.length - 1) {
      setState(() => _currentStep++);
    }
  }

  void prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void sendData() {
    // TODO: Implementasi pengiriman data
    print('Data telah dikirim!');
    Navigator.pop(context); 
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpgradeAccountBloc(),
      child: Builder(
        builder: (context) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) async {
              if (!didPop) {
                final shouldLeave = await showExitConfirmationDialog(
                  context: context,
                  title: 'Apakah Anda yakin ingin keluar?',
                  content: 'Progres yang belum disimpan mungkin akan hilang.',
                  cancelText: 'Batal',
                  confirmText: 'Ya, Keluar',
                );
                if (shouldLeave) {
                  context.read<UpgradeAccountBloc>().add(
                    ResetData(scope: ResetScope.all),
                  );
                  Navigator.of(context).pop();
                }
              }
            },
            child: Scaffold(
              backgroundColor: pages.length - 1 == _currentStep
                  ? AppColors.background
                  : AppColors.secondary,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.close_rounded, color: AppColors.black),
                  onPressed: () async {
                    final shouldExit = await showExitConfirmationDialog(
                      context: context,
                      title: 'Apakah Anda yakin ingin keluar?',
                      content:
                          'Progres yang belum disimpan mungkin akan hilang.',
                      cancelText: 'Batal',
                      confirmText: 'Ya, Keluar',
                    );
                    if (shouldExit) {
                      context.read<UpgradeAccountBloc>().add(
                        ResetData(scope: ResetScope.all),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
                backgroundColor: AppColors.background,
                elevation: 0,
                title: Text(
                  '${titles[_currentStep]}',
                  style: AppTextStyles.semi15,
                ),
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(4.0),
                  child: StepProgressIndicator(
                    currentStep: _currentStep,
                    totalSteps: pages.length,
                  ),
                ),
              ),
              body: pages[_currentStep],
            ),
          );
        },
      ),
    );
  }
}
