import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class StatusCard extends StatelessWidget {
  final String state;
  final ValueChanged<bool> onToggle;

  const StatusCard({required this.state, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final bool isOnline = state == 'online';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: state == 'online' ? AppColors.primary : AppColors.strongRed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                state == 'online'
                    ? 'Anda dapat menerima order'
                    : 'Anda tidak dapat menerima order',
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
          Switch(
            value: isOnline,
            onChanged: onToggle,
            activeTrackColor: Colors.green.shade400,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}

