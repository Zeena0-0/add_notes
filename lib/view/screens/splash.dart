import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/view/screens/login.dart';
import '../../core/providers/authentication_provider.dart';
import '../components/NvigationBarContent.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2), () {
        return AuthenticationProvider().checkAuthentication();
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            // User is authenticated, navigate to home screen
            return const HomeScreen();
          } else {
            // User is not authenticated, navigate to login screen
            return LoginPage();
          }
        } else {
          // Loading state with CircularProgressIndicator and a message
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}


// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<bool>(
//         // Simulate a delay to show the splash screen for a certain duration
//         future: Future.delayed(const Duration(seconds: 2), () async {
//           // Use Provider.of with listen: false to prevent unnecessary rebuilds
//           return await Provider.of<AuthenticationProvider>(context,
//                   listen: false)
//               .checkAuthentication();
//         }),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Show a loading indicator while checking authentication
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             // Handle errors
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             // Navigate to the appropriate screen based on authentication status
//             return snapshot.data == true ? const HomePage() : LoginPage();
//           }
//         },
//       ),
//     );
//   }
// }
