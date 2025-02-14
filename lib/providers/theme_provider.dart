import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

class ThemeState {
  final bool isDarkTheme;
  final String selectedSubTheme;

  ThemeState({required this.isDarkTheme, required this.selectedSubTheme});

  ThemeState copyWith({bool? isDarkTheme, String? selectedSubTheme}) {
    return ThemeState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      selectedSubTheme: selectedSubTheme ?? this.selectedSubTheme,
    );
  }
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier()
      : super(ThemeState(isDarkTheme: false, selectedSubTheme: 'Verde')) {
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    final selectedSubTheme = prefs.getString('selectedSubTheme') ?? 'Verde';
    state = state.copyWith(isDarkTheme: isDarkTheme, selectedSubTheme: selectedSubTheme);
  }

  Future<void> toggleTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDark);
    state = state.copyWith(isDarkTheme: isDark);
  }

  Future<void> changeSubTheme(String subTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedSubTheme', subTheme);
    state = state.copyWith(selectedSubTheme: subTheme);
  }
}