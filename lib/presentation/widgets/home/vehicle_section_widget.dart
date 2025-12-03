import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/model/vehicle_model.dart';
import '../vhicle_card.dart';
import 'vhicle_header_widget.dart';

class VehicleSection extends StatelessWidget {
  final List<VehicleModel> vehicles;

  const VehicleSection({required this.vehicles});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VehicleHeader(),
        const SizedBox(height: 12),
        Column(
          children: vehicles.map((v) {
            return buildVehicleCard(
              imagePath: v.pictureUrl,
              status: v.status,
              statusColor: v.status == "pending" ? AppColors.yellow : AppColors.green,
              title: v.name,
              seat: "${v.seats} Orang",
              transmission: v.transmission,
              fuel: v.fuelType,
            );
          }).toList(),
        ),
      ],
    );
  }
}