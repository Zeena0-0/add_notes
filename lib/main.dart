import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/view/components/NvigationBarContent.dart';
import 'package:task_manager/view/screens/login.dart';
import 'package:task_manager/view/screens/splash.dart';
import 'core/providers/TaskProvider.dart';
import 'core/providers/authentication_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(), // Initial screen is the splash screen
        routes: {
          '/home': (context) => const HomeScreen(),
          '/login': (context) =>  LoginPage(),
        },
      ),
    );
  }
}

