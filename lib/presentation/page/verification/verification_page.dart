import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../widgets/profile_action_button.dart';
import 'verification_flow_page.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verifikasi Akun anda',
                    style: AppTextStyles.bold24.copyWith(
                      height: 1.55,
                      letterSpacing: 0,
                    ),
                  ),
                  Text(
                    'Untuk menjadi mitra, kami membutuhkan beberapa informasi dibawah ini.',
                    style: AppTextStyles.regular15.copyWith(
                      color: AppColors.textProfileOption.withValues(alpha: 0.5),
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 38),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VerificationRequirementItem(
                          icon: Icons.person,
                          title: 'Foto Selfie Anda',
                          description:
                              'Foto wajah anda terkini. Tidak boleh ambil dari galery.',
                        ),
                        Divider(
                          color: AppColors.textProfileOption.withValues(
                            alpha: 0.05,
                          ),
                          height: 34,
                        ),
                        VerificationRequirementItem(
                          icon: Icons.badge_outlined,
                          title: 'Kartu Tanda Penduduk',
                          description:
                              'Anda harus membuktikan status anda sebagai WNI dengan melampirkan KTP.',
                        ),
                        Divider(
                          color: AppColors.textProfileOption.withValues(
                            alpha: 0.05,
                          ),
                          height: 34,
                        ),
                        VerificationRequirementItem(
                          icon: Icons.location_on_outlined,
                          title: 'Alamat Lengkap',
                          description:
                              'Isikan alamat lengkap anda saat ini. Kami tidak akan menyebarkannya kepada pihak manapun',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              ProfileActionButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
          
                  final cameraStatus = await Permission.camera.request();
          
                  if (!context.mounted) return;
          
                  if (cameraStatus.isGranted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerificationFlowPage(),
                      ),
                    );
                  } else if (cameraStatus.isDenied) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Izin kamera dibutuhkan untuk mengambil selfie.',
                        ),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else if (cameraStatus.isPermanentlyDenied ||
                      cameraStatus.isRestricted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Akses kamera ditolak permanen. Aktifkan izin di Pengaturan.',
                        ),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'Buka Pengaturan',
                          onPressed: openAppSettings,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Status izin tidak diketahui.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                text: const Text('Lanjutkan', style: AppTextStyles.semi16),
              ),
              SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }
}

class VerificationRequirementItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const VerificationRequirementItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.semi15),
              Text(
                description,
                style: AppTextStyles.regular13.copyWith(
                  color: AppColors.textProfileOption.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
