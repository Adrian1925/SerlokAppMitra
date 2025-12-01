import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class EmptyVehicleSection extends StatelessWidget {
  final VoidCallback onAddVehicle;

  const EmptyVehicleSection({required this.onAddVehicle});

  @override
  Widget build(BuildContext context) {
    return _VehicleContainer(
      child: Column(
        children: [
          Text(
            'Belum ada kendaraan',
            style: AppTextStyles.semi16.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 4),
          Text(
            'Tambahkan kendaraan yang ingin disewakan',
            style: AppTextStyles.regular12
                .copyWith(color: AppColors.textGrayScale90),
          ),
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
            label: Text(
              'Tambahkan Kendaraan',
              style: AppTextStyles.semi14.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
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