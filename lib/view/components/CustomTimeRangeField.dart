import 'package:flutter/material.dart';
import 'package:task_manager/theme/app_colors.dart';

class CustomTimeRangeField extends StatelessWidget {
  final TextEditingController startController;
  final TextEditingController endController;
  final String labelText;

  const CustomTimeRangeField({
    Key? key,
    required this.startController,
    required this.endController,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      height: 50, // Adjust the height as needed
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.purple, width: 1.0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: startController,
                          decoration: const InputDecoration(
                            hintText: 'Start Time',
                            border: InputBorder.none,
                          ),
                          onTap: () async {
                            // Implement time picker
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              startController.text = pickedTime.format(context);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50, // Adjust the height as needed
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.purple, width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: endController,
                        decoration: const InputDecoration(
                          hintText: 'End Time',
                          border: InputBorder.none,
                        ),
                        onTap: () async {
                          // Implement time picker
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            endController.text = pickedTime.format(context);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
