import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class SettingsProvider with ChangeNotifier {
  final UserService _userService = UserService();

  ThemeMode _themeMode = ThemeMode.light;
  bool _isLoading = false;
  String? _error;

  ThemeMode get themeMode => _themeMode;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void initializeTheme(String theme) {
    _themeMode = theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<bool> toggleTheme(User currentUser) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newTheme = _themeMode == ThemeMode.light ? 'dark' : 'light';

      await _userService.updateProfile(theme: newTheme);

      _themeMode = newTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<User?> updateProfile({
    String? name,
    String? email,
    String? phone,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = await _userService.updateProfile(
        name: name,
        email: email,
        phone: phone,
      );

      _isLoading = false;
      notifyListeners();
      return user;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _userService.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
