import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/responsive.dart';
import '../main_page.dart';
import 'sewa_aktif_detail.dart';

class SewaActivePage extends StatefulWidget {
  const SewaActivePage({super.key});

  @override
  State<SewaActivePage> createState() => _SewaActivePageState();
}

class _SewaActivePageState extends State<SewaActivePage> {
  String selectedWidgets = 'A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: _buildFloatingButton(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: baseWidth * 0.04,
            vertical: baseHeight * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              SizedBox(height: baseHeight * 0.04),
              if (selectedWidgets == 'A') ...[
                _buildEmpetyContent(),
              ] else if (selectedWidgets == 'B') ...[
                _buildSectionContent(),
              ],
              SizedBox(height: baseHeight * 0.03),
            ],
          ),
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
        onPressed: () {},
      ),
    );
  }

  Widget _buildAppBar() {
    return Stack(
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
            'Active Page',
            style: AppTextStyles.semi20,
          ),
        ),
      ],
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
            'Belum ada sewa yang aktif nih',
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

  Widget _buildSectionContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primary.withOpacity(0.08),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      Container(
                        width: baseWidth * 0.8,
                        height: baseHeight * 0.045,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.primary,
                        ),
                        child: Center(
                          child: Text(
                            "Mobil dan Driver",
                            style: AppTextStyles.semi18.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: baseHeight * 0.012),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildDateColumn("10 Agustus", "09 : 00"),
                          SizedBox(width: baseWidth * 0.05),
                          const Icon(Icons.arrow_forward),
                          SizedBox(width: baseWidth * 0.05),
                          _buildDateColumn("17 Agustus", "23 : 59"),
                        ],
                      ),
                      SizedBox(height: baseHeight * 0.012),
                      Column(
                        children: [
                          Text(
                            "Penjemputan",
                            style: AppTextStyles.semi18.copyWith(
                              color: AppColors.textGrayScale100,
                            ),
                          ),
                          SizedBox(height: baseHeight * 0.005),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColors.primary,
                                size: baseWidth * 0.05,
                              ),
                              Text(
                                "Surabaya, Jawa Timur",
                                style: AppTextStyles.regular16.copyWith(
                                  color: AppColors.textGrayScale100,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: baseHeight * 0.002,
                  color: AppColors.grey,
                ),
                Column(
                  children: [
                    _buildCarCardActive(
                      baseWidth,
                      imageUrl: "assets/images/list_home.png",
                      location: "Rungkut, Surabaya",
                      title: "Honda City 2015 with Driver",
                      seats: "6 Seat",
                      transmission: "Matic",
                      fuel: "Bensin",
                      isActive: true,
                      onStatusChanged: (newStatus) {},
                    ),
                    Container(
                      height: 90,
                      padding:
                          EdgeInsets.symmetric(horizontal: baseWidth * 0.04),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rp 600.000",
                                style: AppTextStyles.semi16.copyWith(
                                  color: AppColors.white,
                                  fontSize: baseWidth * 0.05,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Durasi 8 hari",
                                style: AppTextStyles.semi14
                                    .copyWith(color: Color(0xFFFFCECE)),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Chat Mitra",
                              style: AppTextStyles.semi18.copyWith(
                                color: AppColors.white,
                                fontSize: baseWidth * 0.05,
                                height: 1.6,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: baseHeight * 0.01),
          Container(
            height: baseHeight * 0.008,
            width: baseWidth * 0.25,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateColumn(String date, String time) {
    return Column(
      children: [
        Text(
          date,
          style: AppTextStyles.semi18.copyWith(
            color: AppColors.textGrayScale100,
          ),
        ),
        Text(
          time,
          style: AppTextStyles.regular16.copyWith(
            color: AppColors.textGrayScale100,
          ),
        ),
      ],
    );
  }

  Widget _buildCarCardActive(
    double baseWidth, {
    required String imageUrl,
    required String location,
    required String title,
    required String seats,
    required String transmission,
    required String fuel,
    required bool isActive,
    required void Function(bool) onStatusChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SewaAktifDetailPage()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        imageUrl,
                        width: baseWidth * 0.25,
                        height: baseWidth * 0.18,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(location,
                              style: AppTextStyles.regular14
                                  .copyWith(color: AppColors.textGrayScale60)),
                          Text(title,
                              style: AppTextStyles.semi16
                                  .copyWith(color: AppColors.textGrayScale100)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: baseHeight * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.airline_seat_recline_normal,
                            size: 26, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text(
                          seats,
                          style: AppTextStyles.regular16
                              .copyWith(color: AppColors.black),
                        ),
                      ],
                    ),
                    Text(
                      'Dalam Kota - Sekali Jalan',
                      style: AppTextStyles.regular14.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}