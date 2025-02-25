import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'providers/theme_provider.dart';
import 'utils/theme_data.dart';
import 'screens/initial_setup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Future<bool> _isInitialSetupComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('initialSetupComplete') ?? false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    return MaterialApp(
      title: 'PDF Reader App',
      debugShowCheckedModeBanner: false,
      theme: themeState.isDarkTheme ? darkThemeData : lightThemeData,
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder<bool>(
              future: _isInitialSetupComplete(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.data == false) {
                  return const InitialSetupScreen();
                }
                return const HomeScreen();
              },
            ),
        '/home': (context) => const HomeScreen(),
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (supportedLocales.contains(locale)) {
          return locale;
        }
        return supportedLocales.first;
      },
    );
  }
}