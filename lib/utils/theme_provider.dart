import 'package:flutter/material.dart';
import 'theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;
  String _selectedSubTheme = 'Verde';

  bool get isDarkTheme => _isDarkTheme;
  String get selectedSubTheme => _selectedSubTheme;

  ThemeData getThemeData() {
    return _isDarkTheme
        ? getDarkTheme(_selectedSubTheme)
        : getLightTheme(_selectedSubTheme);
  }

  // Llama a este método al iniciar la app para cargar preferencias
  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    // Lee valores guardados; si no existen, se mantienen los valores por defecto
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    _selectedSubTheme = prefs.getString('selectedSubTheme') ?? 'Verde';

    notifyListeners();
  }

  void toggleTheme(bool isDark) async {
    _isDarkTheme = isDark;
    notifyListeners();

    // Guardamos el valor en SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _isDarkTheme);
  }

  void changeSubTheme(String subTheme) async {
    _selectedSubTheme = subTheme;
    notifyListeners();

    // Guardamos el valor en SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedSubTheme', _selectedSubTheme);
  }
}
