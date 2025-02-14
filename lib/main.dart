import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'providers/theme_provider.dart';
import 'utils/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Lector de PDFs',
      theme: themeState.isDarkTheme
          ? getDarkTheme(themeState.selectedSubTheme)
          : getLightTheme(themeState.selectedSubTheme),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}