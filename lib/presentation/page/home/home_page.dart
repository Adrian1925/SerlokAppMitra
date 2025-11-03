import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../verification/verification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String condition = 'A';
  bool isOnline = true;
  final List<String> options = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            NetworkImage('https://i.pravatar.cc/150?img=3'),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Aditya Eka',
                              style: AppTextStyles.semi16
                                  .copyWith(color: AppColors.black)),
                          Text('Rp 0',
                              style: AppTextStyles.semi14.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  // helper button to switch condition in pahe home 
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        final selected = await showMenu<String>(
                          context: context,
                          position: RelativeRect.fromLTRB(100, 80, 16, 0),
                          items: options
                              .map((e) => PopupMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                        );

                        if (selected != null) {
                          setState(() {
                            condition = selected;
                          });
                        }
                      },
                      child: Text(
                        'ISI SALDO',
                        style: AppTextStyles.semi14.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              buildContentByCondition(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContentByCondition() {
    switch (condition) {
      case 'A':
        return buildContentA();
      case 'B':
        return buildContentB();
      case 'C':
        return buildContentC();
      case 'D':
        return buildContentD();
      default:
        return buildContentA();
    }
  }

  Widget buildContentA() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Akun anda membutuhkan verifikasi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Kami membutuhkan beberapa dokumen dan data anda',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VerificationPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Mulai Verifikasi Sekarang',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContentB() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Akun anda sedang kami review',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Kami akan menghubungi anda jika ada kendala',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContentC() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  'Saldo anda tidak mencukupi',
                  style: AppTextStyles.regular16.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Saldo harus minimal ',
                      style: AppTextStyles.semi14.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(
                          text: 'Rp 100.000',
                          style: AppTextStyles.semi14.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' untuk menerima order',
                          style: AppTextStyles.semi14.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          buildContentreusable(),
        ],
      ),
    );
  }

  Widget buildContentreusable() {
    return Column(
      children: [
        Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1C143D),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text('Kamu punya',
                    style: AppTextStyles.semi14.copyWith(
                      color: Colors.white,
                    )),
                SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    text: '0 ',
                    style: AppTextStyles.semi20.copyWith(
                        color: AppColors.primary, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: 'sewa aktif',
                        style: AppTextStyles.semi20.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Kendaraan Saya',
                  style: AppTextStyles.semi16.copyWith(color: AppColors.black)),
              Text('Lihat Semua',
                  style:
                      AppTextStyles.semi14.copyWith(color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.textProfileOption.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text('Belum ada kendaraan',
                    style:
                        AppTextStyles.semi16.copyWith(color: AppColors.black)),
                const SizedBox(height: 4),
                Text('Tambahkan kendaraan yang ingin disewakan',
                    style: AppTextStyles.regular12
                        .copyWith(color: AppColors.textGrayScale90)),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1C143D),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: Text('Tambahkan Kendaraan',
                      style: AppTextStyles.semi14
                          .copyWith(color: AppColors.white)),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget buildContentD() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isOnline ? AppColors.primary : AppColors.strongRed,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isOnline ? 'ONLINE' : 'OFFLINE',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isOnline
                          ? 'Anda dapat menerima order'
                          : 'Anda tidak dapat menerima order',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: isOnline,
                  onChanged: (value) {
                    setState(() {
                      isOnline = value;
                    });
                  },
                  activeTrackColor: Colors.green.shade400,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey.shade400,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          buildContentreusable(),
        ],
      ),
    );
  }
}