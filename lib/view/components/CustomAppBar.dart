import 'package:flutter/material.dart';
import 'package:task_manager/theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.bodyText,
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 2, // Set the elevation as needed
      // Add more properties as needed
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
