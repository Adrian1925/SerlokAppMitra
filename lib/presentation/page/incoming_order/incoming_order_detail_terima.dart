import 'package:flutter/material.dart';

import 'incoming_order_pilih_kendaraan.dart';

class DetailOrderTerimaPage extends StatefulWidget {
  const DetailOrderTerimaPage({super.key});

  @override
  State<DetailOrderTerimaPage> createState() => _DetailOrderTerimaPageState();
}

class _DetailOrderTerimaPageState extends State<DetailOrderTerimaPage> {
  String? selectedVehicle;
  TextEditingController priceController =
      TextEditingController(text: "4.000.000");

  @override
  Widget build(BuildContext context) {
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
          "Tawarkan Harga",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Harga Pelanggan",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text("Durasi 8 hari"),
              ],
            ),
            const SizedBox(height: 5),
            const Text(
              "Rp 3.000.000",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 25),
            const Text(
              "Pilih Kendaraan yang anda tawarkan",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PilihKendaraanPage(),
                  ),
                );

                if (result != null) {
                  setState(() {
                    selectedVehicle = result;
                  });
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        selectedVehicle ?? "Belum ditentukan",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: selectedVehicle == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    ),
                    const Text(
                      "Tentukan",
                      style: TextStyle(color: Colors.blue),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.blue),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              "Tawarkan Hargamu",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffF7F7F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.lightBlue.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Tawarkan Harga",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}