import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/settings_widgets/language_selector.dart'; // Importar LanguageSelector
import '../widgets/settings_widgets/theme_section.dart'; // Importar ThemeSection
import '../widgets/settings_widgets/color_section.dart'; // Importar ColorSection
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';
import '../utils/theme_data.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final appStrings = AppStrings(themeState.locale);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: themeState.isDarkTheme ? Colors.white : Colors.black),
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
        backgroundColor: subThemes[themeState.selectedSubTheme],
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
                const LanguageSelector(), // Utilizar LanguageSelector
                const SizedBox(height: 20),
                const ThemeSection(), // Utilizar ThemeSection
                const SizedBox(height: 20),
                const ColorSection(), // Utilizar ColorSection
              ],
            ),
          ),
        ),
      ),
    );
  }
}
