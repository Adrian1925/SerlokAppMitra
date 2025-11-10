import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serlok_mitra/core/constants/responsive.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class TambahKendaraanPage extends StatefulWidget {
  const TambahKendaraanPage({super.key});

  @override
  State<TambahKendaraanPage> createState() => _TambahKendaraanPageState();
}

class _TambahKendaraanPageState extends State<TambahKendaraanPage> {
  final PageController _controller = PageController();
  final TextEditingController namaKendaraanC = TextEditingController();
  final TextEditingController catatanC = TextEditingController();

  XFile? fotoUtama;
  XFile? fotoStnk;
  XFile? fotoPajak;

  int currentStep = 0;
  int selectedSeat = 8;
  String transmisi = "Manual";
  String bahanBakar = "Bensin";

  final List<String> fasilitas = [
    "AC Dingin",
    "Lock Sensor",
    "GPS Tracking",
    "Parking Sensor",
    "Bluetooth Support",
  ];

  List<String> selectedFasilitas = [];

  Future<XFile?> pickImage(ImageSource src) async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: src);
  }

  Widget buildUploadItem({
    required String label,
    required XFile? image,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(label, style: AppTextStyles.semi14),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              height: 110,
              width: baseWidth * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.dividerGray),
                color: AppColors.textFieldBackground,
              ),
              child: image == null
                  ? Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 40,
                        color: AppColors.textGrayScale60,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(image.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
            ),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upload file maksimal 5MB",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: onTap,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    "Pilih Gambar",
                    style: AppTextStyles.semi16.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget step1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text("Nama Kendaraan", style: AppTextStyles.medium15),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.textFieldBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: TextField(
              controller: namaKendaraanC,
              decoration: const InputDecoration(border: InputBorder.none),
              style: AppTextStyles.regular15,
            ),
          ),
          const SizedBox(height: 24),

          Text("Jumlah Seat / Tempat Duduk", style: AppTextStyles.medium15),
          const SizedBox(height: 12),
          Row(
            children: [8, 6, 4, 2].map((seat) {
              final selected = selectedSeat == seat;
              return GestureDetector(
                onTap: () => setState(() => selectedSeat = seat),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : AppColors.dividerGray,
                    ),
                  ),
                  child: Text(
                    "$seat Seat",
                    style: selected
                        ? AppTextStyles.semi14
                            .copyWith(color: AppColors.white)
                        : AppTextStyles.semi14,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),
          Text("Transmisi", style: AppTextStyles.medium15),
          const SizedBox(height: 12),
          Row(
            children: ["Manual", "Automatic"].map((t) {
              final selected = transmisi == t;
              return GestureDetector(
                onTap: () => setState(() => transmisi = t),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : AppColors.dividerGray,
                    ),
                  ),
                  child: Text(
                    t,
                    style: selected
                        ? AppTextStyles.semi14
                            .copyWith(color: AppColors.white)
                        : AppTextStyles.semi14,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),
          Text("Bahan Bakar", style: AppTextStyles.medium15),
          const SizedBox(height: 12),
          Row(
            children: ["Bensin", "Solar", "Listrik"].map((b) {
              final selected = bahanBakar == b;
              return GestureDetector(
                onTap: () => setState(() => bahanBakar = b),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : AppColors.dividerGray,
                    ),
                  ),
                  child: Text(
                    b,
                    style: selected
                        ? AppTextStyles.semi14
                            .copyWith(color: AppColors.white)
                        : AppTextStyles.semi14,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget step2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildUploadItem(
            label: "Foto Utama (pilih foto terbaik)",
            image: fotoUtama,
            onTap: () async {
              final img = await pickImage(ImageSource.gallery);
              if (img != null) setState(() => fotoUtama = img);
            },
          ),
          buildUploadItem(
            label: "Foto STNK (boleh dikosongi)",
            image: fotoStnk,
            onTap: () async {
              final img = await pickImage(ImageSource.gallery);
              if (img != null) setState(() => fotoStnk = img);
            },
          ),
          buildUploadItem(
            label: "Foto Pajak Kendaraan (boleh dikosongi)",
            image: fotoPajak,
            onTap: () async {
              final img = await pickImage(ImageSource.gallery);
              if (img != null) setState(() => fotoPajak = img);
            },
          ),
        ],
      ),
    );
  }

  Widget step3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Pilih fasilitas kendaraan yang dimiliki",
              style: AppTextStyles.semi15),
          const SizedBox(height: 16),
          Column(
            children: fasilitas.map((item) {
              final isChecked = selectedFasilitas.contains(item);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    isChecked
                        ? selectedFasilitas.remove(item)
                        : selectedFasilitas.add(item);
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item,
                        style: AppTextStyles.regular15
                            .copyWith(color: AppColors.black),
                      ),
                    ),
                    Checkbox(
                      value: isChecked,
                      onChanged: (_) {
                        setState(() {
                          isChecked
                              ? selectedFasilitas.remove(item)
                              : selectedFasilitas.add(item);
                        });
                      },
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          Text("Mengapa harus pilih saya ?", style: AppTextStyles.semi15),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.textFieldBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: TextField(
              controller: catatanC,
              maxLines: 5,
              style: AppTextStyles.regular15,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget step4Confirm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Konfirmasi Data", style: AppTextStyles.medium15),
          const SizedBox(height: 12),
          Text("Nama: ${namaKendaraanC.text}", style: AppTextStyles.regular15),
          Text("Seat: $selectedSeat", style: AppTextStyles.regular15),
          Text("Transmisi: $transmisi", style: AppTextStyles.regular15),
          Text("Bahan Bakar: $bahanBakar", style: AppTextStyles.regular15),
          const SizedBox(height: 16),
          Text("Fasilitas:", style: AppTextStyles.medium15),
          ...selectedFasilitas
              .map((f) => Text("• $f", style: AppTextStyles.regular15))
              .toList(),
          const SizedBox(height: 16),
          Text("Catatan:", style: AppTextStyles.medium15),
          Text(
            catatanC.text.isEmpty ? "-" : catatanC.text,
            style: AppTextStyles.regular15,
          ),
        ],
      ),
    );
  }

  Widget buildProgress() {
    return Row(
      children: [1, 2, 3].map((e) {
        final isActive = e - 1 <= currentStep;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 4,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.dividerGray,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }).toList(),
    );
  }

  void nextPage() {
    if (currentStep < 2) {
      setState(() => currentStep++);
      _controller.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: AppColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Informasi Kendaraan",
          style: AppTextStyles.semi16.copyWith(color: AppColors.black),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: buildProgress(),
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                step1(),
                step2(),
                step3(),
                step4Confirm(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: nextPage,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            currentStep < 2 ? "Selanjutnya" : "Selesai",
            style: AppTextStyles.semi16,
          ),
        ),
      ),
    );
  }
}