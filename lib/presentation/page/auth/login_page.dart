import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:serlok_mitra/core/constants/app_colors.dart';
import 'package:serlok_mitra/presentation/page/main_page.dart';

import '../../../core/helper/device_helper.dart';
import '../../../core/utility/dialog_helper.dart';
import '../../../data/model/auth_singup_model.dart';
import '../../../data/service/profile_service.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_event.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final secureStorage = FlutterSecureStorage();
  final DeviceHelper _deviceHelper = DeviceHelper();
  bool _obscurePassword = true;

  String imei1 = "";
  String imei2 = "";
  String deviceId = "";

  @override
  void initState() {
    super.initState();
    _initDevice();
  }
  Future<void> _initDevice() async {
    await _deviceHelper.initIMEI();
    imei1 = _deviceHelper.imei1;
    imei2 = _deviceHelper.imei2;
    deviceId = _deviceHelper.deviceId;
    try {
      final devData = await _deviceHelper.getDeviceData();
      print("Device data: $devData");
    } catch (e) {
      print("Error mendapatkan device data: $e");
    }
    setState(() {});
  }


  void _doRegister() {
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
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

    final request = SigninRequest(
      mobile: phone,
      password: password,
      deviceId: _deviceHelper.deviceId,
      imei1: _deviceHelper.imei1,
      imei2: _deviceHelper.imei2,
    );

    context.read<AuthBloc>().add(SigninSubmitted(request));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is AuthinSuccess) {
            final token = state.data['token'];
            await secureStorage.write(key: 'token', value: token);

            context.read<ProfileBloc>().add(FetchProfile());
            try {
              final deviceData = await _deviceHelper.getDeviceData();
              print("DeviceData terkirim ke updateLocationApi: $deviceData");
              final result = await ProfileService().updateLocationApi(deviceData);
              print("Hasil updateLocationApi: $result");
            } catch (e) {
              print("Error kirim device data: $e");
            }
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            showCustomDialog(
              context: context,
              type: DialogType.success,
              title: 'Berhasil!',
              message: 'Anda berhasil masuk.',
              buttonText: 'Lanjut',
              onPressed: () {
                Navigator.pop(context);
                // Navigator.pushReplacementNamed(context, '/home-page');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MainTabPage()),
                );
              },
            );
          }

          if (state is AuthinFailure) {
            Navigator.pop(context); 

            showCustomDialog(
              context: context,
              type: DialogType.error,
              title: 'Error',
              message: state.error,
              buttonText: 'Ok',
              onPressed: () => Navigator.pop(context),
            );
          }
        },
        child: _buildLoginForm(),
      ),
    );
  }
  Widget _buildLoginForm() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 250,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'No Handphone',
                  style: TextStyle(
                    color: AppColors.textGrayScale60,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Masukkan nomor HP mu',
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                    color: AppColors.textGrayScale100,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Masukkan Passwordmu',
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    showCustomDialog(
                      context: context,
                      type: DialogType.success,
                      title: 'Pendaftaran Berhasil !',
                      message: 'Akun anda telah aktif',
                      buttonText: 'Lanjutkan',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                  child: const Text(
                    'Lupa Password?',
                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _doRegister,
                  child: const Text(
                    'Masuk',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: TextStyle(color: AppColors.textGrayScale60),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      'Daftar Akun Baru',
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
