import 'package:flutter/material.dart';
import 'package:task_manager/theme/app_text_styles.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: AppTextStyles.headline1,
        ),
      ),
    );
  }
}
