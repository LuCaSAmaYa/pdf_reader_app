import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import 'theme_settings/theme_selection.dart';
import 'theme_settings/color_selection.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajustes de Tema',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: themeState.isDarkTheme ? Colors.black : Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: themeState.isDarkTheme ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: themeState.isDarkTheme ? Colors.white : Colors.black,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: const ThemeSelection(),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Seleccione el color del tema:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: themeState.isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Desliza para ver más colores',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: themeState.isDarkTheme ? Colors.grey : Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: const ColorSelection(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}