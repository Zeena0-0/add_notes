import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database_helper.dart';
import '../models/user.dart';

class AuthenticationProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get isAuthenticated => _currentUser != null;
  final DatabaseHelper dbHelper = DatabaseHelper();

  static const String _isAuthenticatedKey = 'is_authenticated';

  Future<bool> signUp(
      String username, String password, String phoneNumber) async {
    await dbHelper.initDatabase();

    final existingUser = await dbHelper.getUserByUsername(username);

    if (existingUser != null) {
      return false;
    }

    final newUser =
        User(username: username, password: password, phoneNumber: phoneNumber);
    final userId = await dbHelper.insertUser(newUser);

    _currentUser = newUser.copyWith(id: userId);
    _saveAuthenticationState(true);
    notifyListeners();
    return true;
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
    final prefs = await SharedPreferences.getInstance();
    final isAuthenticated = prefs.getBool(_isAuthenticatedKey) ?? false;

    if (isAuthenticated) {
      await _loadUserInformation();
    }

    return isAuthenticated;
  }

  Future<void> logOut() async {
    _currentUser = null;
    _saveAuthenticationState(false);
    notifyListeners();
  }

  Future<void> _saveAuthenticationState(bool isAuthenticated) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isAuthenticatedKey, isAuthenticated);
  }

  Future<void> _loadUserInformation() async {}
}
