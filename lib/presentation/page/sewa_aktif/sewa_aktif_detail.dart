import 'package:flutter/material.dart';
import 'package:serlok_mitra/core/constants/responsive.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class SewaAktifDetailPage extends StatelessWidget {
  const SewaAktifDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Detail Order Sewa",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Profil Penyewa",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        "https://i.pravatar.cc/100",
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Devan Prasetian",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.verified, color: Colors.grey, size: 16),
                            SizedBox(width: 4),
                            Text(
                              "Standart Account",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Bergabung sejak September 2020",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text("Tipe Sewa",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              const Text(
                "Mobil dan Driver",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 25),
              const Text("Durasi Sewa",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              const Text(
                "10 Agustus, 09:00   →   17 Agustus, 23:59",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 25),
              const Text("Penjemputan",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              const Text(
                "Jl. Ngagel Rejo Kidul 16  Kec. Ngagel, Kota\nSurabaya, Jawa Timur",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 15),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.event_seat, color: Colors.blue, size: 26),
                        SizedBox(width: 8),
                        Text("6 Seat"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.drive_eta, color: Colors.blue, size: 26),
                        SizedBox(width: 8),
                        Text("Manual/Matic"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text("Tujuan Penggunaan",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              const Text(
                "Dalam Kota - Sekali Jalan",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 25),
              const Text("PERHATIAN",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xffF7F9FC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.thumb_up_alt_outlined,
                        color: Colors.blue, size: 35),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        "Terima pembayaran langsung dari pelanggan, saat anda telah mengantar mobil ke tempat pelanggan",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: baseHeight * 0.12,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          decoration: const BoxDecoration(
            color: Color(0xff1C1539),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Rp 3.000.000",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Durasi 8 hari",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.red.withOpacity(0.8),
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {},
                child: Container(
                  width: baseWidth * 0.44,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Chat Customer",
                    style: AppTextStyles.bold24.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        )
      );
  }
}
