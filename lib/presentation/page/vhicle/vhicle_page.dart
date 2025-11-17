import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/responsive.dart';
import '../../widgets/vhicle_card.dart';
import '../main_page.dart';
import 'add_vehicle_intro.dart';

class VhiclePage extends StatefulWidget {
  const VhiclePage({super.key});

  @override
  State<VhiclePage> createState() => _VhiclePageState();
}

class _VhiclePageState extends State<VhiclePage> {
  String selectedWidgets = 'A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: _buildFloatingButton(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.shade300,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: baseWidth * 0.04,
                  vertical: baseHeight * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (selectedWidgets == 'A') ...[
                      SizedBox(height: baseHeight * 0.04),
                      _buildEmpetyContent(),
                    ] else if (selectedWidgets == 'B') ...[
                      SizedBox(height: baseHeight * 0.02),
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
                    SizedBox(height: baseHeight * 0.02),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IntroTambahKendaraanPage(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: baseWidth * 0.05,
                            vertical: baseHeight * 0.015,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: baseWidth * 0.065,
                              ),
                              SizedBox(width: baseWidth * 0.02),
                              Text(
                                'Tambah Kendaraan',
                                style: AppTextStyles.bold24.copyWith(
                                  color: Colors.white,
                                  fontSize: baseWidth * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) async {
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;

        final selected = await showMenu<String>(
          context: context,
          position: RelativeRect.fromRect(
            details.globalPosition & const Size(40, 40),
            Offset.zero & overlay.size,
          ),
          items: const [
            PopupMenuItem(value: 'A', child: Text('Kondisi A')),
            PopupMenuItem(value: 'B', child: Text('Kondisi B')),
          ],
        );

        if (selected != null) {
          setState(() => selectedWidgets = selected);
        }
      },
      child: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        label: Row(
          children: [
            const Icon(Icons.filter_alt_rounded, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Kondisi: $selectedWidgets',
              style: AppTextStyles.semi16.copyWith(color: Colors.white),
            ),
          ],
        ),
        onPressed: () {
          //
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
            horizontal: baseWidth * 0.04,
            vertical: baseHeight * 0.01,
          ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainTabPage()),
                );
              },
              child: Icon(
                Icons.arrow_back,
                size: baseWidth * 0.08,
              ),
            ),
          ),
          Center(
            child: Text(
              'Kendaraan Saya',
              style: AppTextStyles.semi20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpetyContent() {
    return Center(
      child: Column(
        children: [
          Image.asset(
            'assets/images/active_empty.png',
            width: baseWidth * 0.6,
          ),
          SizedBox(height: baseHeight * 0.02),
          Text(
            'Anda belum mempunyai kendaraan',
            textAlign: TextAlign.center,
            style: AppTextStyles.bold24.copyWith(
              color: AppColors.textGrayScale100,
              fontSize: baseWidth * 0.055,
            ),
          ),
        ],
      ),
    );
  }
}
