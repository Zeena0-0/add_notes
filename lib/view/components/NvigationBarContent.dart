
import 'package:flutter/material.dart';
import 'package:task_manager/view/screens/home.dart';

import '../screens/AddTask.dart';
import '../screens/profile.dart';
import 'google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the PageController
    super.dispose();
  }

  void onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: onTabChange,
        physics: const BouncingScrollPhysics(),
        children: const [
          HomePage(),
          AddTaskPage(),
          ProfilePage(),
          // Add more pages as needed
        ],
      ),
      bottomNavigationBar: GoogleNavBar(
        selectedIndex: _selectedIndex,
        onTabChange: onTabChange,
      ),
    );
  }

}