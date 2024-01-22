import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/view/screens/home.dart';
import 'package:task_manager/view/screens/login.dart';
import '../../core/providers/authentication_provider.dart';
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     checkAuthentication();
//   }

//   Future<void> checkAuthentication() async {
//     AuthenticationProvider authProvider = AuthenticationProvider();
//     bool isLoggedIn = await authProvider.getLoginStatus();

//     // Wait for a short duration for a more natural splash screen experience
//     await Future.delayed(Duration(seconds: 2));

//     if (isLoggedIn) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginPage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        // Simulate a delay to show the splash screen for a certain duration
        future: Future.delayed(const Duration(seconds: 2), () async {
          // Use Provider.of with listen: false to prevent unnecessary rebuilds
          return await Provider.of<AuthenticationProvider>(context,
                  listen: false)
              .checkAuthentication();
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while checking authentication
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle errors
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Navigate to the appropriate screen based on authentication status
            return snapshot.data == true ? const HomePage() : LoginPage();
          }
        },
      ),
    );
  }
}
