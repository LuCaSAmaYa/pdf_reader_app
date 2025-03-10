import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/theme_provider.dart';
import '../utils/theme_data.dart';
import 'package:intl/intl.dart';

class InitialSetupScreen extends ConsumerStatefulWidget {
  const InitialSetupScreen({super.key});

  @override
  InitialSetupScreenState createState() => InitialSetupScreenState();
}

class InitialSetupScreenState extends ConsumerState<InitialSetupScreen> {
  String _selectedSubTheme = 'Green';
  bool _isDarkTheme = false;
  String _selectedLocale = 'en';

  @override
  void initState() {
    super.initState();
    _getDefaultLocale();
  }

  Future<void> _getDefaultLocale() async {
    final locale = Intl.systemLocale;
    final languageCode = locale.split('_')[0];
    //No se llama a setState despues de un await.
    _selectedLocale = languageCode == 'es' ? 'es' : 'en';
  }

  //Funcion que guarda las preferencias y cambia de pagina.
  Future<void> _saveAndNavigate(WidgetRef ref) async {
     final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('initialSetupComplete', true);
      await prefs.setString('selectedSubTheme', _selectedSubTheme);
      await prefs.setBool('isDarkTheme', _isDarkTheme);
      await prefs.setString('locale', _selectedLocale);
      //Se obtiene el valor de themeNotifier de forma segura.
      final themeNotifier = await _getThemeNotifier(ref);
      //Se llama a la funcion asincrona para modificar las preferencias del tema
      _applyThemeChanges(themeNotifier);
        // Se navega directamente sin context, utilizando  ref.
       ref.read(navigationProvider).navigateToHome();
  }
  //Funcion que obtiene el valor de themeNotifier
    Future<ThemeNotifier> _getThemeNotifier(WidgetRef ref) async {
        return await Future.microtask(() => ref.read(themeProvider.notifier));
    }

    //Se crea la funcion asincrona que utilizara el ref.
    Future<void> _applyThemeChanges(ThemeNotifier themeNotifier) async {
        themeNotifier.changeSubTheme(_selectedSubTheme);
        themeNotifier.toggleTheme(_isDarkTheme);
        themeNotifier.setLocale(_selectedLocale);
    }


  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isDarkTheme ? Colors.black : Colors.white;
    final boxColor = subThemes[_selectedSubTheme]?.withAlpha((0.3 * 255).round()) ??
        Colors.grey.withAlpha((0.3 * 255).round());
    final textColor = _isDarkTheme ? Colors.white : Colors.black;
    final titleFontSize = 18.0;
    final dropdownBackgroundColor =
        _isDarkTheme ? Colors.black : Colors.grey[200]; // Color de fondo del Dropdown

    final translations = {
      'en': {
        'initialSetup': 'Initial Setup',
        'color': 'Color:',
        'darkTheme': 'Activate dark theme',
        'language': 'Language:',
        'english': 'English',
        'spanish': 'Spanish',
        'saveSettings': 'Save Settings',
        'Green': 'Green',
        'Orange': 'Orange',
        'Teal': 'Teal',
        'Pink': 'Pink',
        'Purple': 'Purple',
        'Red': 'Red',
        'Gray': 'Gray',
        'Cyan': 'Cyan',
        'Indigo': 'Indigo',
        'Emerald Green': 'Emerald Green',
        'Serenity Blue': 'Serenity Blue',
        'Brown': 'Brown',
        'Coral Orange': 'Coral Orange',
        'Royal Blue': 'Royal Blue',
      },
      'es': {
        'initialSetup': 'Configuración Inicial',
        'color': 'Color:',
        'darkTheme': 'Activar tema oscuro',
        'language': 'Idioma:',
        'english': 'Inglés',
        'spanish': 'Español',
        'saveSettings': 'Guardar Configuración',
        'Green': 'Verde',
        'Orange': 'Naranja',
        'Teal': 'Trullo',
        'Pink': 'Rosa',
        'Purple': 'Morado',
        'Red': 'Rojo',
        'Gray': 'Gris',
        'Cyan': 'Cian',
        'Indigo': 'Índigo',
        'Emerald Green': 'Verde Esmeralda',
        'Serenity Blue': 'Azul Serenidad',
        'Brown': 'Marrón',
        'Coral Orange': 'Naranja Coral',
        'Royal Blue': 'Azul Real',
      },
    };

    final currentTranslations = translations[_selectedLocale] ?? translations['en']!;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha((0.5 * 255).round()),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${currentTranslations['color']!} ',
                      style: TextStyle(color: textColor, fontSize: titleFontSize)),
                  DropdownButton<String>(
                    value: _selectedSubTheme,
                    items: subThemes.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(currentTranslations[value]!,
                            style: TextStyle(color: textColor, fontSize: titleFontSize)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      //Solo se modifica el valor.
                      _selectedSubTheme = value!;
                    },
                    hint: Text(currentTranslations['selectColor'] ?? 'Select a color',
                        style: TextStyle(color: textColor, fontSize: titleFontSize)),
                    borderRadius: BorderRadius.circular(10),
                    style: TextStyle(fontSize: titleFontSize, color: textColor),
                    dropdownColor: dropdownBackgroundColor,
                    menuMaxHeight: 200,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    currentTranslations['darkTheme']!,
                    style: TextStyle(fontSize: titleFontSize, color: textColor),
                  ),
                  Switch(
                    value: _isDarkTheme,
                    onChanged: (value) {
                       //Solo se modifica el valor.
                       _isDarkTheme = value;
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${currentTranslations['language']!} ',
                      style: TextStyle(color: textColor, fontSize: titleFontSize)),
                  DropdownButton<String>(
                    value: _selectedLocale,
                    items: [
                      DropdownMenuItem(
                          value: 'en',
                          child: Text('Inglés',
                              style: TextStyle(color: textColor, fontSize: titleFontSize))),
                      DropdownMenuItem(
                          value: 'es',
                          child: Text('Español',
                              style: TextStyle(color: textColor, fontSize: titleFontSize))),
                    ],
                    onChanged: (value) {
                       //Solo se modifica el valor.
                       _selectedLocale = value!;
                    },
                    hint: Text(currentTranslations['selectLanguage'] ?? 'Select a language',
                        style: TextStyle(color: textColor, fontSize: titleFontSize)),
                    borderRadius: BorderRadius.circular(10),
                    style: TextStyle(fontSize: titleFontSize, color: textColor),
                    dropdownColor: dropdownBackgroundColor,
                    menuMaxHeight: 150,
                  ),
                ],
              ),
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: () async {
                    await _saveAndNavigate(ref);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text(currentTranslations['saveSettings']!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//Provider para la navegacion
final navigationProvider = Provider<NavigationService>((ref) => NavigationService());

//Clase para la navegacion
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

   Future<dynamic> navigateToHome() {
    return navigatorKey.currentState!.pushReplacementNamed('/home');
  }
}
