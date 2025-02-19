import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader_app/screens/theme_settings/color_selection.dart';
import 'package:pdf_reader_app/screens/theme_settings/theme_selection.dart';
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton( // <-- Cambia el leading a IconButton
          icon: Icon(Icons.arrow_back, color: themeState.isDarkTheme ? Colors.white : Colors.black), // <-- Cambia el color del Icon
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          appStrings.getString('theme_settings'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: themeState.isDarkTheme ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: themeState.isDarkTheme ? Colors.black : Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: themeState.isDarkTheme ? themeState.darkBackgroundColor : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ... (resto del código sin cambios)
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        appStrings.getString('language'),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: themeState.isDarkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 1.5,
                            child: Radio(
                              value: 'es',
                              groupValue: themeState.locale,
                              onChanged: (String? value) {
                                if (value != null) {
                                  ref.read(themeProvider.notifier).setLocale(value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'es',
                            style: TextStyle(
                              color: themeState.dropdownTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Transform.scale(
                            scale: 1.5,
                            child: Radio(
                              value: 'en',
                              groupValue: themeState.locale,
                              onChanged: (String? value) {
                                if (value != null) {
                                  ref.read(themeProvider.notifier).setLocale(value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'en',
                            style: TextStyle(
                              color: themeState.dropdownTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                // Sección de Tema (Claro/Oscuro)
                Text(
                  appStrings.getString('theme'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeState.isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: ThemeSelection(),
                ),

                const SizedBox(height: 20),

                // Sección de Selección de Color
                Text(
                  appStrings.getString('color_selection'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeState.isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
                const ColorSelection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}