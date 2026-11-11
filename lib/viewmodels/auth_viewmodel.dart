import 'package:flutter/foundation.dart';

import '../core/app_exceptions.dart';
import '../data/dummy_data.dart';
import '../models/app_user.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  AppUser? _user;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  AppUser? get user => _user;
  String get firstName => _user?.firstName ?? 'Sobat';

  /// Simulasi login dengan dummy data. Mengembalikan true jika berhasil.
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 900));
      final matches = DummyData.users.where(
        (u) => u.email == email.trim().toLowerCase() && u.password == password,
      );
      if (matches.isEmpty) {
        throw const AuthException('Email atau kata sandi salah.');
      }
      _user = matches.first;
      return true;
    } on AuthException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (_) {
      _errorMessage = 'Terjadi kesalahan. Silakan coba lagi.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
