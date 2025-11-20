import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:serlok_mitra/presentation/page/wallet/wallet_page.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_state.dart';
import '../../widgets/vhicle_card.dart';
import '../incoming_order/incoming_order_detail.dart';
import '../verification/verification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String condition = 'A';
  bool isOnline = true;
  final List<String> options = ['A', 'B', 'C', 'D', 'E', 'F', "wallet"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 32),
              _buildContentByCondition(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
  return BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      if (state is ProfileLoading) {
        return const CircularProgressIndicator();
      }

      if (state is ProfileLoaded) {
        final user = state.profile;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ProfilePicture(
                    name: user.name,
                    radius: 24,
                    img: user.picture,
                    fontsize: 16,
                  ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: AppTextStyles.semi16.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      "Rp ${user.walletBalance}",
                      style: AppTextStyles.semi14.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            TextButton(
              onPressed: () async {
                final selected = await showMenu<String>(
                  context: context,
                  position: RelativeRect.fromLTRB(100, 80, 16, 0),
                  items: options
                      .map((e) => PopupMenuItem(value: e, child: Text(e)))
                      .toList(),
                );
                if (selected != null) setState(() => condition = selected);
              },
              child: Text(
                'ISI SALDO',
                style: AppTextStyles.semi14.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      }
      return const Text("Gagal memuat profil");
    },
  );
}


  Widget _buildContentByCondition(BuildContext context) {
    switch (condition) {
      case 'A':
        return _VerificationBanner();
      case 'B':
        return _InfoBanner(
          title: 'Akun anda sedang kami review',
          subtitle: 'Kami akan menghubungi anda jika ada kendala',
        );
      case 'C':
        return _SaldoWarningSection(
          onAddVehicle: () {},
        );
      case 'D':
        return _OnlineSection(
          isOnline: isOnline,
          onToggle: (v) => setState(() => isOnline = v),
          child: _EmptyVehicleSection(onAddVehicle: () {}),
        );
      case 'E':
        return _OnlineSection(
          isOnline: isOnline,
          onToggle: (v) => setState(() => isOnline = v),
          child: _VehicleSection(),
        );
      case 'F':
        return _OfferSection(
          isOnline: isOnline,
          onToggle: (v) => setState(() => isOnline = v),
        );
      case 'wallet':
        return _InfoBanner(
          title: 'Isi Saldo Dompet Anda',
          subtitle: 'Gunakan dompet untuk menerima order dan transaksi',
          buttonLabel: 'Buka Wallet',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WalletPage()),
            );
          },
        );
      default:
        return _VerificationBanner();
    }
  }
}

class _VerificationBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _InfoBanner(
      title: 'Akun anda membutuhkan verifikasi',
      subtitle: 'Kami membutuhkan beberapa dokumen dan data anda',
      buttonLabel: 'Mulai Verifikasi Sekarang',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VerificationPage()),
        );
      },
    );
  }
}

class _InfoBanner extends StatelessWidget {
  final String title, subtitle;
  final String? buttonLabel;
  final VoidCallback? onPressed;

