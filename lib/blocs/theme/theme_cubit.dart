import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    loadTheme();
  }

  static const String _themePrefKey = 'theme_preference_is_dark';

  void loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(_themePrefKey) ?? false;
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    } catch (_) {
      emit(ThemeMode.light);
    }
  }

  void toggleTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = state == ThemeMode.dark;
      await prefs.setBool(_themePrefKey, !isDark);
      emit(isDark ? ThemeMode.light : ThemeMode.dark);
    } catch (_) {
      // Intentionally ignore error if prefs failing
    }
  }
}
