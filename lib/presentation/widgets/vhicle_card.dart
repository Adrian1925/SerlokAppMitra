import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

Widget buildVehicleCard({
    required String imagePath,
    required String status,
    required Color statusColor,
    required String title,
    required String seat,
    required String transmission,
    required String fuel,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imagePath,
                width: 120,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: statusColor != AppColors.yellow ?  statusColor.withOpacity(0.2) : statusColor.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: statusColor == AppColors.yellow ? AppColors.brown : statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.airline_seat_recline_normal,
                color: Colors.blue, size: 16),
            const SizedBox(width: 4),
            Text('$seat Seat'),
            const SizedBox(width: 10),
            const Icon(Icons.directions_car, color: Colors.blue, size: 16),
            const SizedBox(width: 4),
            Text(transmission),
            const SizedBox(width: 10),
            const Icon(Icons.local_gas_station, color: Colors.blue, size: 16),
            const SizedBox(width: 4),
            Text(fuel),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey.shade300,
        ),
        const SizedBox(height: 12),
      ],
    );
  }