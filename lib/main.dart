import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader_app/screens/settings_screen.dart';
import 'providers/theme_provider.dart';
import 'utils/theme_data.dart';
import 'screens/home_screen.dart';
import 'widgets/initial_setup_checker.dart';
//import 'widgets/app_button.dart'; //Se importa app button

//Se crea el provider de forma global.
final navigationProvider = Provider<NavigationService>((ref) => NavigationService());

//Clase que gestiona la navegacion.
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateToHome() {
    navigatorKey.currentState?.pushReplacementNamed('/home');
  }
}

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
      navigatorKey: ref.read(navigationProvider).navigatorKey, //Se usa el provider global.
      title: 'PDF Reader App',
      debugShowCheckedModeBanner: false,
      theme: themeState.isDarkTheme ? darkThemeData : lightThemeData,
      initialRoute: '/',
      routes: {
        '/': (context) => const InitialSetupChecker(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
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
