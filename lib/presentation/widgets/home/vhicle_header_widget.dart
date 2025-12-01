import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class VehicleHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Kendaraan Saya',
          style: AppTextStyles.semi16.copyWith(color: AppColors.black),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/vehicle');
          },
          child: Text(
            'Lihat Semua',
            style: AppTextStyles.semi14.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
