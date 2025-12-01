import 'package:flutter/material.dart';

import 'empty_vehicle_section_widget.dart';
import 'info_banner_widget.dart';

class SaldoWarningSection extends StatelessWidget {
  final VoidCallback onAddVehicle;

  const SaldoWarningSection({required this.onAddVehicle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoBanner(
          title: 'Saldo anda tidak mencukupi',
          subtitle: 'Saldo harus minimal Rp 10.000 untuk menerima order',
        ),
        const SizedBox(height: 16),
        EmptyVehicleSection(onAddVehicle: onAddVehicle), //ini
      ],
    );
  }
}