import 'package:flutter/material.dart';

final Map<String, Color> subThemes = {
  'Verde': Colors.green,
  'Naranja': Colors.orange,
  'Azul Pavo': Colors.teal,
  'Rosado': Colors.pink,
  'Morado': Colors.purple,
  'Rojo': Colors.red,
  'Cyan': Colors.cyan,
  'Indigo': Colors.indigo,
  'Verde Esmeralda': const Color(0xFF50C878),
  'Azul Serenity': const Color(0xFF91A8D0),
  'Rosa Palo': const Color(0xFFF4C2C2),
  'Naranja Coral': const Color(0xFFFF6F61),
};

ThemeData getLightTheme(String subThemeKey) {
  final Color primaryColor = subThemes[subThemeKey] ?? Colors.blue;
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(backgroundColor: primaryColor),
    iconTheme: IconThemeData(color: primaryColor),
  );
}

ThemeData getDarkTheme(String subThemeKey) {
  final Color primaryColor = subThemes[subThemeKey] ?? Colors.blue;
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(backgroundColor: primaryColor),
    iconTheme: IconThemeData(color: primaryColor),
  );
}