import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/settings_screen.dart';
import '../screens/about_screen.dart';
import '../providers/theme_provider.dart';

class MenuDrawer extends ConsumerWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    bool isDark = themeState.isDarkTheme;
    String selectedSubTheme = themeState.selectedSubTheme;

    // Define un mapa de colores para los subtemas
    final Map<String, Color> subThemeColors = {
      'Verde': Colors.green,
      'Azul': Colors.blue,
      'Rojo': Colors.red,
      'Naranja': Colors.orange,
      'Púrpura': Colors.purple,
    };

    // Selecciona el color del subtema, si no existe usa azul por defecto
    Color subThemeColor = subThemeColors[selectedSubTheme] ?? Colors.blue;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.black87 : subThemeColor.withAlpha(204), // 🔹 Se usa el tema y subtema
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16),
                    Icon(
                      Icons.settings,
                      color: isDark ? Colors.white : Colors.black, // 🔹 Cambia según el tema
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Opciones',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black, // 🔹 Cambia según el tema
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.color_lens, size: 28, color: subThemeColor), // 🔹 Aplica el color del subtema
            title: const Text(
              'Ajustes de Tema',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, size: 28),
            title: const Text(
              'Acerca de',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