  const _InfoBanner({
    required this.title,
    required this.subtitle,
    this.buttonLabel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
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
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.black87)),
          if (buttonLabel != null && onPressed != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(buttonLabel!,
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class _SaldoWarningSection extends StatelessWidget {
  final VoidCallback onAddVehicle;
  const _SaldoWarningSection({required this.onAddVehicle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoBanner(
          title: 'Saldo anda tidak mencukupi',
          subtitle: 'Saldo harus minimal Rp 100.000 untuk menerima order',
        ),
        const SizedBox(height: 16),
        _EmptyVehicleSection(onAddVehicle: onAddVehicle),
      ],
    );
  }
}

class _OnlineSection extends StatelessWidget {
  final bool isOnline;
  final ValueChanged<bool> onToggle;
  final Widget child;

  const _OnlineSection({
    required this.isOnline,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StatusCard(isOnline: isOnline, onToggle: onToggle),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}

class _StatusCard extends StatelessWidget {
  final bool isOnline;
  final ValueChanged<bool> onToggle;

  const _StatusCard({required this.isOnline, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(isOnline ? 'ONLINE' : 'OFFLINE',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              const SizedBox(height: 4),
              Text(
                isOnline
                    ? 'Anda dapat menerima order'
                    : 'Anda tidak dapat menerima order',
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
          Switch(
            value: isOnline,
            onChanged: onToggle,
            activeTrackColor: Colors.green.shade400,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}

class _EmptyVehicleSection extends StatelessWidget {
  final VoidCallback onAddVehicle;
  const _EmptyVehicleSection({required this.onAddVehicle});

  @override
  Widget build(BuildContext context) {
    return _VehicleContainer(
      child: Column(
        children: [
          Text('Belum ada kendaraan',
              style: AppTextStyles.semi16.copyWith(color: AppColors.black)),
          const SizedBox(height: 4),
          Text('Tambahkan kendaraan yang ingin disewakan',
              style: AppTextStyles.regular12
                  .copyWith(color: AppColors.textGrayScale90)),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: onAddVehicle,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1C143D),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text('Tambahkan Kendaraan',
                style: AppTextStyles.semi14.copyWith(color: AppColors.white)),
          ),
        ],
      ),
    );
  }
}

class _VehicleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _VehicleHeader(),
        const SizedBox(height: 12),
        buildVehicleCard(
          imagePath: 'assets/images/list_home.png',
          status: 'Menunggu Persetujuan',
          statusColor: AppColors.yellow,
          title: 'Honda CRV Sport 2021 Automatic',
          seat: '4 Orang',
          transmission: 'Manual',
          fuel: 'Bensin',
        ),
        buildVehicleCard(
          imagePath: 'assets/images/list_home.png',
          status: 'Siap Disewakan',
          statusColor: AppColors.green,
          title: 'Honda CRV Sport 2021 Automatic',
          seat: '4 Orang',
          transmission: 'Manual',
          fuel: 'Bensin',
        ),
      ],
    );
  }
}

class _VehicleHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Kendaraan Saya',
            style: AppTextStyles.semi16.copyWith(color: AppColors.black)),
        Text('Lihat Semua',
            style: AppTextStyles.semi14.copyWith(color: AppColors.primary)),
      ],
    );
  }
}

class _VehicleContainer extends StatelessWidget {
  final Widget child;
  const _VehicleContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.textProfileOption.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

Widget tawaranMasukCard({
  required String startDate,
  required String startTime,
  required String endDate,
  required String endTime,
  required String lokasi,
  required int seat,
  required String tipeTrip,
  required String harga,
  required String durasi,
  required VoidCallback onTap,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: AppColors.green.withOpacity(0.04),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.07),
          blurRadius: 12,
          offset: const Offset(0, 4),
        )
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
          ),
          child: const Center(
            child: Text(
              "Mobil dan Driver",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(startDate,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(startTime, style: const TextStyle(fontSize: 13)),
                ],
              ),
              const Icon(Icons.arrow_forward_outlined, size: 20),
              Column(
                children: [
                  Text(endDate,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(endTime, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Penjemputan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        lokasi,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          height: 1.5,
          color: AppColors.textGrayScale90.withOpacity(0.5),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.airline_seat_recline_normal,
                      size: 24, color: AppColors.primary),
                  Text("$seat Seat", style: const TextStyle(fontSize: 16)),
                ],
              ),
              Text(tipeTrip, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF131429),
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rp $harga",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Durasi $durasi",
                    style: TextStyle(color: Color(0xFFFFCECE), fontSize: 14),
                  ),
                ],
              ),
              InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E87F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "LIHAT DETAIL",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _OfferSection extends StatelessWidget {
  final bool isOnline;
  final ValueChanged<bool> onToggle;

  const _OfferSection({required this.isOnline, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatusCard(isOnline: isOnline, onToggle: onToggle),
        const SizedBox(height: 16),
        Text(
          "Tawaran Masuk",
          style: AppTextStyles.semi16.copyWith(color: AppColors.black),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 16),
        tawaranMasukCard(
          startDate: "10 Agustus",
          startTime: "09:00",
          endDate: "17 Agustus",
          endTime: "23:59",
          lokasi: "Surabaya, Jawa Timur",
          seat: 6,
          tipeTrip: "Dalam Kota - Sekali Jalan",
          harga: "3.000.000",
          durasi: "8 hari",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailOrderPage(),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        _VehicleSection(),
      ],
    );
  }
}