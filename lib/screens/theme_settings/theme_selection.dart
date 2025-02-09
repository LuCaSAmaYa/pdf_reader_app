// lib/theme_settings/theme_selection.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/theme_provider.dart';

class ThemeSelection extends StatelessWidget {
  const ThemeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.isDarkTheme;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          'Temas:',
          style: TextStyle(
            fontSize: 20, // Aumentado el tamaño de la fuente
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            _buildThemeButton(context, isDark, false, Icons.wb_sunny, 'Claro', screenWidth * 0.80),
            const SizedBox(height: 10),
            _buildThemeButton(context, isDark, true, Icons.nights_stay, 'Oscuro', screenWidth * 0.80),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeButton(BuildContext context, bool isDark, bool darkMode, IconData icon, String text, double width) {
    bool isSelected = (isDark == darkMode);
    return GestureDetector(
      onTap: () => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(darkMode),
      child: Container(
        width: width, // 80% del ancho de la pantalla
        height: 70, // Aumentado el alto
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? (darkMode ? Colors.black : Colors.white) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.redAccent : Colors.grey,
            width: isSelected ? 3 : 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isDark ? Colors.white : Colors.black, size: 28), // Aumentado el tamaño del icono
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                fontSize: 20, // Aumentado el tamaño del texto
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
