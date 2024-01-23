import 'package:flutter/material.dart';
import 'package:task_manager/theme/app_colors.dart';
import 'package:task_manager/theme/app_text_styles.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
 final Color? color;
 final Color? textcolor;
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
   this.color = AppColors.purple,
    this.textcolor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 45,
      decoration: BoxDecoration(
        color :color ,
        borderRadius: BorderRadius.circular(20)
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:color, // Set button background color
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyText.copyWith(color:textcolor), // Set text color to white
        ),
      ),
    );
  }
}
