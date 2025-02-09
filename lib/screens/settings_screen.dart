// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/theme_provider.dart';
import '../screens/theme_settings/theme_selection.dart';
import '../screens/theme_settings/color_selection.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajustes de Tema',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: themeProvider.getThemeData().primaryColor,
        elevation: 0,
      ),
      body: Container(
        // Ocupa todo el ancho y alto de la pantalla
        width: double.infinity,
        height: double.infinity,
        // Puedes cambiar EdgeInsets.only(...) por EdgeInsets.zero si quieres sin bordes
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Sección de selección de tema
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: themeProvider.isDarkTheme ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: themeProvider.isDarkTheme ? Colors.white : Colors.black,
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

            // Sección de selección de colores
            Center(
              child: Text(
                'Seleccione el color del tema:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkTheme ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Desliza para ver más colores',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: themeProvider.isDarkTheme ? Colors.grey : Colors.black54,
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
