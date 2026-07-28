import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader/core/constants/app_constants.dart';
import 'package:news_reader/providers/service_providers.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final Ref _ref;

  ThemeNotifier(this._ref) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    final localStorage = _ref.read(localStorageServiceProvider);
    final themeIndex = localStorage.get(
      AppConstants.themeKey,
      defaultValue: ThemeMode.system.index,
    ) as int;
    state = ThemeMode.values[themeIndex];
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final localStorage = _ref.read(localStorageServiceProvider);
    await localStorage.save(AppConstants.themeKey, mode.index);
  }
}

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier(ref);
});
