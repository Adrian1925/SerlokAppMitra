import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../bloc/add_vhicle/add_vehicle_bloc.dart';
import '../../bloc/add_vhicle/add_vehicle_event.dart';
import '../../bloc/add_vhicle/add_vehicle_state.dart';
import '../../page/incoming_order/incoming_order_detail.dart';
import 'empty_vehicle_section_widget.dart';
import 'status_card_widget.dart';
import 'tawaran_masuk_card_widgets.dart';
import 'vehicle_section_widget.dart';

class OfferSection extends StatelessWidget {
  final String state;
  final ValueChanged<bool> onToggle;

  const OfferSection({required this.state, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatusCard(state: state, onToggle: onToggle),
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
        BlocBuilder<VehicleBloc, VehicleState>(
          builder: (context, vehicleState) {
            if (vehicleState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vehicleState.vehicles.isEmpty) {
              return EmptyVehicleSection(
                onAddVehicle: () {
                  Navigator.pushNamed(context, '/addVhicleIntro')
                      .then((_) => context.read<VehicleBloc>().add(LoadVehicleList()));
                },
              );
            }

            return VehicleSection(vehicles: vehicleState.vehicles);
          },
        ),
      ],
    );
  }
}