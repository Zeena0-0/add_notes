import 'package:flutter/material.dart';
import 'package:task_manager/view/screens/login.dart';
import '../../core/providers/authentication_provider.dart';
import '../components/NvigationBarContent.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2), () {
        return AuthenticationProvider().checkAuthentication();
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            return const HomeScreen();
          } else {
            return LoginPage();
          }
        } else {
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
