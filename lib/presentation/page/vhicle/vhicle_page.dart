import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/responsive.dart';
import '../../bloc/add_vhicle/add_vehicle_bloc.dart';
import '../../bloc/add_vhicle/add_vehicle_event.dart';
import '../../bloc/add_vhicle/add_vehicle_state.dart';
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
  void initState() {
    super.initState();
    context.read<VehicleBloc>().add(LoadVehicleList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                child: BlocBuilder<VehicleBloc, VehicleState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.vehicles.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(height: baseHeight * 0.04),
                          _buildEmpetyContent(),
                          SizedBox(height: baseHeight * 0.02),
                          _buildAddVehicleButton(context),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        Column(
                          children: state.vehicles.map((v) {
                            return buildVehicleCard(
                              imagePath: v.pictureUrl,
                              status: v.status,
                              statusColor: v.status == "pending"
                                  ? AppColors.yellow
                                  : AppColors.green,
                              title: v.name,
                              seat: "${v.seats} Orang",
                              transmission: v.transmission,
                              fuel: v.fuelType,
                            );
                          }).toList(),
                        ),
                        SizedBox(height: baseHeight * 0.02),
                        _buildAddVehicleButton(context),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddVehicleButton(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const IntroTambahKendaraanPage(),
            ),
          ).then((_) {
            context.read<VehicleBloc>().add(LoadVehicleList());
          });
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