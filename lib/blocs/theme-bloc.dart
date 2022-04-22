import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends StateNotifier<ThemeMode> {
  final _themeKey = 'theme';

  ThemeBloc() : super(ThemeMode.dark) {
    _init();
  }

  Future<void> _init() async {
    state = await _loadTheme();
  }

  Future<void> toggleTheme() async {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _saveTheme(state);
  }

  Future<ThemeMode> _loadTheme() async {
    final preferences = await SharedPreferences.getInstance();
    final themeIndex = preferences.getInt(_themeKey) ?? ThemeMode.dark.index;
    return ThemeMode.values[themeIndex];
  }

  Future<void> _saveTheme(ThemeMode theme) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_themeKey, theme.index);
  }
}
