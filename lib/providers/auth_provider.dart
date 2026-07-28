import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader/core/errors/app_exception.dart';
import 'package:news_reader/providers/auth_state.dart';
import 'package:news_reader/providers/repository_providers.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(const AuthState.initial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = const AuthState.loading();
    try {
      final repo = _ref.read(authRepositoryProvider);
      final isLoggedIn = await repo.isLoggedIn();
      if (isLoggedIn) {
        final user = await repo.getCurrentUser();
        if (user != null) {
          state = AuthState.authenticated(user);
          return;
        }
      }
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final repo = _ref.read(authRepositoryProvider);
      final user = await repo.login(email, password);
      state = AuthState.authenticated(user);
    } on ValidationException catch (e) {
      state = AuthState.error(e.message);
    } on AppException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = const AuthState.error('An unexpected error occurred');
    }
  }

  Future<void> logout() async {
    try {
      final repo = _ref.read(authRepositoryProvider);
      await repo.logout();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = const AuthState.error('Failed to logout');
    }
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});
