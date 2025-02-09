import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'utils/theme_provider.dart';

void main() async {
  // Asegura que se inicialicen los bindings, necesario para await antes de runApp
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Crea una instancia de ThemeProvider
  final themeProvider = ThemeProvider();

  // 2. Carga las preferencias (tema, color) antes de dibujar la interfaz
  await themeProvider.loadPreferences();

  // 3. Provee themeProvider en runApp
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Lector de PDFs',
          theme: themeProvider.getThemeData(),
          home: HomeScreen(onThemeChanged: (String subTheme, bool isDark) {
            themeProvider.changeSubTheme(subTheme);
            themeProvider.toggleTheme(isDark);
          }),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
