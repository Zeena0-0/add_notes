import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../theme/app_colors.dart';

class GoogleNavBar extends StatelessWidget {
  final int selectedIndex; // The currently selected tab index
  final ValueChanged<int> onTabChange; // Callback when a tab is selected

  const GoogleNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: GNav(
        onTabChange: onTabChange,
        selectedIndex: selectedIndex,
        rippleColor: Colors.white,
        hoverColor: AppColors.purple,
        haptic: true,
        tabBorderRadius: 15,
        tabShadow: [
          BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 15),
        ],
        gap: 7,
        color: AppColors.purple,
        activeColor: Colors.white,
        iconSize: 20,
        tabBackgroundColor: AppColors.purple,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.add,
            text: 'Add Note',
          ),
          GButton(
            icon: Icons.person_2_rounded,
            text: 'Activity',
          ),
        ],
      ),
    );
  }
}
