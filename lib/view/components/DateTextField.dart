// DateTextField.dart

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CustomDateTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final VoidCallback onTap;

  const CustomDateTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50, // Adjust the height as needed
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.purple, width: 1.0),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: labelText,
              border: InputBorder.none,
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
