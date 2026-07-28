import 'dart:convert';

import 'package:news_reader/core/constants/app_constants.dart';
import 'package:news_reader/core/errors/app_exception.dart';
import 'package:news_reader/data/datasources/local_storage_service.dart';
import 'package:news_reader/data/models/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<bool> isLoggedIn();
  Future<void> saveSession(User user);
}

class AuthRepositoryImpl implements AuthRepository {
  final LocalStorageService _localStorage;

  AuthRepositoryImpl({required LocalStorageService localStorage})
      : _localStorage = localStorage;

  @override
  Future<User> login(String email, String password) async {
    // Mock authentication - accept any valid email/password
    if (email.isEmpty || !email.contains('@')) {
      throw const ValidationException(message: 'Invalid email address');
    }
    if (password.length < 6) {
      throw const ValidationException(
          message: 'Password must be at least 6 characters');
    }

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final user = User(email: email, name: _extractName(email));
    await saveSession(user);
    return user;
  }

  @override
  Future<void> logout() async {
    await _localStorage.remove(AppConstants.userKey);
    await _localStorage.save(AppConstants.isLoggedInKey, false);
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final userData = _localStorage.get(AppConstants.userKey);
      if (userData == null) return null;
      final json = jsonDecode(userData as String) as Map<String, dynamic>;
      return User.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return _localStorage.get(AppConstants.isLoggedInKey, defaultValue: false)
        as bool;
  }

  @override
  Future<void> saveSession(User user) async {
    await _localStorage.save(AppConstants.userKey, jsonEncode(user.toJson()));
    await _localStorage.save(AppConstants.isLoggedInKey, true);
  }

  String _extractName(String email) {
    final part = email.split('@').first;
    return part.split('.').map((e) {
      if (e.isEmpty) return e;
      return '${e[0].toUpperCase()}${e.substring(1)}';
    }).join(' ');
  }
}
