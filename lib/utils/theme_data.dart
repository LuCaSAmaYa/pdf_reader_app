// lib/theme_data.dart
import 'package:flutter/material.dart';

// Lista de colores para los subtemas
final Map<String, Color> subThemes = {
  'Verde': Colors.green,
  'Naranja': Colors.orange,
  'Azul Pavo': Colors.teal,
  'Rosado': Colors.pink,
  'Morado': Colors.purple,
  'Rojo': Colors.red,
  'Cyan': Colors.cyan,
  'Indigo': Colors.indigo,
  'Verde Esmeralda': const Color(0xFF50C878),  // Verde moderno
  'Azul Serenity': const Color(0xFF91A8D0),   // Azul moderno
  'Rosa Palo': const Color(0xFFF4C2C2),       // Rosa claro
  'Naranja Coral': const Color(0xFFFF6F61),   // Naranja moderno
};

// Función para obtener el tema claro
ThemeData getLightTheme(String subThemeKey) {
  final Color primaryColor = subThemes[subThemeKey] ?? Colors.blue;
  return ThemeData(
    brightness: Brightness.light,  // Tema claro
    primaryColor: primaryColor,   // Color principal basado en el subtema seleccionado
    appBarTheme: AppBarTheme(backgroundColor: primaryColor),  // Color del AppBar
    iconTheme: IconThemeData(color: primaryColor),  // Color de los íconos
  );
}

// Función para obtener el tema oscuro
ThemeData getDarkTheme(String subThemeKey) {
  final Color primaryColor = subThemes[subThemeKey] ?? Colors.blue;
  return ThemeData(
    brightness: Brightness.dark,  // Tema oscuro
    primaryColor: primaryColor,  // Color principal basado en el subtema seleccionado
    appBarTheme: AppBarTheme(backgroundColor: primaryColor),  // Color del AppBar
    iconTheme: IconThemeData(color: primaryColor),  // Color de los íconos
  );
}
