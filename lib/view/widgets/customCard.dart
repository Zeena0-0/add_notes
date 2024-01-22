import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/app_colors.dart';

class CustomTaskCard extends StatelessWidget {
  final String taskName;
  final String date;
  final DateTime startTime;
  final DateTime endTime;
  final VoidCallback onPressed;
  final int index; // Index to determine the card color

  const CustomTaskCard({super.key,
    required this.taskName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.onPressed,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> cardColors = [
      AppColors.orange,
      AppColors.purple,
      AppColors.green,
      AppColors.peachy,
    ];

    Color cardColor = cardColors[index % cardColors.length];
    final formattedStartTime = DateFormat('h:mm a').format(startTime);
    final formattedEndTime = DateFormat('h:mm a').format(endTime);

    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: cardColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Row(

                  children: [
                    Text(
                      'From $formattedStartTime',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      ' To $formattedEndTime',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
