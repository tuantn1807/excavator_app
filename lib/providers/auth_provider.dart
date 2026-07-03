import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../utils/token_storage.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService;
  UserModel? _user;
  bool _isLoading = false;

  AuthProvider(this.authService);

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      final response = await authService.login(email, password);
      await TokenStorage.saveToken(response.accessToken);
      _user = response.user;
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register(String name, String email, String password) async {
    _setLoading(true);
    try {
      final response = await authService.register(name, email, password);
      await TokenStorage.saveToken(response.accessToken);
      _user = response.user;
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      await authService.logout();
    } finally {
      await TokenStorage.clearToken();
      _user = null;
      notifyListeners();
    }
  }

  Future<void> checkAuth() async {
    final token = await TokenStorage.getToken();
    if (token != null) {
      try {
        _user = await authService.me();
      } catch (e) {
        await TokenStorage.clearToken();
        _user = null;
      }
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
