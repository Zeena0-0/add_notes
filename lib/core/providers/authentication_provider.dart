import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database_helper.dart';
import '../models/user.dart';

class AuthenticationProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get isAuthenticated => _currentUser != null;
  final DatabaseHelper dbHelper = DatabaseHelper();

  // Key for storing user authentication state in SharedPreferences
  static const String _isAuthenticatedKey = 'is_authenticated';

  Future<bool> signUp(
      String username, String password, String phoneNumber) async {
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
      _saveAuthenticationState(true);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logIn(String username, String password) async {
    await dbHelper.initDatabase();

    final user = await dbHelper.getUserByUsername(username);

    if (user != null && user.password == password) {
      _currentUser = user;
      _saveAuthenticationState(true);
      notifyListeners();
      return true;
    } else {
      // Incorrect username or password
      return false;
    }
  }

  Future<bool> checkAuthentication() async {
    // Check if the user is authenticated
    final prefs = await SharedPreferences.getInstance();
    final isAuthenticated = prefs.getBool(_isAuthenticatedKey) ?? false;

    if (isAuthenticated) {
      // If authenticated, load user information
      await _loadUserInformation();
    }

    return isAuthenticated;
  }

  Future<void> logOut() async {
    _currentUser = null;
    _saveAuthenticationState(false);
    notifyListeners();
  }

  ///  method to save authentication state in SharedPreferences
  Future<void> _saveAuthenticationState(bool isAuthenticated) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isAuthenticatedKey, isAuthenticated);
  }

  /// Helper method to load user information from SharedPreferences
  Future<void> _loadUserInformation() async {
    final prefs = await SharedPreferences.getInstance();
    // Load user information based on your application's structure
    // For example: _currentUser = User.fromMap(prefs.getString('user_info'));
  }
}
