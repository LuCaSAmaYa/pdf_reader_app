//import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Se crea el provider
final initialSetupProvider = StateNotifierProvider<InitialSetupNotifier, InitialSetupState>(
  (ref) => InitialSetupNotifier(),
);

//Se crea la clase que se encargara de gestionar el provider
class InitialSetupNotifier extends StateNotifier<InitialSetupState> {
  InitialSetupNotifier() : super(const InitialSetupState()); // Se inicializa el estado

  void changeSubTheme(String value) {
    state = state.copyWith(selectedSubTheme: value);
  }

  void toggleTheme(bool value) {
    state = state.copyWith(isDarkTheme: value);
  }

  void setLocale(String value) {
    state = state.copyWith(selectedLocale: value);
  }
}

//Se crea la clase que tendra las variables
class InitialSetupState {
  final String selectedSubTheme;
  final bool isDarkTheme;
  final String selectedLocale;

  const InitialSetupState({
    this.selectedSubTheme = 'Green', //Se le da el valor por defecto.
    this.isDarkTheme = false,
    this.selectedLocale = 'es',
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
