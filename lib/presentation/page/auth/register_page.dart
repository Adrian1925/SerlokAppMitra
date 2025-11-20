import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_device_imei/flutter_device_imei.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/helper/device_helper.dart';
import '../../../core/utility/dialog_helper.dart';

import '../../../data/model/auth_singup_model.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final DeviceHelper _deviceHelper = DeviceHelper();
  bool _obscurePassword = true;

  String imei1 = "";
  String imei2 = "";
  String deviceId = "";
  String deviceType = "";

  @override
  void initState() {
    super.initState();
    _initDevice();  
  }

  Future<void> _initDevice() async {
    await _deviceHelper.initIMEI();
    try {
      final devData = await _deviceHelper.getDeviceData();
      print("Device data di register: $devData");
    } catch (e) {
      print("Gagal ambil device data saat register: $e");
    }
    setState(() {}); 
  }

  void _doRegister() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || phone.isEmpty || password.isEmpty) {
      showCustomDialog(
        context: context,
        type: DialogType.error,
        title: 'Gagal',
        message: 'Semua field harus diisi.',
        buttonText: 'Ok',
        onPressed: () => Navigator.pop(context),
      );
      return;
    }
    final request = SignupRequest(
      name: name,
      mobile: phone,
      password: password,
      deviceId: _deviceHelper.deviceId,
      deviceType: Platform.isAndroid ? "android" : "ios",
      imei1: _deviceHelper.imei1,
      imei2: _deviceHelper.imei2,
    );
    context.read<AuthBloc>().add(SignupSubmitted(request));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is AuthupSuccess) {
            Navigator.pop(context); 

            showCustomDialog(
              context: context,
              type: DialogType.success,
              title: 'Berhasil!',
              message: 'Akun anda berhasil dibuat.',
              buttonText: 'Lanjut',
              onPressed: () {
                Navigator.pop(context); 
                Navigator.pushNamed(context, '/login');
              },
            );
          }

          if (state is AuthupFailure) {
            Navigator.pop(context); 

            showCustomDialog(
              context: context,
              type: DialogType.error,
              title: 'Pendaftaran Gagal',
              message: state.error,
              buttonText: 'Ok',
              onPressed: () => Navigator.pop(context),
            );
          }
        },
        child: _buildRegisterForm(),
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Column(
                children: [
                  Text(
                    'Buat Akun Baru',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Isikan detail akun anda dengan benar',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text("Nama Lengkap",
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: _inputDecoration("Masukkan nama lengkapmu"),
            ),
            const SizedBox(height: 20),
            const Text("No Whatsapp Aktif",
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: _inputDecoration("Masukkan Nomor WhatsAppmu"),
            ),
            const SizedBox(height: 20),
            const Text("Password",
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: _inputDecoration("Minimal 8 karakter").copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.secondary,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _doRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Daftarkan Akun',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Column(
                children: [
                  Text(
                    'Dengan mendaftar, anda telah menyetujui',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Syarat dan Ketentanan berlaku',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
