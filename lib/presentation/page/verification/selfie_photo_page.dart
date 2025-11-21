import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../bloc/verification/verification_bloc.dart';
import '../../widgets/exit_confirmation_dialog.dart';
import '../../widgets/profile_action_button.dart';

class SelfiePhotoPage extends StatefulWidget {
  final VoidCallback? nextStep;
  const SelfiePhotoPage({super.key, this.nextStep});

  @override
  State<SelfiePhotoPage> createState() => _SelfiePhotoPageState();
}

class _SelfiePhotoPageState extends State<SelfiePhotoPage> {
  CameraController? _cameraController;
  bool _isInitialized = false;
  File? _capturedPhoto;

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _cameraController!.initialize();

    if (!mounted) return;
    setState(() => _isInitialized = true);
  }

  Future<void> _capturePhoto(BuildContext context) async {
    if (!_cameraController!.value.isInitialized) return;

    final file = await _cameraController!.takePicture();
    File capturedFile = File(file.path);

    _cameraController?.dispose();

    setState(() {
      _capturedPhoto = capturedFile;
    });
  }

  Future<void> _retakePhoto() async {
    final shouldExit = await showExitConfirmationDialog(
      context: context,
      title: 'Konfirmasi',
      content: 'Apakah Anda yakin ingin mengulang foto selfie?',
      cancelText: 'Batal',
      confirmText: 'Ya, Ambil Ulang',
    );

    if (shouldExit) {
      await _cameraController?.dispose();

      context.read<UpgradeAccountBloc>().add(
        ResetData(scope: ResetScope.selfieOnly),
      );

      await _initializeCamera();
      setState(() {
        _capturedPhoto = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 32,
        children: [
          const Text(
            'Ambil foto yang jelas, tidak blur, dan perhatikan  pencahayaan yang bagus',
            style: AppTextStyles.regular20,
            textAlign: TextAlign.center,
          ),
          ClipOval(
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: 1,
                  child: () {
                    if (!_isInitialized) {
                      return Container(
                        color: AppColors.textGrayScale60,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        ),
                      );
                    } else if (_capturedPhoto != null) {
                      return Image.file(_capturedPhoto!);
                    } else if (_cameraController!.value.isInitialized) {
                      return CameraPreview(_cameraController!);
                    } else {
                      return Container(
                        color: AppColors.textGrayScale60,
                        child: const Center(
                          child: Text(
                            'Kamera belum siap',
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      );
                    }
                  }(),
                ),
              ),
            ),
          ),
          (_capturedPhoto != null)
              ? Column(
                children: [
                    const Text(
                      'Lanjutkan menggunakan foto ini ?',
                      style: AppTextStyles.regular20,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ProfileActionButton(
                            backgroundColor: AppColors.white,
                            text: Text(
                              'Ulangi Foto',
                              style: AppTextStyles.semi16.copyWith(
                                color: AppColors.textProfileOption,
                              ),
                            ),
                            onPressed: () {
                              _retakePhoto();
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ProfileActionButton(
                            size: Size(MediaQuery.of(context).size.width * 0.6, 56),
                            text: Text('Lanjutkan', style: AppTextStyles.semi16),
                            onPressed: () async {
                              await _cameraController?.dispose();
                              
                              context.read<UpgradeAccountBloc>().add(
                                SaveSelfiePhoto(_capturedPhoto!),
                              );
                              if (widget.nextStep != null) widget.nextStep!();
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              )
              : ProfileActionButton(
                  size: Size(MediaQuery.of(context).size.width * 0.6, 56),
                  backgroundColor: AppColors.white,
                  text: Text(
                    'Ambil Foto',
                    style: AppTextStyles.semi16.copyWith(
                      color: AppColors.textProfileOption,
                    ),
                  ),
                  onPressed: (_isInitialized)
                      ? () => _capturePhoto(context)
                      : null,
                ),
        ],
      ),
    );
  }
}
