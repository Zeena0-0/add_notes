import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../database_helper.dart';
import '../models/user.dart';

class AuthenticationProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser; // Add this getter

  bool get isAuthenticated => _currentUser != null;
  // Future<void> setLoginStatus(bool isLoggedIn) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isLoggedIn', isLoggedIn);
  // }

  // Future<bool> getLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('isLoggedIn') ?? false;
  // }
  Future<bool> signUp(
      String username, String password, String phoneNumber) async {
    final dbHelper = DatabaseHelper();

    // Ensure the database is initialized
    await dbHelper.initDatabase();

    final existingUser = await dbHelper.getUserByUsername(username);

    if (existingUser != null) {
      return false;
    }

    final newUser =
        User(username: username, password: password, phoneNumber: phoneNumber);
    final userId = await dbHelper.insertUser(newUser);

    if (userId != null) {
      _currentUser = newUser.copyWith(id: userId);
      // await setLoginStatus(true);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logIn(String username, String password) async {
    final dbHelper = DatabaseHelper();

    await dbHelper.initDatabase();

    final user = await dbHelper.getUserByUsername(username);

    if (user != null && user.password == password) {
      _currentUser = user;
      // await setLoginStatus(true);
      notifyListeners();
      return true;
    } else {
      // Incorrect username or password
      return false;
    }
  }

  Future<bool> checkAuthentication() async {
    // Check if the user is authenticated
    return currentUser != null;
  }

  Future<void> logOut() async {
    _currentUser = null;
    // await setLoginStatus(false);
    notifyListeners();
  }
}
