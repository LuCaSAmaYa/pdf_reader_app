import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppStrings {
  final String locale;

  AppStrings(this.locale);

  String getString(String key) {
    if (locale == 'es') {
      return _spanishStrings[key] ?? key;
    } else if (locale == 'en') {
      return _englishStrings[key] ?? key;
    }
    return key;
  }

  String getColorName(String colorKey) {
    if (locale == 'es') {
      return _spanishColorNames[colorKey] ?? colorKey;
    } else if (locale == 'en') {
      return _englishColorNames[colorKey] ?? colorKey;
    }
    return colorKey;
  }

  static const Map<String, String> _spanishStrings = {
    'welcome': 'Bienvenido',
    'select_pdf': 'SELECCIONAR PDF',
    'settings': 'Opciones',
    'about': 'Acerca de',
    'about_text':
        'Aplicación para leer archivos PDF, compartirlos y guardarlos de forma eficiente, sin publicidad. Disfruta de una experiencia limpia y rápida en la gestión de tus documentos.',
    'theme_settings': 'Ajustes de Tema',
    'theme': 'Tema',
    'light': 'Claro',
    'dark': 'Oscuro',
    'color_selection': 'Selección de color',
    'more_info': 'Más información',
    'save': 'Guardar',
    'cancel': 'Cancelar',
    'save_pdf': 'Guardar PDF Como',
    'file_name': 'Nombre del archivo',
    'file_saved': 'Archivo guardado en:',
    'error_saving': 'Error al guardar el archivo:',
    'language': 'Idioma',
    'more_information': 'Más Información',
    'personal_information': 'Información Personal',
    'contact_information': 'Información de Contacto',
    'name': 'Nombre:',
    'email': 'Correo Electrónico:',
    'phone': 'Teléfono:',
    'address': 'Dirección:',
    'app_name': 'Lector de PDFs',
    'initialSetup': 'Configuración Inicial',
    'color': 'Color:',
    'darkTheme': 'Activar tema oscuro',
    'saveSettings': 'Guardar Configuración',
    'pdfReaderNoAds': 'PDF READER SIN ANUNCIOS',
  };

  static const Map<String, String> _englishStrings = {
    'welcome': 'Welcome',
    'select_pdf': 'SELECT PDF',
    'settings': 'Options',
    'about': 'About',
    'about_text':
        'Application to read, share and save PDF files efficiently, without advertising. Enjoy a clean and fast experience in managing your documents.',
    'theme_settings': 'Theme Settings',
    'theme': 'Theme',
    'light': 'Light',
    'dark': 'Dark',
    'color_selection': 'Color selection',
    'more_info': 'More Info',
    'save': 'Save',
    'cancel': 'Cancel',
    'save_pdf': 'Save PDF As',
    'file_name': 'File Name',
    'file_saved': 'File saved in:',
    'error_saving': 'Error saving file:',
    'language': 'Language',
    'more_information': 'More Information',
    'personal_information': 'Personal Information',
    'contact_information': 'Contact Information',
    'name': 'Name:',
    'email': 'Email:',
    'phone': 'Phone:',
    'address': 'Address:',
    'app_name': 'PDF Reader',
    'initialSetup': 'Initial Setup',
    'color': 'Color:',
    'darkTheme': 'Activate dark theme',
    'saveSettings': 'Save Settings',
    'pdfReaderNoAds': 'PDF READER NO ADS',
  };

  static const Map<String, String> _spanishColorNames = {
    'Green': 'Verde',
    'Orange': 'Naranja',
    'Teal': 'Azul Pavo',
    'Pink': 'Rosado',
    'Purple': 'Morado',
    'Red': 'Rojo',
    'Gray': 'Gris',
    'Cyan': 'Cyan',
    'Indigo': 'Indigo',
    'Emerald Green': 'Verde Esmeralda',
    'Serenity Blue': 'Azul Serenity',
    'Rosewood': 'Palo Rosa',
    'Coral Orange': 'Naranja Coral',
    'Royal Blue': 'Azul Real',
  };

  static const Map<String, String> _englishColorNames = {
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
  };

  static const supportedLocales = [
    Locale('es'), // Español
    Locale('en'), // Inglés
  ];

  static const localizationsDelegates = [
    AppStringsDelegate(),
  ];
}

class AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const AppStringsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppStrings.supportedLocales.contains(locale);
  }

  @override
  Future<AppStrings> load(Locale locale) {
    return SynchronousFuture<AppStrings>(AppStrings(locale.languageCode));
  }

  @override
  bool shouldReload(AppStringsDelegate old) {
    return false;
  }
}