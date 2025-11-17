import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class PilihKendaraanPage extends StatelessWidget {
  const PilihKendaraanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> listKendaraan = [
      {
        "name": "Honda CRV Sport 2021 Automatic",
        "img": "assets/images/list_home.png",
        "seat": "6 Seat",
        "trans": "Matic",
        "fuel": "Bensin",
      },
      {
        "name": "Mitsubishi Expander Sport 2023 Manual",
        "img": "assets/images/list_home.png",
        "seat": "6 Seat",
        "trans": "Manual",
        "fuel": "Bensin",
      }
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Pilih Kendaraan",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: listKendaraan.length,
        itemBuilder: (context, index) {
          final item = listKendaraan[index];

          return GestureDetector(
            onTap: () {
              Navigator.pop(context, item["name"]);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 18),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item["img"]!,
                          height: 90,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "Siap Disewakan",
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                ),
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              item["name"]!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.event_seat,
                          size: 18, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(item["seat"]!),
                      const SizedBox(width: 14),
                      const Icon(Icons.drive_eta,
                          size: 18, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(item["trans"]!),
                      const SizedBox(width: 14),
                      const Icon(Icons.local_gas_station,
                          size: 18, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(item["fuel"]!),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}