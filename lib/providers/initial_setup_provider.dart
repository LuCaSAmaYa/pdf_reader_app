import 'package:flutter_riverpod/flutter_riverpod.dart';

// Clase para el estado del provider.
class InitialSetupState {
  final String selectedSubTheme;
  final bool isDarkTheme;
  final String selectedLocale;

  InitialSetupState({
    this.selectedSubTheme = 'Green',
    this.isDarkTheme = false,
    this.selectedLocale = 'en',
  });

  InitialSetupState copyWith({
    String? selectedSubTheme,
    bool? isDarkTheme,
    String? selectedLocale,
  }) {
    return InitialSetupState(
      selectedSubTheme: selectedSubTheme ?? this.selectedSubTheme,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      selectedLocale: selectedLocale ?? this.selectedLocale,
    );
  }
}
// Provider para controlar el estado de initial_setup_screen
class InitialSetupNotifier extends StateNotifier<InitialSetupState> {
  InitialSetupNotifier() : super(InitialSetupState());

  void changeSubTheme(String subTheme) {
    state = state.copyWith(selectedSubTheme: subTheme);
  }

  void toggleTheme(bool isDark) {
    state = state.copyWith(isDarkTheme: isDark);
  }

  void setLocale(String locale) {
    state = state.copyWith(selectedLocale: locale);
  }
}
//Se crea el provider.
final initialSetupProvider = StateNotifierProvider<InitialSetupNotifier, InitialSetupState>((ref) {
  return InitialSetupNotifier();
});
