import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState {
  final bool isDarkTheme;
  final String selectedSubTheme;
  final String locale;
  final Color darkBackgroundColor;
  final Color dropdownTextColor;

  ThemeState({
    required this.isDarkTheme,
    required this.selectedSubTheme,
    required this.locale,
    required this.darkBackgroundColor,
    required this.dropdownTextColor,
  });

  ThemeState copyWith({
    bool? isDarkTheme,
    String? selectedSubTheme,
    String? locale,
    Color? darkBackgroundColor,
    Color? dropdownTextColor,
  }) {
    return ThemeState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      selectedSubTheme: selectedSubTheme ?? this.selectedSubTheme,
      locale: locale ?? this.locale,
      darkBackgroundColor: darkBackgroundColor ?? this.darkBackgroundColor,
      dropdownTextColor: dropdownTextColor ?? this.dropdownTextColor,
    );
  }
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier()
      : super(ThemeState(
          isDarkTheme: false,
          selectedSubTheme: 'Green',
          locale: 'en',
          darkBackgroundColor: Colors.white,
          dropdownTextColor: Colors.black,
        )) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    final selectedSubTheme = prefs.getString('selectedSubTheme') ?? 'Green';
    final locale = prefs.getString('locale') ?? 'en';
    final darkBackgroundColor = prefs.getInt('darkBackgroundColor') != null
        ? Color(prefs.getInt('darkBackgroundColor')!)
        : (isDarkTheme ? Colors.grey[900]! : Colors.white);
    final dropdownTextColor = prefs.getInt('dropdownTextColor') != null
        ? Color(prefs.getInt('dropdownTextColor')!)
        : (isDarkTheme ? Colors.white : Colors.black);

    state = ThemeState(
      isDarkTheme: isDarkTheme,
      selectedSubTheme: selectedSubTheme,
      locale: locale,
      darkBackgroundColor: darkBackgroundColor,
      dropdownTextColor: dropdownTextColor,
    );
  }

  Future<void> toggleTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDarkTheme);
    final darkBackgroundColor = isDarkTheme ? Colors.grey[900]! : Colors.white;
    final dropdownTextColor = isDarkTheme ? Colors.white : Colors.black;
    await prefs.setInt('darkBackgroundColor', darkBackgroundColor.value);
    await prefs.setInt('dropdownTextColor', dropdownTextColor.value);

    state = state.copyWith(
      isDarkTheme: isDarkTheme,
      darkBackgroundColor: darkBackgroundColor,
      dropdownTextColor: dropdownTextColor,
    );
  }

  Future<void> changeSubTheme(String subTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedSubTheme', subTheme);
    state = state.copyWith(selectedSubTheme: subTheme);
  }

  Future<void> setLocale(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale);
    state = state.copyWith(locale: locale);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});