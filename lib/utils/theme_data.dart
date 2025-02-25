import 'package:flutter/material.dart';

// Temas de datos
final ThemeData lightThemeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  brightness: Brightness.light,
);

final ThemeData darkThemeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
  useMaterial3: true,
  brightness: Brightness.dark,
);

// Subtemas de color
final Map<String, Color> subThemes = {
  'Green': Colors.green,
  'Orange': Colors.orange,
  'Teal': Colors.teal,
  'Pink': Colors.pink,
  'Purple': Colors.purple,
  'Red': Colors.red,
  'Gray': Colors.grey,
  'Cyan': Colors.cyan,
  'Indigo': Colors.indigo,
  'Emerald Green': Colors.greenAccent,
  'Serenity Blue': Colors.lightBlueAccent,
  'Brown': Colors.brown,
  'Coral Orange': Colors.deepOrangeAccent,
  'Royal Blue': Colors.blue,
};